from pathlib import Path
import hashlib, binascii
from Crypto.Hash import SHA256
import codecs
import os
import subprocess

module = 1472

BASE_DIR = Path(__file__).resolve().parent.parent

h_file = BASE_DIR / "hashes" / f"h_m{module}.txt"
hp_file = BASE_DIR / "hashes" / f"h_password_m{module}.txt"
wordlist_file = BASE_DIR / "wordlists" / "dico.txt"
rules_file = BASE_DIR / "rules" / "rules.txt"

# Dossier contenant l'exécutable hashcat : ../../hashcat
HASHCAT_DIR = BASE_DIR.parent / "hashcat"
if os.name == "nt":
    hashcat_bin = HASHCAT_DIR / "hashcat.exe"
else:
    hashcat_bin = HASHCAT_DIR / "hashcat"

salt = "123456"

words_dico = ["Δâδ123ΔδЖжabПп","Δâδ 123 ΔδЖ жa bПп","Δâδc123cΔδЖcжacbПп","Δâδ123ΔδЖжab","Δâδ123Δδ"]
rules = [":","l","u","c","C","t","T7","32δ","r",":d",":p2",":f","{","}","$Â","^Â","[","]","D5","x56","O56","i6Â","o5Â","'4","sδж","@δ","z3","Z3","q","k","K","*28","L3","R2","+2","-2",".2",",2","y3","Y3","E","ec"]
passwords = ["Δâδ123ΔδЖжabПп","δâδ123δδжжabпп","ΔÂΔ123ΔΔЖЖABПП","Δâδ123δδжжabпп","δÂΔ123ΔΔЖЖABПП",
         "δÂΔ123δΔжЖABпП","Δâδ123ΔΔЖжabПп","Δâδ123ΔδжжabПп","пПbaжЖδΔ321δâΔ","Δâδ123ΔδЖжabΔâδ123ΔδЖжab",
         "Δâδ123ΔδΔâδ123ΔδΔâδ123Δδ","Δâδ123ΔδЖжabbaжЖδΔ321δâΔ","âδ123ΔδЖжabПпΔ","пΔâδ123ΔδЖжabП",
         "ÂΔâδ123ΔδЖжabПп","Δâδ123ΔδЖжabПпÂ","âδ123ΔδЖжabПп","Δâδ123ΔδЖжabП","Δâδ12ΔδЖжabПп",
         "3ΔδЖжa","Δâδ12bПп","Δâδ123ÂΔδЖжabПп","Δâδ12ÂΔδЖжabПп","Δâδ1","Δâж123ΔжЖжabПп","Δâ123ΔЖжabПп",
         "ΔΔΔΔâδ123ΔδЖжabПп","Δâδ123ΔδЖжabПпппп","ΔΔââδδ112233ΔΔδδЖЖжжaabb","âΔδ123ΔδЖжabПп","Δâδ123ΔδЖжba",
         "ΔâЖ123ΔδδжabПп", "Δâδb23ΔδЖжabПп","Δâǚ123ΔδЖжabПп","Δâε123ΔδЖжabПп","Δâγ123ΔδЖжabПп",
         "Δâ1123ΔδЖжabПп","Δââ123ΔδЖжabПп","ΔâδΔâδ123ΔδЖжabПп","Δâδ123ΔδЖжabПпbПп","Δâδ 123 Δδж Жa Bпп",
         "Δâδc123cΔδжcЖacBпп"]

options = (
    f"-a 0 -m {module} "
    f"{h_file} {wordlist_file} -r {rules_file} "
    f"--potfile-disable -O --encoding-to=utf16le -u1 -n1 -Y 1 "
    f"--backend-vector=1 --force"
)
hf = open(h_file, "w")
hpf = codecs.open(hp_file,"w", "utf-8")
wf = codecs.open(wordlist_file,"w", "utf-8")
rf = codecs.open(rules_file,"w", "utf-8")

for rule in rules:
    rf.write(rule+'\n')

for password in passwords:
    try:
        h = SHA256.new()
        h.update(password.encode('utf-16le'))
        hf.write(h.hexdigest()+'\n')
        hpf.write(h.hexdigest()+':'+password+'\n')

    except Exception as e:
       print(e)

for word in words_dico:
    wf.write(word+'\n') 
    
hf.close()
hpf.close()
wf.close()
rf.close()

# Lancer hashcat avec la variable options
cmd_display = f"{hashcat_bin} {options}"
print(f"Lancement de hashcat : {cmd_display}")
subprocess.run(f"{hashcat_bin} {options}", shell=True, check=True)
