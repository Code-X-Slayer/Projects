import hashlib
import requests

def check_password_breach(password):
    sha1 = hashlib.sha1(password.encode('utf-8')).hexdigest().upper()
    prefix = sha1[:5]
    suffix = sha1[5:]

    url = f"https://api.pwnedpasswords.com/range/{prefix}"
    response = requests.get(url)

    if response.status_code != 200:
        raise RuntimeError(f"API ERROR: {response.status_code}")
    
    hashes = (line.split(':') for line in response.text.splitlines())
    for h_suffix, count in hashes:
        if h_suffix == suffix:
            return int(count)

    return 0