# Authentication Testing

## Login Page:
  - Try

## Email confirmation bypass:

  - Try response manupulate to cofirm email
  - while confirm email try this: intecept request to burp and change your mail to another person mail if you cloud get success. 
  
## OTP Relate Testing:

  - If you can manupulate response code to 200 and 302.
  - If you brute force login OTP
    - If WAF try Ip rote extension
    - Read some article and reports about rate limit bypass
  - While you confirming OTP try to change you email to victim email: if you cloud login as another user.

## Password Reset functionality:
  - Try to add Host header in reset password request.
  - While reseting password intercept request to burp and see if you cloud add <a href> tag and see in email if there anything changes. 
