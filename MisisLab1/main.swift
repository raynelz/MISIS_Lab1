//
//  main.swift
//  MisisLab1
//
//  Created by Захар Литвинчук on 05.03.2025.
//

import Foundation

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
	
	private func greatestCommonDivisor(_ firstNumber: Int, _ secondNumber: Int) -> Int {
		var remainderA = firstNumber
		var remainderB = secondNumber
		while remainderB != 0 {
			let temporaryRemainder = remainderB
			remainderB = remainderA % remainderB
			remainderA = temporaryRemainder
		}
		return remainderA
	}

	private func leastCommonMultiple(_ firstNumber: Int, _ secondNumber: Int) -> Int {
		return firstNumber / greatestCommonDivisor(firstNumber, secondNumber) * secondNumber
	}

	private func leastCommonMultipleOfThree(_ firstNumber: Int, _ secondNumber: Int, _ thirdNumber: Int) -> Int {
		return leastCommonMultiple(leastCommonMultiple(firstNumber, secondNumber), thirdNumber)
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
			print("Answer: \(correctAnswer)\n")
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

let lcmGame = LCMGame()
lcmGame.start()


class GeometricProgressionGame {
	private let minLength = 5
	private let maxLength = 10
	private let roundsCount = 3
	private var playerName: String = ""

	func start() {
		print("Welcome to the Brain Games!")
		print("May I have your name?", terminator: " ")
		if let name = readLine(), !name.isEmpty {
			playerName = name
			print("Hello, \(playerName)!")
			print("What number is missing in the progression?")
			playRounds()
		} else {
			print("Name cannot be empty. Please restart the game.")
		}
	}


	private func playRounds() {
		for _ in 1...roundsCount {
			let progression = generateGeometricProgression()
			let hiddenIndex = Int.random(in: 0..<progression.count)
			let hiddenValue = progression[hiddenIndex]

			var questionString = "Question:"
			for (index, number) in progression.enumerated() {
				if index == hiddenIndex {
					questionString += " .."
				} else {
					questionString += " \(number)"
				}
			}

			print(questionString)
			print("Answer: \(hiddenValue)\n")
			print("Your answer:", terminator: " ")

			if let userInput = readLine(), let userAnswer = Int(userInput) {
				if userAnswer == hiddenValue {
					print("Correct!")
					print()
				} else {
					print("'\(userAnswer)' is wrong answer ;(. Correct answer was '\(hiddenValue)'.")
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

	private func generateGeometricProgression() -> [Int] {
		let length = Int.random(in: minLength...maxLength)

		let firstTerm = Int.random(in: 1...10)
		let ratio = Int.random(in: 2...5)

		var progression = [Int]()
		var currentTerm = firstTerm

		for _ in 0..<length {
			progression.append(currentTerm)
			currentTerm *= ratio
		}

		return progression
	}
}

let gmGame = GeometricProgressionGame()
gmGame.start()
