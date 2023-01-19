
# DOM Practice analysis

**Dom are based on two terms: 1- Source, 2- Sink**

## Source:
```
Source is the location from which untrusted data is taken by the application (which can be controlled by user input)
and passed on to the sink. 
There are 4 different categories of sources
```

| URL Based Source |  Navigation Based Source | Communication source | Storage Source |
|------------------|--------------------------|----------------------|----------------|
|	location	   | window.name 			  |   Ajax				 |   Cookies      |
|	location.href  | document.referer		  |   Web Sockets		 |  localStorage  |
|	location.search|						  |  Window Message		 |  SessionStorage|
|location.pathname | 						  |						 |				  |

## Sink:
```
Source is the location from which untrusted data is taken by the application (which can be controlled by user input)
and passed on to the sink. 
There are 4 different categories of sources:
```

| Javascript  Execution Sink    |  HTML Execution Sink |  Javascript URI Sink	|                           	
|-----------------|-----------------|-------------------|
| eval()		  |  innerHTML()    |    location       |
| setTimeout()    |  outerHTML()    |    location.href  |
|  setInterval()  | document.write()| location.replace()|
| Function()	  | 				| location.assign() |


### Here an example for Find vulnerable DOM XSS:

```html
<html>
    <p id="name">Hello<p>
    <script>
        var url = new URL(window.location.href);
        var name = url.searchParams.get("name");
        document.getElementById('name').innerHTML = 'Hello ' + name;
    </script>
</html>
```

**In the above example, you can see that the javaScript is searching a GET parameter called “name” and it’s writing its value dynamically into the DOM using innerHTML. So its vulnerable to DOM xss: `name=<svg/onload=alert(1)>`**

**So here, location.href is the source (where the untrusted data is coming from) while innerHTML is the sink (where the payload actually executed).**

# Let's get to out Practice Lab [DOMGoat]:

## Level 1:

```js
let hash = location.hash;
if (hash.length > 1) {
    let hashValueToUse = unescape(hash.substr(1));
    let msg = "Welcome <b>" + hashValueToUse + "</b>!!";
    document.getElementById("msgboard").innerHTML = msg;
}
```

**sink:** `innerHTML`
**source:** `location.hash`
**Solution:** #<svg/onload=alert(1)>

```
Here the `location.hash` is read and specifically unescaped (since modern browsers by default will urlencode the location.hash to avoid DOM XSS) and inserted into the div using innerHTML.
```


## Level 2:

```js
let rfr = document.referrer;
let paramValue = unescape(getPayloadParamValueFromUrl(rfr));
if (paramValue.length > 0) {
    let msg = "Welcome <b>" + paramValue + "</b>!!";
    document.getElementById("msgboard").innerHTML = msg;
} else {
    document.getElementById("msgboard").innerHTML = "Parameter named <b>payload</b> was not found in the referrer.";
}
```

**sink:**`innerHTML`
**source:**`document.referrer`
**Solution:** `https://domgo.at/cxss/example/1?payload=<svg/onload=alert(1)>` #When you click on Exercise 2: you will get alert

__If you look at the HTML source code, you can see the `getPayloadParamValueFromUrl()` defined which extracts the value of the GET parameter named `payload` after click to exercise 2:__
__The click are required insted of directy browsing to the URL because of th source in this exercise that `document.referrer` property.__
__We see from the vulnerable code that if a parameter called payload is available in the URL of the referrer, then this is extracted and passed to the sink.__

 - For real world poc: You can make a html code that redirect to vulnerable.site
```html
<html>
    <body>
        <h2>PoC for Exercise 2 of https://domgo.at</h2>
        <script>
            window.location="https://domgo.at/cxss/example/2"
        </script>
    </body>
</html>

```
`Save this as exercise2.html and host it locally (nginx/Apache/python/node/anything). Navigate to it using http://127.0.0.1/exercise2.html?payload=<svg%20onload=alert(document.domain)>`

## Level 3:

```js
let responseBody = xhr.responseText;
let responeBodyObject = JSON.parse(responseBody);
let msg = "Welcome <b>" + responeBodyObject.payload + "</b>!!";
document.getElementById("msgboard").innerHTML = msg;
```
 
**Sink:**`innerHTML`
**Source**`Ajax`
**Solution:**`<img src=x onerror=alert(1)>`

__The response from the Ajax request (emulated with the user input) is parsed on the client side and is written directly to DOM with innerHTML.__







































