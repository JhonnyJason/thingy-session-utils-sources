# thingy-session-utils 

# Background
Regarding the [Client Service Authentication](https://hackmd.io/DjnHMT0TSlmffXZTsm4f7A?view) - we thought we should have the helper functions in it's own pacakge as it does not directly fit on adding to the [secret-manager-crypto-utils](https://www.npmjs.com/package/secret-manager-crypto-utils).

Originally we only needed the `authCode` function, however because it easily possible we just added a `sessionKey` function as well.

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
import *  as sessUtl from "thingy-session-utils"

## auth code
# sessUtl.createAuthCode is sessUtl.authCodeHex
sessUtl.authCodeHex( seedHex, request ) -> authCodeHex
sessUtl.authCodeHex( StringHex , String || Object ) -> StringHex64

sessUtl.authCodeBytes( seedBytes, request ) -> authCodeHex
sessUtl.authCodeBytes( Uint8Array , String || Object ) -> Uint8Array32

## session key
# sessUtl.createSessionKey is sessUtl.sessionKeyHex
sessUtl.sessionKeyHex( seedHex, request ) -> sessionKeyHex
sessUtl.sessionKeyHex( StringHex, String || Object ) -> StringHex128

sessUtl.sessionKeyBytes( seedBytes, request ) -> sessionKeyBytes
sessUtl.sessionKeyBytes( Uint8Array, String || Object ) -> Uint8Array64

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
