def is_common_password(password, filepath="data/common_pass.txt"):
    try:
        with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
            common_passwords = set(line.strip() for line in f)
        return password in common_passwords
    except FileNotFoundError:
        return False
