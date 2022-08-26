#                                           Bug Bounty TIPs

### Test XSS in JSON body request
    ```
    Bug Bounty Tip To Bypass:

    If you have discovered XSS on the endpoint with JSON Content-Type, open Firefox browser and try to append ;.html to it. 
    You might trick the browser to serve this page as HTML (instead of JSON) and trigger the XSS payload.

    Example: /api/users -> api/users;.html
    ```
    
    
