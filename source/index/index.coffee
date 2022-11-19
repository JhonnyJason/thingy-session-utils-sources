import { sha256Hex, sha256Bytes, sha512Hex, sha512Bytes } from "secret-manager-crypto-utils"
import { bytesToHex } from "thingy-byte-utils"

############################################################
#region auth code

############################################################
# Hex Version
export createAuthCode = (seedHex, request) ->
    if typeof request != "string" then requestString = JSON.stringify(request)
    entropySource = seedHex + requestString
    return sha256Hex(entropySource)
    
export createAuthCodeHex = createAuthCode

############################################################
# Byte Version
export createAuthCodeBytes = (seedBytes, request) ->
    if typeof request != "string" then requestString = JSON.stringify(request)
    seedHex = bytesToHex(seedBytes)
    entropySource = seedHex + requestString
    return sha256Bytes(entropySource)

#endregion

############################################################
#region session key

############################################################
# Hex Version
export createSessionKey = (seedHex, request) ->
    if typeof request != "string" then requestString = JSON.stringify(request)
    entropySource = seedHex+requestString
    return sha512Hex(entropySource)

export createSessionKeyHex = createSessionKey

############################################################
# Byte Version
export createSessionKeyBytes = (seedBytes, request) ->
    if typeof request != "string" then requestString = JSON.stringify(request)
    seedHex = bytesToHex(seedBytes)
    entropySource = seedHex+requestString
    return sha512Bytes(entropySource)

#endregion
