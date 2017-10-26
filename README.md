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

 **Method `POST`**
 **Path `/refill`**
 **Data`{ "banknotes" : { "25":100, "50":100 }}`**

 **Success Response**

* **Status:** `200 OK`
* **Content:** `{ "success": true, "result": 7500 }`

 **Error Response**

* **Status:** `422 Unprocessable entity`
* **Content:** `{ "success": false, "result": "Error description" }`

**Withdraw**
   ----
   To withdraw banknotes it's needed to send amount value.

**Method `POST`**
**Path `/withdraw`**
**Data`{"amount" : 115 }`**

 **Success Response**

* **Status:** `200 OK`
* **Content:** `{ "success": true, "result": { "5": 1, "10": 1, "50": 2" }`

 **Error Response:**

* **Status:** `422 Unprocessable entity`
* **Content:** `{ "success": false, "result": "Error description" }`
