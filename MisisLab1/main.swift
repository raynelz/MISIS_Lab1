//
//  main.swift
//  MisisLab1
//
//  Created by Захар Литвинчук on 05.03.2025.
//

import Foundation

// Функция для вычисления наибольшего общего делителя (НОД)
func greatestCommonDivisor(_ firstNumber: Int, _ secondNumber: Int) -> Int {
	var remainderA = firstNumber
	var remainderB = secondNumber
	while remainderB != 0 {
		let temporaryRemainder = remainderB
		remainderB = remainderA % remainderB
		remainderA = temporaryRemainder
	}
	return remainderA
}

// Функция для вычисления наименьшего общего кратного (НОК)
func leastCommonMultiple(_ firstNumber: Int, _ secondNumber: Int) -> Int {
	return firstNumber / greatestCommonDivisor(firstNumber, secondNumber) * secondNumber
}

// Функция для вычисления НОК трех чисел
func leastCommonMultipleOfThree(_ firstNumber: Int, _ secondNumber: Int, _ thirdNumber: Int) -> Int {
	return leastCommonMultiple(leastCommonMultiple(firstNumber, secondNumber), thirdNumber)
}

// Класс для игры НОК
class LCMGame {
	private let maxNumber = 50
	private let roundsCount = 3
	private var playerName: String = ""

	func start() {
		print("Welcome to the Brain Games!")

		print("May I have your name?\n")
		if let name = readLine(), !name.isEmpty {
			playerName = name
			print("Hello, \(playerName)!\n")

			print("Find the smallest common multiple of given numbers.")

			playRounds()
		} else {
			print("Name cannot be empty. Please restart the game.")
		}
	}

	private func playRounds() {
		for _ in 1...roundsCount {
			let firstRandomNumber = Int.random(in: 1...maxNumber)
			let secondRandomNumber = Int.random(in: 1...maxNumber)
			let thirdRandomNumber = Int.random(in: 1...maxNumber)

			let correctAnswer = leastCommonMultipleOfThree(
				firstRandomNumber,
				secondRandomNumber,
				thirdRandomNumber
			)

			print("Question: \(firstRandomNumber) \(secondRandomNumber) \(thirdRandomNumber)")
			print("Your answer:", terminator: " ")

			if let userInput = readLine(), let userAnswer = Int(userInput) {
				if userAnswer == correctAnswer {
					print("Correct!")
					print()
				} else {
					print("'\(userAnswer)' is wrong answer ;(. Correct answer was '\(correctAnswer)'.")
					print("Let's try again, \(playerName)!")
					return
				}
			} else {
				print("Invalid input. Please enter a number.")
				print("Let's try again, \(playerName)!")
				return
			}
		}

		print("Congratulations, \(playerName)!")
	}
}

let game = LCMGame()
game.start()
