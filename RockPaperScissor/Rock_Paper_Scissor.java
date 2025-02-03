package RockPaperScissor;

import java.util.Random;
import java.util.Scanner;

public class Rock_Paper_Scissor {
    public static void main(String[] args) {
        int human, ai, p1 = 0, p2 = 0, target;
        String[] choice = {"Rock", "Paper", "Scissor"};
        Random r = new Random();
        Scanner Sc = new Scanner(System.in);
        do{
            System.out.println("Lets play rock paper Scissors Enter no of points to win (+ve): ");
            target = Sc.nextInt();
        }
        while(target<1);
        do {
            do {
                System.out.println("\nEnter 0 for Rock 1 for Paper 2 for Scissor : ");
                human = Sc.nextInt();
            }
            while(human<0 || human>2);
            ai = r.nextInt(3);
            if ((human == 0 && ai == 1) || (human == 1 && ai == 2) || (human == 2 && ai == 0)) {
                System.out.printf("\nYou lost by choosing %s and ai choosing %s", choice[human], choice[ai]);
                System.out.printf("\nPoints are You : %d AI : %d\n", p1, ++p2);
            } else if ((ai == 0 && human == 1) || (ai == 1 && human == 2) || (ai == 2 && human == 0)) {
                System.out.printf("You won by choosing %s and ai choosing %s", choice[human], choice[ai]);
                System.out.printf("\nPoints are You : %d AI : %d\n", ++p1, p2);
            } else {
                System.out.printf("You tie by choosing %s and ai choosing %s", choice[human], choice[ai]);
                System.out.printf("\nPoints are You : %d AI : %d\n", p1, p2);
            }
        }
        while (p1 < target && p2 < target);
        if (p1 == target) {
            System.out.printf("\nYou won");
        } else {
            System.out.printf("\nYou lost");
        }
    }
}
