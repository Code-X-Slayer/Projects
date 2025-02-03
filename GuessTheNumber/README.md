
# Guess The Number Game

This is a simple "Guess the Number" game implemented in Java, where the player needs to guess a randomly generated number within a given range. The program will guide the player by indicating whether their guess was too high, too low, or correct. The game continues until the player guesses the correct number.

## Features:
- The player is prompted to enter a range (e.g., 1 to N).
- The computer randomly generates a number within the specified range.
- The player is repeatedly asked to guess the number, with feedback provided for each guess.
- The number of guesses is tracked, and the game ends when the correct number is guessed.

## How to Play:
1. Upon starting the game, you will be asked to enter the range for the number. For example, entering `100` means the number will be between 1 and 100.
2. You will then be prompted to guess the number.
3. After each guess, the game will let you know if the number you guessed is too low or too high.
4. The game continues until you guess the correct number.
5. The number of attempts it took to guess the number will be displayed at the end.

## Example Output:

```
Enter the range (1 - ?) : 50
Guess number 1
Enter your guess  : 25
Entered guess : 25 was smaller than answer
Guess number 2
Enter your guess  : 40
Entered guess : 40 was larger than answer
Guess number 3
Enter your guess  : 30
Entered guess : 30 was correct
Successfully you guessed it correctly in 3 number of guesses
```

## How to Run:
1. Download or clone the repository.
2. Open the `GuessTheNumber.java` file in your favorite Java IDE or text editor.
3. Compile and run the program.

```bash
javac GuessTheNumber.java
java GuessTheNumber
```

4. Follow the on-screen prompts to play the game.

## License:
This project is open source and free to use.
