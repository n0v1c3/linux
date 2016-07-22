import base64, sys
from Crypto.Cipher import DES3

print 'Number of arguments:', len(sys.argv), ' arguments'
print 'Argument list: ', str(sys.argv)

secretEncode = sys.argv[1] 
passwordEncode = sys.argv[2] 

secret = base64.decodestring(secretEncode)
password = base64.decodestring(passwordEncode)

print DES3.new(secret[:24], DES3.MODE_CBC, secret[24:]).decrypt(password)
