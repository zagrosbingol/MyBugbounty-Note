#                  Request Smuggling

**Theory**
## How do HTTP request smuggling vulnerability arise?

**Most HTTP request smuggling vulnerabilities arise because the HTTP specification provides two different ways to specify where a request ends:** 
**the Content-Length header and the Transfer-Encoding header.**
**The Content-Length header is straightforward: it specifies the length of the message body in bytes. For example:**
     
      POST /search HTTP/1.1
      Host: normal-website.com
      Content-Type: application/x-www-form-urlencoded
      Content-Length: 11

      q=smuggling
 **The Transfer-Encoding header can be used to specify that the message body uses chunked encoding. This means that the message body contains 
 **one or more chunks of data. Each chunk consists of the chunk size in bytes (expressed in hexadecimal), followed by a newline, followed by 
 the chunk contents. The message is terminated with a chunk of size zero. For example:**    
 
      POST /search HTTP/1.1
      Host: normal-website.com
      Content-Type: application/x-www-form-urlencoded
      Transfer-Encoding: chunked

      b
      q=smuggling
      0     

## How to perform HTTP request smuggling attack

**Request smuggling attacks involve placing both the ```Content-Length``` header and the ```Transfer-Encoding``` header into a single HTTP request** 
**and manipulating these so that the front-end and back-end servers process the request differently. The exact way in which this is done** 
**depends on the behavior of the two servers:**

 -   CL.TE: the front-end server uses the ```Content-Length``` header and the back-end server uses the ```Transfer-Encoding``` header.
 -   TE.CL: the front-end server uses the ```Transfer-Encoding``` header and the back-end server uses the ```Content-Length``` header.
 -   TE.TE: the front-end and back-end servers both support the ```Transfer-Encoding``` header, but one of the servers can be induced not to 
     process it by obfuscating the header in some way.

## CL.TE Vulnerability
**Here, the front-end server uses the Content-Length header and the back-end server uses the Transfer-Encoding header.**
**We can perform a simple HTTP request smuggling attack as follows: **

      POST / HTTP/1.1
      Host: vulnerable-website.com
      Content-Length: 13
      Transfer-Encoding: chunked

      0

      SMUGGLED
**The front-end server processes the Content-Length header and determines that the request body is 13 bytes long, up to the end of SMUGGLED. **
**This request is forwarded on to the back-end server.**

**The back-end server processes the Transfer-Encoding header, and so treats the message body as using chunked encoding. It processes the first chunk, 
which is stated to be zero length, and so is treated as terminating the request. The following bytes, SMUGGLED, are left unprocessed, 
and the back-end server will treat these as being the start of the next request in the sequence. **


# Lab1: HTTP request smuggling, basic CL.TE vulnerability














