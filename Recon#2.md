
# Recon Approach Techniques:

### Main Domain:**
	.airbnb.com

### Secondary *.* Domain

	*.atairbnb.com
	*.withairbnb.com
	*.airbnb.org
	*.byairbnb.com
	*.airbnb-aws.com
	*.airbnbopen.com
	*.hoteltonight-test.com

### Single Sub-domain:

	
### Create folder:
   - Subdomain
   - ip
   - urls
   - Param

   **start recon-ng**
     - workspaces list [to see your workespace list/previous workd]
     - workspaces create [$target name]
     - db insert domains [After creating workspace]
     - db insert companies [companies name]
     - modules search hosts [which module you gona use for gather hosts.]
     - modules search domains-host [this for your domain-host that means you gona use as your domain name]
     - modules load recon/domains-hosts/brute_hosts [this mouse you're gona use to brute force all domain hosts. This one wordlist is defalut, if you want custome wordlist then you can use as your choice. Im gona use SecLists. Use: 
     Options set WORDLIST /usr/share/wordlist/SecLists/Discovery/DNS/wordlistName.txt] infor command to see details of your target.
     - run [to start attack]
     - show hosts [to see all gather host]
     - modules load recon/domains-hosts/builtwith [filter duplicates]
     - modules load recon/domains-hosts/certificate-transparency
     - run
     - show hosts
     - modules load recon/domains-hosts/hackertarget
     - run
     - modules load recon/domains-hosts/mx_spf_ip
     - run
     - 

### Check S3,Ocean & Azure buckets:

### Gather parameter using - ParamSpider or Arjun

### Scan JS File and find api-keys and redirect more with gf