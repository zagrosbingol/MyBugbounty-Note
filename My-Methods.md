# 									My-Bughunting Methodology


**First Choose a target**
	- **Subdomain Enumeration**
	- **Fuzzing**
	- **Google Dorks**
	- **Github Gorks**
	- **Shodan** _with_ *nrich*

### For manual testing - 

###	1- Subdomain Enumeration :-
-		- **First Step to Find subdoma of target**.
			Use *Subfinder*, *asset-finder*, *findomain*
			*Github Subdomain*
		- **DNS Recon**

		- *Make host file with : httprobe or httpx*.
		- *Use amass*
		- *Find your CNAME of your domain.* [too:dnsx]
		- *See in your host file with httpx : [*status-code*, *technology*, *content-length*]*
		- *Find subdomain on certs.sh website*
		- *See some automation tips on twitter*
		- *Revers whois*
### 2- Fuzzing
-		
		- Use *ffuf* :
		- Dirsearch 
		- Use *scilla* also for Enumeration

### 3- Google Gork:

*	  - *See some google checklist*
	  - *Use faisalahmad site for google dorking*

### 4- Github dork:- 
-
	  - *Use google check-list for Github dork*
	  - *You can use automatino for Github dork*
	  - *Find on github with github-subdomain*

### 5- Shodan:-
-
	   - *Use shodan dork to find subdomain and directories*
	   - *shodan rich*


# _____________________________  Manul Testing ___________________________________________

**See Hacktify Class Note**

**Other Tips that you always remember while Manuly testing>**
	- Web cache poising
	- Header injection

###  Find XSS -
'		- *Fist use burp to find all parameters*
		- *And check parameter if there are any reflection on response browser*
		- *Check with burp intruder to brute force with payload*
		- *Another is making customize paylod*
		- **After this you test some automatino**
			- *Fist find all urls with 'waybackurls'*
			- *Now grep = parameter*
			- *Use kxss - to check what parameter is filter or unfilter*
			- *See some twitter tips*
			- *Try to with header-injection* [Refer: alexa - #if alexa reflect in response then check with payload]

### Subdomain Takeover: 
- *Try a tool name subzy*
- *Try this subjack*
	subjack -w subdomain.txt -t 20 -timeout 30 -o subjack1.txt -ssl -a -c "/home/kali/fingerprints.json"

	