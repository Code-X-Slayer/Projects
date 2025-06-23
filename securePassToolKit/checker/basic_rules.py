import string

def check_password_basic(password):
    score = 0
    feedback = []

    if len(password)>=8:
        score+=1
    else:
        feedback.append("Password should be atleast 8 characters")
    
    if any(c.islower() for c in password):
        score+=1
    else:
        feedback.append("Include atleast one lowercase letter")
    
    if any(c.isupper() for c in password):
        score+=1
    else:
        feedback.append("Include atleast one uppercase letter")
    
    if any(c.isdigit() for c in password):
        score+=1
    else:
        feedback.append("Include atleast one digit")
    
    if any(c in string.punctuation for c in password):
        score+=1
    else:
        feedback.append("Include atleast one special character (!@#$ etc..)")

    if score==5:
        strength = "Strong"
    elif score>=3:
        strength = "Moderate"
    else:
        strength = "Weak"

    return strength,feedback