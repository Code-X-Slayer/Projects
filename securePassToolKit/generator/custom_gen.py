import secrets
import string
import random

def generate_custom_password(length=12, use_upper=True, use_lower=True, use_digits=True, use_symbols=True):

    if length<8:
        raise ValueError("Password length should be atleast 8 characters")
    
    character_pool = ""
    required_chars = []

    if use_upper:
        character_pool += string.ascii_uppercase
        required_chars.append(secrets.choice(string.ascii_uppercase))
    if use_lower:
        character_pool += string.ascii_lowercase
        required_chars.append(secrets.choice(string.ascii_lowercase))
    if use_digits:
        character_pool += string.digits
        required_chars.append(secrets.choice(string.digits))
    if use_symbols:
        character_pool += string.punctuation
        required_chars.append(secrets.choice(string.punctuation))
    if not character_pool:
        raise ValueError("At least one character type must be selected")
    
    remaining_length = length - len(required_chars)
    random_chars = [secrets.choice(character_pool) for _ in range(remaining_length)] 

    password_chars = required_chars + random_chars

    random.shuffle(password_chars)
    
    password = "".join(password_chars)
    return password