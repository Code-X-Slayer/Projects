package GuessTheNumber;

import java.util.Scanner;
import java.util.Random;
class Game{
    //Using Random to get random ans value and storing it in answer var
    Scanner Sc = new Scanner(System.in);
    Random random = new Random();
    int ans;
    int numberOfGuess = 1;
    //Constructor was called with range to gen 1-range random value
    public Game(int n){
        ans = random.nextInt(1,n+1);
    }
    //takeUserInput() to take guess from user
    public int takeUserInput(){
        System.out.print("Enter your guess  : ");
        return Sc.nextInt();
    }
    //isCorrectNumber() to check guess is true
    public boolean isCorrectNumber(int guess){
        if(guess<ans) {
            System.out.println("Entered guess : "+guess+" was smaller than answer");
            return false;
        }
        else if(guess>ans){
            System.out.println("Entered guess : "+guess+" was larger than answer");
            return false;
        }
        else {
            System.out.println("Entered guess : "+guess+" was correct");
            return true;
        }
    }
    //getNumberOfGuess() to get number of entering guess
    public int getNumberOfGuess(){
        return numberOfGuess;
    }
    public void setNumberOfGuess(){
        numberOfGuess++;
    }
}
public class GuessTheNumber {
    public static void main(String[] args) {
        //Create a class Game which allows user to play "Guess the number"
        Scanner Sc = new Scanner(System.in);
        System.out.print("Enter the range (1 - ?) : ");
        int range = Sc.nextInt(),userGuess;
        Game game = new Game(range);
        do{
            System.out.println("Guess number "+game.getNumberOfGuess());
            userGuess = game.takeUserInput();
            game.setNumberOfGuess();
        }
        while(!(game.isCorrectNumber(userGuess)));
        System.out.println("Successfully you guessed it correctly in "+game.getNumberOfGuess()+" number of guesses");
    }
}
