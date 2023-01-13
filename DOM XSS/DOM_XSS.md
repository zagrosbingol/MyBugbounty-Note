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
