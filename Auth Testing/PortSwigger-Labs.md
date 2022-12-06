# PortSwigger: OAuth Lab

## Lab1: Authentication bypass via OAuth implicit flow
**Note**
```
This lab uses an OAuth service to allow users to log in with their social media account. Flawed validation by the client application makes it possible for 
an attacker to log in to other users' accounts without knowing their password.

To solve the lab, log in to Carlos's account. His email address is carlos@carlos-montoya.net.

You can log in with your own social media account using the following credentials: wiener:peter
```
__Solution:Moral: If you test a application that use OAuth: When I login via Oauth with user-password, to see auth implicit broking or not then I logout, 
but then second time when I relogin it's automatically login without asking user-password and Oauth. That mean While login with our Oauth I can login any 
user account without password.__

## Lab2: Forced OAuth profile linking
**Note**
```
This lab gives you the option to attach a social media profile to your account so that you can log in via OAuth instead of using the normal username and password. 
Due to the insecure implementation of the OAuth flow by the client application, an attacker can manipulate this functionality to obtain access to other users' accounts.

To solve the lab, use a CSRF attack to attach your own social media profile to the admin user's account on the blog website, then access the admin panel and delete Carlos.

The admin user will open anything you send from the exploit server and they always have an active session on the blog website.
You can log in to your own accounts using the following credentials:
- Blog website account: wiener:peter
- Social media profile: peter.wiener:hotdog
```
