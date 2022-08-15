
							Recon TIPS for Bug hunting
							-----------------------------

 #1- Subfinder -d domain.com > output.txt
     cat output.txt | grep staging
   - Got subdomains of staging env
   
     site: staging.subdomain.com ext:log
     Got log file listed publicaly


 #2- Use httpx to find active domain or domain using Technology, ip, title etc...

 #3- Use httpx to print page title, tech stack, statuc code and server header including color coding of information.
     $ cat subdomain.txt | httpx -title -td -sc -server

 
 #4- If you found a subdomain 403 Forbidden> Then try this querying - Its CNAME reocord if available you might end up with a 200 response
     $ dig -noall -answer you.subdomain.com

 #5- Open Redirection issue;
     ------------------------
     Payload: ///////////////////////////evil.com
     Vuln URL: example.com/account/login
 
     Valid Parameter URL: 
     https://example.com/account/login/?next=///////////////////////////evil.com


 #6- Easily scarap URLs from a website with curl and grep: 
     $ curl example.com | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | sort -u

 
#7- Authentication bypass:
--------------------------	
     	/api/6798556007/users -> 403 (Forbidden)
     	Bypass Method 1:
	/api//users -> 200 OK

	Bypass Method 2:
	/api\\users -> 200 OK


#8- Subdomain Enumerations with ]
    -----------------------------
	command:
	for ((i=1;i<=1000;i++)); do curl -i -k -s -L -X POST "https://dnsscan.cn/dns.html?keywords=yahoo.com&page=${i}" -d "ecmsfrom=&show=&num=&classid=0&keywords=http://yahoo.com" | grep -oE "[a-zA-Z0-9._-]+\.yahoo.com" | sort -u ; done


#9- Finding with shodan and Nuceli engine:
    -------------------------------------
   $ shodan domain tesla.com | awk '{print $3}' | httpx -silent | nuclei -t ~/nuclei-templates/


#10- Company Sensitive Data in internet Web Archive:
     ----------------------------------------------
     cat subdomains.txt | waybackurls | tee waybackurls.txt | grep -E "\\.xls|\\.xlsx|\\.json|\\.pdf|\\.sql|\\.doc|\\.docx|\\.pptx"


#11- Find js file using httpx: 
  
     $ echo http://target.com | gau | grep '\.js$' | httpx -status-code -mc 200 -content-type | grep 'application/javascript'


#12- If the main endpoint is forbidden we can also check for the backup file
     	
	/blog/wp-config.php => 403 Forbidden
	/blog/wp-config.php.bkp => 200 OK


#13- For WordPress wp-config file, if the main endpoint is forbidden we can also check for the backup file
     	
	redacted[.]com/wp-config.php => 403 Forbidden
	redacted[.]com/wp-config.php_orig => 200 OK


#14- Subdomain Takeover:
    ----------------------
   	1) subfinder -dL all.txt --silent | tee -a subdomains.txt
	2) subjack -w subdomains.txt -ssl | tee -a takeovers | grep -v "Vulnerable"



 #15- If you found a GitLab instance, try to login as root/admin with those credentials:- 
      ----------------------------------------------------------------------------------
	Username: root & pass: 5iveL!fe
	Username: admin & Pass: 5iveL!fe

	You can find it with #shodan :

	org:"Target" http.title:"GitLab"


 #16- If you tried to access /.git folder and got 403 , try to access files  after .git like: /config or /logs/HEAD
      -------------------------------------------------------------------------------------------------------------

	You can test it with multiple hosts via 
 	httpx tool :

	httpx -l subs.txt -path /.git/config --status-code --silent



 #17- If you get directory 403 status code:
 	site/item/sort/1234     ------->   403
	site/item/sort/1234.json ------>   200
 


 #18- ##################### XXXXXXXXXXXXXX ##########################
        
      1- security trails[tool] for passive subdomain enumeratino and checking DNS history for intresting info leaks.
      2- Google dork like { inurl:example.com and intext:company_name } to find sensitive data like company index by Google.
      3- Aquatone is great for recon speaking of useful tools.


 #19- ##############################################################

      Step1- Enumeration subdomains
             - Discovery Directories/path
	     - crawling
		- JS file (Extract urls and see if lib is outdate)
		- HTML form (for fuzzing)
	     - Subdomain host an API
		- Find endpoint
		- Use Arjun

 #20- ############################################################
 
      1- Sniper tool(everything u need)
      2- gitrob or similar tools which does the github recon jobs
      3- shodan and censys

 #21- ############################################################
  
      Use the powerful #ipinfo CLI tool to quickly loot at your target domain's IP space.
      $ subfinder -d hackerone.com | dnsx -resp-only | ipinfo summarize

