# CS221-Final-Project-Group
CS221 Final Project Group Report

This was done with MIPS, using the MARS VM. 
CS221
Below is an example of how the game runs.
Please read [rules.txt] to understand the game rules.
Please read under image about the process of the code.
![image](https://user-images.githubusercontent.com/98365394/236967094-6cefe110-80d6-4ce0-a5af-f6ed8778b5e9.png)


Group Project: BlackJack

Group Members: Nikolas Alvarado, Alexander Banks, Ellmaer Ranjber, Manuel Gonzalez

Description: A modified version of BlackJack; player versus a computer dealer

Rules: 
Player draws a value between 1-11, then Computer draws a value between 1-11
Player continues to draw until they reach 21, choose to fold (stop drawing cards), or bust (exceed 21)
If the Player folds the Dealer will then draw a value between 1-11 and continue to draw until they reach 21, fold, or bust

Player Win Cases:
The Player’s hand achieves a value of 21
The Player folds with a hand closer to 21 than the computer, or the computer busts

Computer Win Cases:
The Player Busts
The Computer folds with a hand closer to 21 than the Player

Tie Case:
Neither Player nor Computer busts and both hand’s reach the same value

Coding Process: We started off with a team discussion to choose our project followed by a session of function and main logic planning, and the rules we would abide by. We initially had a few functions but eventually found ways to replace repetitive code with the addition of more functions. Here is the list of functions and how we used them:

update_hand: The overarching function which calls the other four functions in order to produce, update, and display the player’s and computer’s hand and total
random_int: generates and returns a random value between 1-11 
append_to_array: appends a random value to the player’s or computer’s hand (array)
display_array: displays all the values in the player’s or computer’s hand (array)
get_totals: calculates and displays the total value of the player’s or computer’s hand (array)

Workload: Ellmaer and Alex worked on update_hand, random_int, and the main logic of the code. Nikolas and Manuel worked on append_to_array, display_array, get_totals, and the error catcher. These were the main responsibilities, although we helped each other out along the way.
