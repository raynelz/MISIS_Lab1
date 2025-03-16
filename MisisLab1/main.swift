import Foundation

protocol Game {
	var playerName: String { get set }
	var roundsCount: Int { get }

	func start()
	func generateQuestion() -> (question: String, correctAnswer: Int)
	func playRounds()
}

class BaseGame: Game {
	var playerName: String = ""
	var roundsCount: Int = 3

	func start() {
		print("Welcome to the Brain Games!")
		print("May I have your name?", terminator: " ")
		if let name = readLine(), !name.isEmpty {
			playerName = name
			print("Hello, \(playerName)!")
			printGameDescription()
			playRounds()
		} else {
			print("Name cannot be empty. Please restart the game.")
		}
	}

	func printGameDescription() {
		// Переопределяется в дочерних классах
	}

	func generateQuestion() -> (question: String, correctAnswer: Int) {
		fatalError("This method must be overridden by subclasses")
	}

	func playRounds() {
		for _ in 1...roundsCount {
			let (questionString, correctAnswer) = generateQuestion()

			print(questionString)
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

class LCMGame: BaseGame {
	private let maxNumber = 50

	override func printGameDescription() {
		print("Find the least common multiple of three numbers.")
	}

	override func generateQuestion() -> (question: String, correctAnswer: Int) {
		let firstRandomNumber = Int.random(in: 1...maxNumber)
		let secondRandomNumber = Int.random(in: 1...maxNumber)
		let thirdRandomNumber = Int.random(in: 1...maxNumber)

		let correctAnswer = leastCommonMultipleOfThree(
			firstRandomNumber,
			secondRandomNumber,
			thirdRandomNumber
		)

		let questionString = "Question: \(firstRandomNumber) \(secondRandomNumber) \(thirdRandomNumber)"

		return (questionString, correctAnswer)
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
}

class GeometricProgressionGame: BaseGame {
	private let minLength = 5
	private let maxLength = 10

	override func printGameDescription() {
		print("What number is missing in the progression?")
	}

	override func generateQuestion() -> (question: String, correctAnswer: Int) {
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

		return (questionString, hiddenValue)
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

let lcmGame = LCMGame()
lcmGame.start()

let gmGame = GeometricProgressionGame()
gmGame.start()
