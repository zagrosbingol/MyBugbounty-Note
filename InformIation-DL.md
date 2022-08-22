#                     Gather some information about target

### Find in JSFile
```bash
subfinder -d example.com -silent | httpx -silent | subjs -o js.txt
gau -subs example.com | grep ".js$" | sort -u | tee gau-js.txt
waybackurls example.com | grep ".js$" | sort -u | tee waybackJS.txt
# Final to sort in one file
cat *.txt | sort -u | tee JSFile.txt
```
**Now time for analyze into JSFile**
```bash 
cat JSFile.txt | xargs -I% bash -c 'curl -sk "%" | grep -w "*.s3.amazonaws.com"' | tee s3bucket.txt
cat JSFile.txt | xargs -I% bash -c 'curl -sk "%" | grep -w "*.s3.us-east-2.amazomaws.com"' | tee s3-east-bucket.txt
cat JSFile.txt | xargs -I% bash -c 'curl -sk "%" | grep -w "s3.amazomaws.com/*"' | tee s3-bucket-all.txt
cat JSFile.txt | xargs -I% bash -c 'curl -sk "%" | grep -w "s3.us-east2.amazomaws.com/*"' | tee s3-east-all.txt

# After getting buckets then find for bucket name
cat *.txt | sed 's/s3.us-east2.amazonaws.com//' | tee bucket-name.txt

#Let's automate the AWS s3 bucket scanning process for write and delete permission.
cat bucket-name.txt | xargs -I% sh -c 'aws s3 cp test.txt s3://%2>&1 | grep "upload" && echo "Vulnerable bucket takeover"'

cat bucket_name.txt |xargs -I% sh -c 'aws s3 rm test.txt s3://%/test.txt 2>&1 | grep "delete" && echo "Vulnerable bucket takeover by cli %"'

```
