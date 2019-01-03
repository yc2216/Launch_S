#this is a game of rock paper scissors lizard spock.
#user play against the computer, whoever accumulate 5 wins first will be the grand winner.

VALID_CHOICES = %w(rock paper scissors lizard spock)
LETTER_CHOICES = {'r' => 'rock', 'p' => 'paper', 'c' => 'scissors', 'l' => 'lizard', 's' => 'spock'}
WINNING_CASES = { 'lizard' => %w(paper spock),
									'paper' => %w(rock spock),
								 	'rock' => %w(scissors lizard),
								 	'scissors' => %w(paper lizard),
								 	'spock' => %w(scissors rock)
								}

def prompt(message)
	Kernel.puts("=> #{message}")
end

def first_one_win?(first, second)
	WINNING_CASES[first].include?(second)
end

def who_win_by_how(first, second)
	inputs = [first, second].sort
	case inputs
	when ['lizard', 'paper']
		return "lizard eats paper"
	when ['lizard', 'rock']
		return "rock crushes lizard"
	when ['lizard', 'spock']
		return "lizard poisons spock"
	when ['lizard', 'scissors']
		return "scissors decapitates lizard"
	when ['paper', 'rock']
		return "paper covers rock"
	when ['paper', 'spock']
		return "paper disproves spock"
	when ['paper', 'scissors']
		return "scissors cuts paper"
	when ['rock', 'spock']
		return "spock vaporizes rock"
	when ['rock', 'scissors']
		return "rock crushes scissors"
	when ['scissors', 'spock']
		return "spock smashes scissors"
	else
		return "the same"
	end
end

def single_round_result(player, computer)
	if first_one_win?(player, computer)
		"You won this round!"
	elsif first_one_win?(computer, player)
		"Computer won this round!"
	else
		"It is a tie this round."
	end
end

def new_score(player, computer)
	if first_one_win?(player, computer)
		[1, 0]
	elsif first_one_win?(computer, player)
		[0, 1]
	else
		[0, 0]
	end
end

loop do
	total_games = 0
	total_score = [0, 0]
	system('clear')
	prompt("You are invited to play a 'rock paper scissors lizard and spock' game against the computer.")
	prompt("Whoever have a total of five wins first will be the grand winner.")
	loop do
		choice = ''
		loop do
			prompt("Choose one, use #{LETTER_CHOICES.keys.join(', ')} for: #{VALID_CHOICES.join(', ')}")
			letter = Kernel.gets.chomp.downcase
			choice = LETTER_CHOICES[letter]

			if VALID_CHOICES.include?(choice)
				break
			else
				prompt("That's not a valid choice.")
			end
		end

		computer_choice = VALID_CHOICES.sample

		prompt("You chose: #{choice}; Computer chose: #{computer_choice}")

		prompt(who_win_by_how(choice, computer_choice) + "! " + single_round_result(choice, computer_choice))

		total_games += 1
		score_update = new_score(choice, computer_choice)
		total_score = total_score.each_with_index.map { |item, index| item + score_update[index] }

		prompt("You have played #{total_games} games. And the current score is \[You #{total_score[0]} \: #{total_score[1]} Computer\]")

		break if total_score[0] == 5 || total_score[1] == 5
	end

	if total_score[0] == 5
		prompt("You are the Grand Winner!")
	else
		prompt("Computer is the Grand Winner!")
	end

	prompt("Do you want to play again? (y/n)")
	answer = Kernel.gets.chomp
	break unless answer.downcase.start_with?('y')
end

prompt("Thank you for playing. Good Bye!")
