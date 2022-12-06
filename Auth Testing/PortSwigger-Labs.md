# PortSwigger: OAuth Lab

## Lab1: Authentication bypass via OAuth implicit flow
**Note**
```
This lab uses an OAuth service to allow users to log in with their social media account. Flawed validation by the client application makes it possible for an attacker to log in to other users' accounts without knowing their password.

To solve the lab, log in to Carlos's account. His email address is carlos@carlos-montoya.net.

You can log in with your own social media account using the following credentials: wiener:peter
```
__Solution:Moral: If you test a application that use OAuth: When I login via Oauth with user-password, to see auth implicit broking or not then I logout, 
but then second time when I relogin it's automatically login without asking user-password and Oauth. That mean While login with our Oauth I can login any 
user account without password.__

## Lab2: Forced OAuth profile linking
