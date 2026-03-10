#hashcat.exe -a 0 -m 5502 ..\test\test_rules\h.txt ..\test\test_rules\dico.txt -r ..\test\test_rules\rules.txt --potfile-disable -O --encoding-to=utf16le -u1 -n1 -Y 1 --backend-vector=1  --force

import hashlib,binascii
from passlib.hash import msdcc
from passlib.hash import nthash
from Crypto.Cipher import DES
from Crypto.Hash import MD5

import codecs

def derivate(PT):
    K = bytearray(b'')
    K.append((PT[0] & 0xfe) | 1);
    K.append(((PT[0] << 7 & 0x80) | (PT[1] >> 1) & 0x7e) | 1)
    K.append(((PT[1] << 6 & 0xc0) | (PT[2] >> 2) & 0x3e) | 1)
    K.append(((PT[2] << 5 & 0xe0) | (PT[3] >> 3) & 0x1e) | 1)
    K.append(((PT[3] << 4 & 0xf0) | (PT[4] >> 4) & 0x0e) | 1)
    K.append(((PT[4] << 3 & 0xf8) | (PT[5] >> 5) & 0x06) | 1)
    K.append(((PT[5] << 2 & 0xfc) | (PT[6] >> 6) & 0x02) | 1)
    K.append(((PT[6] << 1 & 0xfe) | 1))
    return bytes(K)

f = open("h.txt", "w")
ff = codecs.open("h_password.txt","w", "utf-8")
#fff = codecs.open("dico.txt","w", "utf-8")

words = ["Δâδ123ΔδЖжabПп","δâδ123δδжжabпп","ΔÂΔ123ΔΔЖЖABПП","Δâδ123δδжжabпп","δÂΔ123ΔΔЖЖABПП",
         "δÂΔ123δΔжЖABпП","Δâδ123ΔΔЖжabПп","Δâδ123ΔδжжabПп","пПbaжЖδΔ321δâΔ","Δâδ123ΔδЖжabΔâδ123ΔδЖжab",
         "Δâδ123ΔδΔâδ123ΔδΔâδ123Δδ","Δâδ123ΔδЖжabbaжЖδΔ321δâΔ","âδ123ΔδЖжabПпΔ","пΔâδ123ΔδЖжabП",
         "ÂΔâδ123ΔδЖжabПп","Δâδ123ΔδЖжabПпÂ","âδ123ΔδЖжabПп","Δâδ123ΔδЖжabП","Δâδ12ΔδЖжabПп",
         "3ΔδЖжa","Δâδ12bПп","Δâδ123ÂΔδЖжabПп","Δâδ12ÂΔδЖжabПп","Δâδ1","Δâж123ΔжЖжabПп","Δâ123ΔЖжabПп",
         "ΔΔΔΔâδ123ΔδЖжabПп","Δâδ123ΔδЖжabПпппп","ΔΔââδδ112233ΔΔδδЖЖжжaabb","âΔδ123ΔδЖжabПп","Δâδ123ΔδЖжba",
         "ΔâЖ123ΔδδжabПп", "Δâδb23ΔδЖжabПп","Δâǚ123ΔδЖжabПп","Δâε123ΔδЖжabПп","Δâγ123ΔδЖжabПп",
         "Δâ1123ΔδЖжabПп","Δââ123ΔδЖжabПп","ΔâδΔâδ123ΔδЖжabПп","Δâδ123ΔδЖжabПпbПп","Δâδ 123 Δδж Жa Bпп",
         "Δâδc123cΔδжcЖacBпп"]
#words1 = []
#words = []

#for i in range(31):
#    words1.append("Δ"*(i+1))
#    words.append("Δ"+"δ"*i)
salt = "administrator"
ESS = "ada06359242920a5"
challenge = '9c23f6c094853920'

for word in words:
    try:
        nt = nthash.hash(word)
        PT1 = bytes.fromhex(nt[:14])
        PT2 = bytes.fromhex(nt[14:28])
        PT3 = bytes.fromhex(nt[28:]+'0000000000')
        K1 = derivate(PT1)
        K2 = derivate(PT2)
        K3 = derivate(PT3)

        h = MD5.new()
        h.update(bytes.fromhex(challenge)+bytes.fromhex(ESS))
        final_chall = h.digest()[:8]
        
        cipher1 = DES.new(K1, DES.MODE_ECB)
        cipher2 = DES.new(K2, DES.MODE_ECB)
        cipher3 = DES.new(K3, DES.MODE_ECB)
        
        CT1 = cipher1.encrypt(final_chall)
        CT2 = cipher2.encrypt(final_chall)
        CT3 = cipher3.encrypt(final_chall)
        
        resp = CT1+CT2+CT3
        
        out = "::5V4T:"+ESS+"0"*32+":"+resp.hex()+":"+challenge
        
        f.write(out+'\n')
        ff.write(out+':'+word+'\n')

    except Exception as e:
       print(e)
#for word in words1:
#    fff.write(word+'\n') 
f.close()
ff.close()
#fff.close()