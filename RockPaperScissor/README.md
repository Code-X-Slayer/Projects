# Rock Paper Scissors Game

This is a simple Java implementation of the popular game "Rock, Paper, Scissors" where you compete against an AI. The game allows the player to set a target score to win, and the game continues until one player reaches the target.

## Features:
- You can choose the number of points required to win the game.
- The player (human) competes against the AI in multiple rounds.
- The AI randomly selects one of the three choices: Rock, Paper, or Scissors.
- The game ends when either the player or AI reaches the target score.

## How to Play:
1. Upon starting the game, you will be prompted to enter a positive number indicating the points required to win.
2. You will then be prompted to choose between:
   - 0 for Rock
   - 1 for Paper
   - 2 for Scissors
3. The AI will also make a random choice.
4. The outcome will be displayed after each round, showing whether you won, lost, or tied.
5. The game continues until either the player or AI reaches the target score.
6. Once the target score is reached, the winner will be displayed.

## Game Rules:
- Rock beats Scissors.
- Scissors beats Paper.
- Paper beats Rock.
- If both players choose the same option, it results in a tie.

## Prerequisites:
- Java 8 or higher.

## How to Run:
1. Download or clone the repository.
2. Open the `Rock_Paper_Scissor.java` file in your favorite Java IDE or text editor.
3. Compile and run the program.

```bash
javac Rock_Paper_Scissor.java
java Rock_Paper_Scissor
```

4. Follow the on-screen prompts to play the game.

## Example Output:

```
Lets play rock paper Scissors Enter no of points to win (+ve): 3

Enter 0 for Rock 1 for Paper 2 for Scissor : 0

You won by choosing Rock and ai choosing Scissors
Points are You : 1 AI : 0

Enter 0 for Rock 1 for Paper 2 for Scissor : 1

You lost by choosing Paper and ai choosing Scissors
Points are You : 1 AI : 1

Enter 0 for Rock 1 for Paper 2 for Scissor : 2

You tie by choosing Scissors and ai choosing Scissors
Points are You : 1 AI : 1

...

You won
```