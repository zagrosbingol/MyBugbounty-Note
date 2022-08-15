#											Respnder 
**================================================================================================================**

**Responder is the latest free machine on Hack The Box‘s Starting point Tier 1. It gives us a walkthrough of an NTLM hash capturing when the machine tries to authenticate to a fake malicious SMB server which we will be setting up (in this case). Overall it is a very knowledgeable room and will teach you many things about LFI(local file inclusion) also.**

## How does Responder work!
 
 	Responder can do many different kinds of attacks, but for this scenario, it will set up a malicious SMB server. When the target machine attempts to perform the NTLM authentication to that server, the Responder sends a challenge back for the server to encrypt with the user’s password. When the server responds, the Responder will use the challenge and the encrypted response to generate the NetNTLMv2. While we can’t reverse the NetNTLMv2, we can try many different common passwords to see if any generate the same challenge-response, and if we find one, we know that is the password. This is often referred to as hash cracking, which we’ll do with a program called John The Ripper.



## Let's Solve Challenge

**Task- 1**
	
   How many TCP ports are open on the machine?
   Ans - 2  # scan with namp all port [nmap -sC -sV -p- -T5 $IP]

**Task- 2**
	
   When visiting the web service using the IP address, what is the domain that we are being redirected to?
	Ans - unika.htb

 *When You visti this site: You will see that page will not work, so add IP and with unika.htb in /etc/hosts file ||*

**Task- 3**

   Which scripting language is being used on the server to generate webpages?
	Ans - PHP [You can see page source || wappalyzer : ANalyze Script language]

**Task- 4**

   What is the name of the URL parameter which is used to load different language versions of the webpage?
	Ans - page  [When you change language you see that param.]

**Task- 5**

   Which of the following values for the `page` parameter would be an example of exploiting a Local File Include (LFI) vulnerability: "french.html", "//10.10.14.6/somefile", "../../../../../../../../windows/system32/drivers/etc/hosts", "minikatz.exe"

   Ans- ../../../../../../../../windows/system32/drivers/etc/hosts

 
**Task- 6**
  
  _Which of the following values for the `page` parameter would be an example of exploiting a Remote File Include (RFI) vulnerability: "french.html", "//10.10.14.6/somefile", "../../../../../../../../windows/system32/drivers/etc/hosts", "minikatz.exe"_
  
  *Ans- //10.10.14.6/somefile*

 **Our real work starts from here. Now what we are going to do here is we are going to capture the NTLM (New Technology LAN Manager) hash of our administrator using a tool called Responder**

**Task- 7**

   **What does NTLM stand for?**
   *Ans- New Technology Lan Manager*

**Task- 8**

   _Which flag do we use in the Responder utility to specify the network interface?_
   *Ans- `-I`*
  
  __Run The Tool__
  ___-I → specifying network interface__
   _After the responder starts now navigate to link_

****