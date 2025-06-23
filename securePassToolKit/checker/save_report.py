import os
import re

def save_report_to_file(report):

    os.makedirs("reports",exist_ok=True)
    safe_password = re.sub(r'[^a-zA-Z0-9]', '_', report['password'])
    filename = f"reports/{safe_password}_report.txt"

    with open(filename,"w") as f:
        f.write(f"Password Report for {report['password']}\n\n")
        f.write(f"Length: {report['length']} characters\n")
        f.write(f"Rule-Based Strength: {report['rule_strength']}\n")
        f.write(f"Entropy: {report['entropy']:.2f} --> {report['entropy_strength']}\n")
        f.write(f"Breached: {report['breach_count']} times\n")
        f.write(f"Common Password: {'Yes' if report['is_common'] else 'No'}\n")

        if report['feedback']:
            f.write("\nSuggestions:\n")
            for tip in report['feedback']:
                f.write(f" - {tip}\n")
        if report['breach_count'] > 0:
            f.write("\n Recommendation: Do NOT use this password — it has been breached!\n")\
            
    return filename