import secrets
import string

def generate_password(length=12):
    if length < 8:
        raise ValueError("Password length should be atleast 8 characters")

    characters = string.ascii_letters +  string.digits + string.punctuation 
    password = ''.join(secrets.choice(characters) for _ in range(length))
    return password


