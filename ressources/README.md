# thingy-session-utils 

# Background
On some time after developing on the [Secret Management](https://hackmd.io/PZjpRfzPSBCqS-8K54x2jA) path the idea to use these same cryptographic primitives (Curve25519 + AES and SHA-2) for all all [Client Service Authentication](https://hackmd.io/DjnHMT0TSlmffXZTsm4f7A?view) become quite stubborn.

This lead to a few ways on how to build Sessions - this convenience library is their implementation.



# Usage

Requirements
------------
- ESM importability

Installation
------------
Current git version:
```
npm install git+https://github.com/JhonnyJason/thingy-session-utils-output.git
```

Npm Registry:
```
npm install thingy-session-utils
```


Current Functionality
---------------------
- create AuthCodes
- create SessionKeys

```coffee
import * as sessUtl from "thingy-session-utils"

## auth code
# sessUtl.createAuthCode is sessUtl.createAuthCodeHex
sessUtl.createAuthCodeHex( seedHex, request ) -> authCodeHex
sessUtl.createAuthCodeHex( StringHex , String || Object ) -> StringHex64

sessUtl.createAuthCodeBytes( seedBytes, request ) -> authCodeHex
sessUtl.createAuthCodeBytes( Uint8Array , String || Object ) -> Uint8Array32

## session key
# sessUtl.createSessionKey is sessUtl.createSessionKeyHex
sessUtl.createSessionKeyHex( seedHex, request ) -> sessionKeyHex
sessUtl.createSessionKeyHex( StringHex, String || Object ) -> StringHex128

sessUtl.createSessionKeyBytes( seedBytes, request ) -> sessionKeyBytes
sessUtl.createSessionKeyBytes( Uint8Array, String || Object ) -> Uint8Array64

```

## AuthCodes
Authentication Codes are generated from an commonly known `seed` - usually the shared Secret from the client and services keypairs, hashed with a commonly known context. The `seed` stays the same for the whole session.
It should be generated in such a way that it is always different for every session.

The other part is the `request` - which we may pass as string or as object.
Preferrably use an existing string from somewhere. Usually every request has arrived as string and the conversion is quite costly for the performance.

This request is the last processed request or better said the request body - it must be exactly the same for client and service. You may also take  it as "last processed authenticated data-chunk" for e.g. in Websockets.

At best use the Hex version, it even seems to be faster ;-)

## SessionKeys
This is for the situation when we want to encrypt our session. Usually unnecessary because we use HTTPS anyways ;-).

Depending how far your <s>knowledge</s> trust goes, and depending on the situation it still makes sense of course.

The session keys are 64bytes = 512bit (from sha512). This way you may directly use it for `secUtl.symmetricEncryptHex(content, sessionKey)`.

Consider prepending a salt as from `secUtl.createRandomLengthSalt()` to mitigate known-plaintext attacks.

---

# Further steps

- gather more functionality to put in here
- performance optimizations?
- ...


All sorts of inputs are welcome, thanks!

---

# License
[Unlicense JhonnyJason style](https://hackmd.io/nCpLO3gxRlSmKVG3Zxy2hA?view)
