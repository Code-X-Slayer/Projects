# 🔐 SecurePass ToolKit – Beyond a Basic Password Checker

Unlike typical one-file Python password strength checkers, **SecurePass ToolKit** goes way beyond.  
This is a **modular, CLI-based, real-world Python application** that checks passwords not just for structure — but for **security in the real world**.

---

## ✨ Key Highlights

✅ **Rule-Based Strength Check**  
- Checks for length, uppercase/lowercase letters, digits, symbols  
- Gives feedback on what's missing

📊 **Entropy Calculator**  
- Uses information theory to measure unpredictability  
- Shows how mathematically strong your password really is

🕵️‍♂️ **Data Breach Check (Live API)**  
- Uses [HaveIBeenPwned API](https://haveibeenpwned.com/API/v3) to see if your password is leaked online  
- Uses secure **k-Anonymity model** (SHA-1 prefix search)

📂 **Common Password Check (10,000+ List)**  
- Compares your password to a massive list of commonly used weak passwords

📝 **Full Password Report Generator**  
- Generates detailed, printable reports with all the above insights  
- Saves report to a `.txt` file (optional)

🔐 **Secure Password Generator**  
- Basic or custom password generation  
- Choose length, symbols, digits, uppercase/lowercase

📁 **Clean Folder Structure**  
- Modular code and easy to maintain or extend

---

## 📁 Project Structure
```
securePassToolKit/
├── checker/                  # Password checking modules (rules, breach, entropy, report)
│   ├── basic_rules.py
│   ├── breach_check.py
│   ├── common_password_check.py
│   ├── entropy_calc.py
│   ├── full_report.py
│   └── save_report.py
│
├── generator/                # Password generation logic
│   ├── basic_gen.py
│   └── custom_gen.py
│
├── data/                     # Common password list (10k passwords)
│   └── common_pass.txt
│
├── reports/                  # Auto-generated password reports (.txt)
│
├── utils/                    # For future utilities (currently empty)
│
├── main.py                   # CLI entry point
├── requirements.txt          # Python dependencies (only 'requests')
├── .gitignore
└── README.md
```
---

## 🚀 How to Run

```bash
# Clone the repo
git clone https://github.com/Code-X-Slayer/projects/tree/main/securePassToolKit
cd passwordTool

# Install dependencies
pip install -r requirements.txt

# Run the CLI app
python main.py
