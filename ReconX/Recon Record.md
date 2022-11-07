					Recon Step
===================================================================
Passive Recon:
==============
1. Create a Folder [subdomain,URLs,IPs]

2- Recon-ng Recon Passively for subdomain/ports/ips/params/js

3. Export list from recon-ng and use httpx to create urls/probing (urls/IPs/subdomain)

4. Use isup.sh to filter ips

5. Use Nmap Aggressive Scan & Save to XML to Importt into Bounty platform.

	nmap -iL ips.txt -sSV -A -T4 -O -Pn -v -F -oX nmapOut.xml

  OSINT: (Can be done on RPI)
  Check for Domain Takeover with Takeover M4llok
  $ takeover -l sub_domains.txt -v -t 10

  --> Check for open Amazon S3 buckets, Digital Ocean & Azure
  spiderfoot -m sfp_azureblobstorage,sfp_s3_bucket.spf_digitalocean -s Domain.com -q

  --> Use ParamSpider to Hunt for URLS with parameter automatically form wayback machine - You can also use Arjun, we are switching to Paramspider as part of building a workflow.

   $ python3 paramspider.py --domain Domain.com --exclude woff,png,svg,php,jpg --output @path/param.txt

   Technique to Clean Param form XSS:
   $ sed 's/unix/linux/g' reconfile.txt

7. Use smuggler on URLs list to for http requests that could desync, and posting multiple chunked request to smuggle external sources so the backend server will forward the request with cookies, data to the fornt end server.
(Can be done on RPI)

$ cat list_of_urls.txt | python3 smuggler.py -l /root/location.txt 

8. Use Meg with SecLists Fuzzing for links: (Gather from/Paramspider/gau/Arjun/gf)
	
	For Meg we must remove FUZZ from paramspider and replace with null a character.
	$ sed 's/FUZZ//g' param.txt

	$ meg -v LFI-gracefulsecurity-linux.txt /urlspath/urls.txt /urlspathreplace/urls.txt -s 200

9. JSScanner: 

	Scanning For JavaScript File for endpoint,secret,Hardcoded credentials,IDOR,openredirect etc.
	Paste urls in alive.txt
	Run script Alive.txt - Examine the results using GF advance pattern
	Use command, cat into subdiectories.

	cat * */*.txt 
	cat * */*/.js | gf api-keys

	cat /*/*.txt | gf ssrf | tee ssrf.txt

10. Find XSS Vulnerability form paramspider & xsser

	Since we have param urls from ParamSpider, XSSER need to know to where to inject, and is defined with XSS insted of FUZZ, so here is command to replace this from the result and create a new list to be used to xsser.

	$ sed 's/FUZZ/XSS/g' reconfile.txt

	Now you're ready for scan XSS
	$ xsser -i param_xss.txt 

	github.com/blackhatethicalhacking/bugbountytools


11. API Bug-Bounty Tools Checklist (Part-2)
	-> Astra
	-> crAPI
	-> Curity Identity Server (Community Edition)
	-> JWT_io
	-> OAuth Tools
	-> HAWK Authentication
