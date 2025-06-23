from checker.basic_rules import check_password_basic
from checker.entropy_calc import calculate_entropy
from checker.breach_check import check_password_breach
from checker.common_password_check import is_common_password

def generate_password_report(password):
    strength,feedback = check_password_basic(password)
    entropy, entropy_strength = calculate_entropy(password)
    common = is_common_password(password)
    breach_count = check_password_breach(password)

    report = {
        "password": password,
        "length": len(password),
        "rule_strength": strength,
        "feedback": feedback,
        "is_common": common,
        "entropy": entropy,
        "entropy_strength": entropy_strength,
        "breach_count": breach_count
    }

    return report