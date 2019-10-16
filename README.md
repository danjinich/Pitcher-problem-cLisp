# Pitcher-problem-cLisp
Using a breadth first search solves finds the optimal way to solve the pitcher problem

## PROBLEM:
You have 2 pitchers which can hold x and y liters without any markings, you need n liters of water in the x pitcher. The only posible actions are to fill one of the pitchers, to pass water from one pitcher to the other or to empty a pitcher. The optimum solution is defined as theone that requieres less water.

## How to use
After loading the code to lisp you call the function (SOLVE-PITCHERS x y n), where x and y are the size of the pitchers and n is the amount of water wannted.
The code will return a series of numbers that represent instructions:
  1 is fill x
  2 is fill y
  3 is empty x
  4 is empty y
  5 is pass the water from y to x
  6 is pass the water from x to y
  
