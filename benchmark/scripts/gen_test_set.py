import hashlib,binascii
from Crypto.Hash import MD4
import codecs

f = open("../hashes/test_hash.txt", "w")
ff = codecs.open("../wordlists/test_dico.txt","w", "utf-8")
fff = codecs.open("../hashes/test_hash_password.txt","w", "utf-8")

for i in range(0x10000):
    if i==0 or i==10 or i==13 or (i> 0xd7ff and i< 0xe000):
        pass
    else:
        try:
            word = "t"+chr(i)+"st"
            h = MD4.new()
            h.update(word.encode('utf-16le'))
            ff.write(word+'\n')
            f.write(h.hexdigest()+'\n')
            fff.write(h.hexdigest()+':'+word+':'+str(i)+'\n')
        except Exception as e:
           print(e)
	   
f.close()
ff.close()
fff.close()