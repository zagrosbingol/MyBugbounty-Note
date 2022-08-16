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

- [ ] SQL injection
- [ ] XSS
- [ ] CSRF
- [ ] Clickjacking
- [ ] DOM-based
- [ ] vCORS
- [ ] XXE
- [ ] SSRF
- [ ] Request smuggling
- [ ] Command injection
- [ ] Server-side template injection
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
	subjack -w subdomain.txt -t 20 -timeout 30 -o subjack1.txt -ssl -a -c "/home/kali/fingerprints.json"

	