#########################################################################################################

22- Find Subdomain using ASNs with Amass

    amass intel -org yahoo -max-dns-queries 2500 | awk -F, '{print $1}' ORS=',' | sed 's/,$//' | xargs -P3 -I@ -d ',' amass intel -asn @ -max-dns-queries 2500

###########################################################################################################


23- Finding web server vulnerable to CORS attack:
    
    The following one-liner is able to identify whether any subdomain under the target domain name is vulnerable to cross-origin resource sharing (CORS) based attacks:

cmd$  assetfinder fitbit.com | httpx -threads 300 -follow-redirects -silent | rush -j200 'curl -m5 -s -I -H "Origin: evil.com" {} | [[ $(grep -c "evil.com") -gt 0 ]] && printf "\n3[0;32m[VUL TO CORS] 3[0m{}"' 2>/dev/null


##############################################################################################################

24- Easy Informatino disclosure :

    Using httpx we can easily identify whether a list of hosts is exposing some interesting endpoint such as a server status page, a diagnostic web console or some other info page which could contain sensitive information. Here are three interesting cases:

    1- Check if any of the hosts is exposing the Apache server status page:
        cat hosts.txt | httpx -path /server-status?full=true -status-code -content-length

    2- Check if any of the hosts is exposing the JBoss web console:
        cat hosts.txt | httpx -ports 80,443,8009,8080,8081,8090,8180,8443 -path /web-console/ -status-code -content-length

    3- Check if any of the hosts is exposing the phpinfo debug page:
        cat hosts.txt | httpx -path /phpinfo.php -status-code -content-length -title

=============================================================================================================        

25- 403 Forbidden bypass 🔥🔥

        GET /admin ==> 403 Forbidden
        GET /blablabal/%2e%2e/admin ==> 200 OK
        GET /blablabal/..;/admin ==> 200 OK 
        GET /blablabal/;/admin ==> 200 OK
        GET /blablabal/admin/..;/ ==> 200 OK
        GET /admin?access=1 ==> 200 OK

X-Forwarded-Host:hbwyi0zunythsqlef73y04wb127svh.burpcollaborator.net


=============================================================================================================

26- WP-Scan:
  -  wpscan --url https://blog.aweber.com/ -e vt --api-token xeq9tOSXB7swaG2PeXv1XN8vpV5lJU4nMaLDq7V4P5M  --random-user-agent --ignore-main-redirect --force --disable-tls-checks

  -  wpscan --url https://blog.aweber.com/wp-content --wp-content-dir -e vp --api-token xeq9tOSXB7swaG2PeXv1XN8vpV5lJU4nMaLDq7V4P5M --random-user-agent --ignore-main-redirect --force --disable-tls-checks

  - wpscan --url https://example.com/blog/ -e vp --plugins-detection aggressive --api-token {api_token}
  
===============================================================================================================
27- 
    Quick recon in a one liner 🔥🔥🔥

cat rootDomains.txt | assetfinder | httprobe -c 50 --prefer-https -p http:80 http:8080 https:443 https:8443 http:9000 http:9001 http:9002 http:9003 | aquatone  -out screenshots -threads 50
































































