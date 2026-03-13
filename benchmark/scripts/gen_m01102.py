from pathlib import Path
import hashlib, binascii
import re
from passlib.hash import msdcc
import codecs
import os
import subprocess

module = 1102

BASE_DIR = Path(__file__).resolve().parent.parent

h_file = BASE_DIR / "hashes" / f"h_m{module}.txt"
hp_file = BASE_DIR / "hashes" / f"h_password_m{module}.txt"
wordlist_file = BASE_DIR / "wordlists" / "dico.txt"
rules_file = BASE_DIR / "rules" / "rules.txt"


if os.name == "nt":
    hashcat_bin = BASE_DIR.parent / "hashcat.exe"
else:
    hashcat_bin = BASE_DIR.parent / "hashcat"

salt = "123456"
user = "administrator"

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

options = (
    f"-a 0 -m {module} "
    f"{h_file} {wordlist_file} -r {rules_file} "
    f"--potfile-disable -O --encoding-to=utf16le -u1 -n1 -Y 1 "
    f"--backend-vector=1 --force"
    f"--self-test-disable"
)
hf = open(h_file, "w")
hpf = codecs.open(hp_file,"w", "utf-8")
wf = codecs.open(wordlist_file,"w", "utf-8")
rf = codecs.open(rules_file,"w", "utf-8")

for rule in rules:
    rf.write(rule+'\n')

for i in range(len(passwords)):
    try:
        h = msdcc.hash(passwords[i], user=user)
        hf.write(h+':'+user+'\n')
        hpf.write(h+':'+user+':'+passwords[i]+':'+rules[i]+'\n')

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
    m = re.match(r"^([a-fA-F0-9]+):(.*)$", line.strip())
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

