//
//  main.swift
//  hello-world-notepad
//
//  Created by Berk Çohadar on 9/5/21.
//

import Foundation

// print
print("Hello, World!")
print("Hello, I'm Berk's Swift Coding. Welcome to Apple OS!")

// variables
var num1 = 5
var num2 = 3
print("num1 * num2 = ",num1*num2)

var num3 = num1 * num2
let num4 = 8 // num4 = 5 => Error occurs cuz of "let"
print(num1)
print(num2)
print(num3)
print(num4)

var boolF = false
var boolT = true

// Arrays
var favGames = ["League of Legends", "Valorant", "CS Go"]
var exampleArr = [1,"2",true,["number":4]] as [Any]
print("Array length", favGames.count)
print(exampleArr)

// Dict
var favGamesDict = ["MOBA":favGames[0],"FPS":favGames[1]]
print(favGamesDict["MOBA"] as Any)

// Loops
for _ in 0...1{  // 0 - 1
    print("\n")
}

for game in favGames{
    if game != favGames[2]{
        print(game)
    }
}

// Functions
func printMe(input: String){
    print("This function prints", input)
}
printMe(input: "Me!!!")

func sumFunc (x: Int, y: Int) -> Int{
    return x+y
}

var result = sumFunc(x: 3, y: 5)
printMe(input: String(result))


// Optionals
var temp : String? // ? -> Uncertain. Not mandatory, temp can be String.
var temp2 : String! // ! -> Certain. We are sure temp2 is String.

// Inputs
print("\nTell me a joke...\n")
if let str = readLine() {
   print(str+"? Hahaha...")
}

// APIs



