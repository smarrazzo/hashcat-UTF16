#hashcat.exe -a 0 -m 32 ..\test\test_rules\h.txt ..\test\rockyou.txt -r ..\test\test_rules\rules.txt --potfile-disable -O --encoding-to=utf16le -u1 -n1 -Y 1 --backend-vector=1  --force --debug-mode=4
#hashcat.exe -a 0 -m 32 ..\test\test_rules\h.txt ..\test\test_rules\dico.txt -r ..\test\OneRuleToRuleThemAll.rule.txt --potfile-disable -O --encoding-to=utf16le -u1 -n1 -Y 1 --backend-vector=1  --force --debug-mode=4


import hashlib,binascii
from Crypto.Hash import MD5
import codecs

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

salt = "123456"
#words1 = []
#words = []

#for i in range(31):
#    words1.append("Δ"*(i+1))
#    words.append("Δ"+"δ"*i)

for word in words:
    try:
        h = MD5.new()
        h.update(word.encode('utf-16le')+salt)
        f.write(h.hexdigest()+":"+salt+'\n')
        ff.write(h.hexdigest()+":"+salt+':'+word+'\n')

    except Exception as e:
       print(e)
#for word in words1:
#    fff.write(word+'\n') 
f.close()
ff.close()
#fff.close()