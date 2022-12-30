## Lab 1: Web Cache poisoing with an unkeyed header
```
This lab supports the ```X-Forwarded-Host``` header. 
Add this header to javascript endpoint and see there X-Cache: hit
```

## Lab 2: Web Cache poisoing with an unkeyed cookie

```
This lab is poisoing with an unkeyed cookie, while cookie is reflecting on response body: try to cahce poison
fehost=someString"-alert(1)-"someString
Send request until you see the payload in the response and X-Cache: hit in the headers
```

## Lab 3: Web Cahce poisoing with multiple headers

```
This only exploitable when you use multiple headers to craft a malicious request. And This lab supports both the X-Forwarded-Host and X-Forwarded-Scheme headers. 
- Add a cache-buster query parameter and the X-Forwarded-Host header with an arbitrary hostname, such as example.com. 
- Notice that this doesn't seem to have any effect on the response
- Remove the X-Forwarded-Host header and add the X-Forwarded-Scheme header instead. Notice that if you include any value other than HTTPS, you receive a 302 response. 
  The Location header shows that you are being redirected to the same URL that you requested, but using https://. 
 - Add the X-Forwarded-Host: example.com header back to the request, but keep X-Forwarded-Scheme: nothttps as well. 
   Send this request and notice that the Location header of the 302 redirect now points to https://example.com/
```

## Lab 4: Targeted web cache poisoing using an unknown header
