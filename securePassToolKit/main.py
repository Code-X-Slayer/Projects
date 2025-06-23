from checker.basic_rules import check_password_basic
from generator.basic_gen import generate_password
from generator.custom_gen import generate_custom_password
from checker.entropy_calc import calculate_entropy
from checker.breach_check import check_password_breach
from checker.common_password_check import is_common_password
from checker.full_report import generate_password_report
from checker.save_report import save_report_to_file

def show_menu():
    print("\n=== SecurePass ToolKit===")
    print("1. Check Password Strength")
    print("2. Generate Password (Basic)")
    print("3. Generate Password (Custom)")
    print("4. Entropy calculation")
    print("5. Breach Check")
    print("6. Common Password check")
    print("7. Full password report")
    print("8. Exit")

def main():
    while True:
        show_menu()
        choice = input("Enter your choice (1-8): ").strip()
        if choice=="1":
            password = input("Enter password to check: ")
            strength, feedback = check_password_basic(password)
            print(f"\nStrength: {strength}")
            if feedback:
                print("Suggestions: ")
                for tip in feedback:
                    print(f" - {tip}")

        elif choice=="2":
            try:
                length =  int(input("Enter desired password length (min 8): "))
                password = generate_password(length)
                print(f"\nGenerated Password: {password}")
            except ValueError as e:
                print(f"\nError: {e}")

        elif choice=="3":
            try:
                length =  int(input("Enter desired password length (min 8): "))
                use_upper = input("Include Uppercase(y/n): ").strip().lower() == 'y'
                use_lower = input("Include Lowercase(y/n): ").strip().lower() == 'y'
                use_digits = input("Include digits(y/n): ").strip().lower() =='y'
                use_symbols = input("Include Symbols(y/n): ") == 'y' 
                password = generate_custom_password(length,use_upper,use_lower,use_digits,use_symbols)
                print(f"\nGenerated Password: {password}")
            except ValueError as e:
                print(f"\nError: {e}")

        elif choice=="4":
            password = input("Enter password to calculate entropy: ")
            entropy, strength = calculate_entropy(password)
            print(f"Entropy of \"{password}\" was {entropy:.2f}")
            print(f"Based on entropy Strength was "+strength)

        elif choice=="5":
            password = input("Enter your password to check data breach: ")
            count = check_password_breach(password)
            if count:
                print(f"Password has appeared in {count} data breaches!")
            else:
                print(f"This password has not been found in any data breaches!")

        elif choice=="6":
            password = input("Enter password to check against common list: ")
            if is_common_password(password):
                print("This is a very common password. Avoid Using It!")
            else:
                print("This password is not among the top common passwords")

        elif choice=="7":
            password = input("Enter password to generate full report: ")
            report = generate_password_report(password)
            print(f"\nPassword Check Report for {report['password']}\n")
            print(f"Length: {report['length']} charcaters")
            print(f"Rule-Based Strength: {report['rule_strength']}")
            print(f"Entropy: {report['entropy']:.2f} → {report['entropy_strength']}")
            print(f"Breached: {report['breach_count']} times")
            print(f"Common Password: {'Yes' if report['is_common'] else 'No'}")

            if report['feedback']:
                print("\nSuggestions:")
                for tip in report['feedback']:
                    print(f" - {tip}")

            if report['breach_count']>0:
                print("Recommendation: Do not use this password - it has been breached!")

            save = input("\nDo you want to save this report to file? (y/n): ").lower()
            if save == "y":
                path = save_report_to_file(report)
                print(f"Report saved to: {path}")


        elif choice=="8":
            print("End")
            break
        else:
            print("Invalid Choice!")

if __name__ == "__main__":
    main()

