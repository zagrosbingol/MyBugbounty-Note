#                     Test wordpress: Bug hunting

**Test wordpress File Upload RCE CVE-2021-24284 via httpx and nuclei**
```bash
httpx -l ulrs.txt -threads 100 -match-string 'wordpress' -o wordpress.txt
```
**If you have many target in txt files**
```bash
cat *.txt | httpx -threads 100 -match-string 'wordpress' -o wordpress.txt
```

**Test the wordpress via nuclei:**
```bash
nuclei -c 100 -id CVE-2021-24284 -list wordpress.txt -o WP-FileUpload-results.txt
```
Or You can scan all wordpress url at at time.
```bash
nuclei -c 100 -l wordpress.txt -t ~/nuclei-templates/ -tags wordpress -o wp-result.txt
```

#### You can also find same methods to find another technologies and scan with nuclei
```symfony,grafana,VMware,confluence,jira,Elasticsearch,WS02,Oracle,tomcat,spingcloud,bigip,drupal,AEM, and more...```

### Elementor Scan 
**This command will help you to identify which target using elementor**
```bash
cat list.txt | cut -d"/" -f3 | awk 'NF{print $0 "/wp-content/plugins/elementor/assets/js/frontend.min.js"}' | httpx -nc -fr -ms "elementor" -er "elementor - v[^\s]*"
```

**Then Run Nuclei**

## Scan with Wpscan 
```bash
wpscan --url https://example.com/ -e vp --api-token <API-KEY> --random-user-agent --ignore-main-redirect --force --disable-tls-check
# Scan wp-content dir --wp-content-dir 
wpscan --url https://example.com/blog/wp-content-dir --wp-content-dir -e vt --api-token <API-KEY> --random-user-agent --ignore-main-redirect --force --disable-tls-check

```
