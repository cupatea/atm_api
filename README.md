# ATM API

This API allows to refill and withdraw banknotes with the following denominations: 1, 2, 5, 10, 25, 50.
## Getting started
As to start following the next steps:

```
$ bundle install
```

```
$ rails db:create db:migrate db:seed
```

**Refill**
   ----
   To refill ATM it's needed to send a hash of banknotes and their quantities.

```
$ curl -X POST \
  http://{server.domain}/api/refill \
  -H 'content-type: application/json' \
  -d '{ "banknotes" : { "25":100, "50":100 }}'
```

 **Success Response**

* **Status:** `200 OK`
* **Content:** `{ "success":true, "result":{ "banknotes": { "25":100, "50":100 }, "amount":7500 } "errors":null }`

 **Error Response**

* **Status:** `422 Unprocessable entity`
* **Content:** `{ "success":false, "result":null, "errors":"Errors description" }`

**Withdraw**
   ----
   To withdraw banknotes it's needed to send amount value.

```
$ curl -X POST \
  http://{server.domain}/api/withdraw \
  -H 'content-type: application/json' \
  -d '{ "amount" : 115 }'
```

 **Success Response**

* **Status:** `200 OK`
* **Content:** `{ "success":true, "result":{ "5":1, "10":1, "50":2 }, "errors": null }`

 **Error Response:**

* **Status:** `422 Unprocessable entity`
* **Content:** `{ "success":false, "result":null, "errors":"Errors description" }`
