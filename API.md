
Web API
-------

The Irish grammar checker is available as a web service that
other developers can use in their own products. At present
this service powers the [Gramadóir web interface](https://cadhan.com/gramadoir/foirm.html), a CALL platform named [An Scéalaí]() developed
at Trinity College Dublin, as well as command-line clients.

To use the API, simply make a HTTP POST request to the URL
`https://cadhan.com/api/gramadoir/1.0`
with two parameters:

* `teacs`: The Irish language text to be checked, as URL-encoded UTF-8
* `teanga`: The ISO 639-1 code of the language for the error messages. You can
find the list of available languages on the page with the 
[web interface](https://cadhan.com/gramadoir/foirm.html).

The parameters should be sent in the body of the request
(not as part of the URL), and the request should specify
`Content-Type: application/x-www-form-urlencoded`.

The response will be a JSON array of grammatical errors.
Each error is represented by a hash with the following keys:

* `fromy` — the line number within the `teacs` parameter at which the error starts (counting from 0)
* `fromx` — the position within this line at which the error starts (counting from 0)
* `toy` — the line number within the `teacs` parameter at which the error ends (counting from 0)
* `tox` — the position within this line at which the error ends (counting from 0)
* `ruleId` — the Gramadóir error code
* `msg` — user-readable error message, localized into the language specified by the parameter `teanga`
* `context` — the sentence in which the error occurs
* `contextoffset` — the position within the context string where the error starts
* `errortext` — the text of the error itself
* `errorlength` — the length of the `errortext` string

For example, if the value of the `teanga` parameter is "en" (English error messages), and the value of the `teacs` parameter is the following string
(containing embedded newlines):

```
'Achainí agam ort, a Phádraig,
a leanbh,' a deirimse. 'Cuir ar Áit an Puint mé.
Ar hÁit an Phuint.
```

You should get a response resembling the following:

```json
[{
	"ruleId": "Lingua::GA::Gramadoir/SEIMHIU",
	"toy": "1",
	"fromx": "36",
	"errorlength": "8",
	"errortext": "an Puint",
	"context": "'Cuir ar Áit an Puint mé.",
	"tox": "43",
	"contextoffset": "13",
	"fromy": "1",
	"msg": "Lenition missing"
}, {
	"fromy": "2",
	"msg": "Unnecessary prefix /h/",
	"contextoffset": "3",
	"tox": "6",
	"context": "Ar hÁit an Phuint.",
	"errortext": "hÁit",
	"ruleId": "Lingua::GA::Gramadoir/NIAITCH",
	"toy": "2",
	"fromx": "3",
	"errorlength": "4"
}]
```

Details
-------

* The `context` field encodes all ASCII double quotes, ampersands, and greater-than or less-than signs as HTML entities: `&quot;`, `&lt;`, `&gt;`, `&amp;`. The `contextoffset` is counted within the `context` field with these entities.
* The web service supports [CORS requests](http://enable-cors.org/).

HTTP Response Codes
-------------------

* 200 (OK): Successful request
* 400 (Bad Request): Missing parameter in request, unsupported language for error messages, empty source text, source text not encoded as UTF-8, etc.
* 403 (Forbidden): Request from unapproved IP address
* 405 (Method Not Allowed): Only POST requests permitted
* 413 (Payload Too Large): Request larger than 16k bytes
* 500 (Internal Server Error): Translation server failed to process request

Rate Limits
-----------

Since these are pretty low-traffic web sites, I am not currently placing
any rate limits on requests to the API.  Individual requests are capped
at 16k bytes.  I would appreciate an email (kscanne at gmail) if you build
something interesting or useful in any case, and especially so if you expect
to be making many requests.
