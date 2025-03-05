//
//  main.swift
//  MisisLab1
//
//  Created by Захар Литвинчук on 05.03.2025.
//

import Foundation

// Функция для вычисления наибольшего общего делителя (НОД)
func gcd(_ a: Int, _ b: Int) -> Int {
	var a = a
	var b = b
	while b != 0 {
		let temp = b
		b = a % b
		a = temp
	}
	return a
}

// Функция для вычисления наименьшего общего кратного (НОК)
func lcm(_ a: Int, _ b: Int) -> Int {
	return a / gcd(a, b) * b
}

// Функция для вычисления НОК трех чисел
func lcmOfThree(_ a: Int, _ b: Int, _ c: Int) -> Int {
	return lcm(lcm(a, b), c)
}

// Класс для игры НОК
class LCMGame {
	private let maxNumber = 100
	private let roundsCount = 3
	private var playerName: String = ""
	
	// Запуск игры
	func start() {
		print("Welcome to the Brain Games!")
		print()
		
		print("May I have your name?", terminator: " ")
		if let name = readLine(), !name.isEmpty {
			playerName = name
			print("Hello, \(playerName)!")
			print()
			
			print("Find the smallest common multiple of given numbers.")
			print()
			
			playRounds()
		} else {
			print("Name cannot be empty. Please restart the game.")
		}
	}
	
	private func playRounds() {
		for _ in 1...roundsCount {
			let num1 = Int.random(in: 1...maxNumber)
			let num2 = Int.random(in: 1...maxNumber)
			let num3 = Int.random(in: 1...maxNumber)
			
			let correctAnswer = lcmOfThree(num1, num2, num3)
			
			print("Question: \(num1) \(num2) \(num3)")
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

// Запуск игры
let game = LCMGame()
game.start()
