from pathlib import Path
import hashlib,binascii
import re
from passlib.hash import msdcc
from passlib.hash import nthash
from Crypto.Cipher import DES
from Crypto.Hash import MD5

import codecs
import os
import subprocess

module = 5502

BASE_DIR = Path(__file__).resolve().parent.parent
h_file = BASE_DIR / "hashes" / f"h_m{module}.txt"
hp_file = BASE_DIR / "hashes" / f"h_password_m{module}.txt"
wordlist_file = BASE_DIR / "wordlists" / "dico.txt"
rules_file = BASE_DIR / "rules" / "rules.txt"


if os.name == "nt":
    hashcat_bin = BASE_DIR.parent / "hashcat.exe"
else:
    hashcat_bin = BASE_DIR.parent / "hashcat"


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

words_dico = ["Δâδ123ΔδЖжabПп","Δâδ 123 ΔδЖ жa bПп","Δâδc123cΔδЖcжacbПп","Δâδ123ΔδЖжab","Δâδ123Δδ"]
rules = [":","l","u","c","C","t","T7","32δ","r","d","p2","f","{","}","$Â","^Â","[","]","D5","x56","O56","i6Â","o5Â","'4","sδж","@δ","z3","Z3","q","k","K","*28","L3","R2","+2","-2",".2",",2","y3","Y3","E","ec"]
passwords = ["Δâδ123ΔδЖжabПп","δâδ123δδжжabпп","ΔÂΔ123ΔΔЖЖABПП","Δâδ123δδжжabпп","δÂΔ123ΔΔЖЖABПП",
         "δÂΔ123δΔжЖABпП","Δâδ123ΔΔЖжabПп","Δâδ123ΔδжжabПп","пПbaжЖδΔ321δâΔ","Δâδ123ΔδЖжabΔâδ123ΔδЖжab",
         "Δâδ123ΔδΔâδ123ΔδΔâδ123Δδ","Δâδ123ΔδЖжabbaжЖδΔ321δâΔ","âδ123ΔδЖжabПпΔ","пΔâδ123ΔδЖжabП",
         "ÂΔâδ123ΔδЖжabПп","Δâδ123ΔδЖжabПпÂ","âδ123ΔδЖжabПп","Δâδ123ΔδЖжabП","Δâδ12ΔδЖжabПп",
         "3ΔδЖжa","Δâδ12bПп","Δâδ123ÂΔδЖжabПп","Δâδ12ÂΔδЖжabПп","Δâδ1","Δâж123ΔжЖжabПп","Δâ123ΔЖжabПп",
         "ΔΔΔΔâδ123ΔδЖжabПп","Δâδ123ΔδЖжabПпппп","ΔΔââδδ112233ΔΔδδЖЖжжaabb","âΔδ123ΔδЖжabПп","Δâδ123ΔδЖжba",
         "ΔâЖ123ΔδδжabПп", "Δâδb23ΔδЖжabПп","Δâǚ123ΔδЖжabПп","Δâε123ΔδЖжabПп","Δâγ123ΔδЖжabПп",
         "Δâ1123ΔδЖжabПп","Δââ123ΔδЖжabПп","ΔâδΔâδ123ΔδЖжabПп","Δâδ123ΔδЖжabПпbПп","Δâδ 123 Δδж Жa Bпп",
         "Δâδc123cΔδжcЖacBпп"]

salt = "administrator"
ESS = "ada06359242920a5"
challenge = '9c23f6c094853920'

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

for i in range(len(passwords)):
    try:
        nt = nthash.hash(passwords[i])
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
        
        hf.write(out+'\n')
        hpf.write(out+':'+passwords[i]+':'+rules[i]+'\n')

    except Exception as e:
       print(e)

for word in words_dico:
    wf.write(word+'\n') 
    
hf.close()
hpf.close()
wf.close()
rf.close()


cmd_display = f"{hashcat_bin} {options}"
#print(f"Run hashcat : {cmd_display}")
result = subprocess.run(
    f"{hashcat_bin} {options}",
    shell=True,
    check=False,
    capture_output=True,
    text=True,
    encoding="utf-8",
    errors="replace",
)

combined = (result.stdout or "") + "\n" + (result.stderr or "")


hp_ref = {}
with codecs.open(hp_file, "r", "utf-8") as f:
    for line in f:
        line = line.strip()
        if ":" in line:
            h, p = line.split(":", 1)
            hp_ref[h.strip()] = p


recovered_hashes = set()
recovered_line = None
for line in combined.splitlines():
    m = re.match(r"^(::5V4T:.+[0]{32}:.+:.+:)(.*)$", line.strip())
    if m:
        recovered_hashes.add(m.group(1))
    if "Recovered" in line and "Digests" in line:
        recovered_line = line.strip()


if recovered_line:
    print(f"\n{recovered_line}")


all_hashes = set(hp_ref.keys())
unrecovered = all_hashes - recovered_hashes

print("\n--- hashcat hash recovered output ---")
for h in sorted(recovered_hashes):
    print(f"{h}:{hp_ref[h]}")

if unrecovered:
    print("\n--- Hash and passwords[i] NOT recovered ---")
    for h in sorted(unrecovered):
        print(f"{h}:{hp_ref[h]}")
else:
    print("\nAll hashes have been recovered.")
