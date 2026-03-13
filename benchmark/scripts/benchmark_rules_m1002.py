from pathlib import Path
import re
import os
import subprocess

module = 1002

BASE_DIR = Path(__file__).resolve().parent.parent

h_file = BASE_DIR / "hashes" / f"unresolvable_h.txt"
hp_file = BASE_DIR / "hashes" / f"h_password_m{module}.txt"
wordlist_file = BASE_DIR / "wordlists" / "rockyou.txt"



if os.name == "nt":
    hashcat_bin = BASE_DIR.parent / "hashcat.exe"
else:
    hashcat_bin = BASE_DIR.parent / "hashcat"

for i in range(42):
    rules_file = BASE_DIR / "rules" / f"rule_check_{str(i)}"
    options = (
        f"-a 0 -m {module} "
        f"{h_file} {wordlist_file} -r {rules_file} "
        f"--potfile-disable -O --encoding-to=utf16le "
        f"-w 3 -d2 --runtime=5 "
        f"--self-test-disable"
    )

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

    match = re.search(r"Speed\.#\d+\.+:\s+([\d.]+\s+[KMGT]?H/s)", combined)
    if match:
        print(f"Rule {i} Speed: {match.group(1)}")
    else:
        print(f"Rule {i} Speed not found in output")
        print(combined)

