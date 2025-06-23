import math
import string

def calculate_entropy(password):
    pool_size = 0
    used_sets = 0

    if any(c.islower() for c in password):
        pool_size += 26
        used_sets += 1

    if any(c.isupper() for c in password):
        pool_size += 26
        used_sets += 1

    if any(c.isdigit() for c in password):
        pool_size += 10
        used_sets += 1
    
    if any(c in string.punctuation for c in password):
        pool_size += len(string.punctuation)
        used_sets += 1

    if pool_size ==0:
        entropy = 0
    else:
        entropy = len(password) * math.log2(pool_size)

    if entropy < 28:
        strength = "Very Weak"
    elif entropy < 36:
        strength =  "Weak"
    elif entropy < 60:
        strength =  "Reasonable"
    elif entropy < 80:
        strength = "Strong"
    else:
        strength = "Very Strong"

    return entropy,strength

    