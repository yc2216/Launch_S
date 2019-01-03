# this is a game of 'rock paper scissors lizard spock'.
# user play against the computer, whoever accumulate a preset number of
# wins first will be the grand winner.

VALID_CHOICES = %w(rock paper scissors lizard spock)
LETTER_CHOICES = { 'r' => 'rock', 'p' => 'paper', 'c' => 'scissors',
                    'l' => 'lizard', 's' => 'spock' }
WINNING_CASES = { 'lizard' => %w(paper spock),
                  'paper' => %w(rock spock),
                  'rock' => %w(scissors lizard),
                  'scissors' => %w(paper lizard),
                  'spock' => %w(scissors rock) }

def prompt(message)
  Kernel.puts("=> #{message}")
end

def who_win_who?(winner_choice, loser_choice)
  WINNING_CASES[winner_choice].include?(loser_choice)
end

def lizard_win?(inputs)
  (inputs[0] == 'lizard' && inputs[1] == 'paper') ||
    (inputs[0] == 'lizard' && inputs[1] == 'spock')
end

def lizard_win_message(loser_choice)
  if loser_choice == 'paper'
    'lizard eats paper'
  else
    'lizard poison spock'
  end
end

def paper_win?(inputs)
  (inputs[0] == 'paper' && inputs[1] == 'rock') ||
    (inputs[0] == 'paper' && inputs[1] == 'spock')
end

def paper_win_message(loser_choice)
  if loser_choice == 'rock'
    'paper covers rock'
  else
    'paper disproves spock'
  end
end

def rock_win?(inputs)
  (inputs[0] == 'rock' && inputs[1] == 'scissors') ||
    (inputs[0] == 'rock' && inputs[1] == 'lizard')
end

def rock_win_message(loser_choice)
  if loser_choice == 'scissors'
    'rock crushes scissors'
  else
    'rock crushes lizard'
  end
end

def scissors_win?(inputs)
  (inputs[0] == 'scissors' && inputs[1] == 'paper') ||
    (inputs[0] == 'scissors' && inputs[1] == 'lizard')
end

def scissors_win_message(loser_choice)
  if loser_choice == 'paper'
    'scissors cuts paper'
  else
    'scissors decapitates lizard'
  end
end

def spock_win?(inputs)
  (inputs[0] == 'spock' && inputs[1] == 'rock') ||
    (inputs[0] == 'spock' && inputs[1] == 'scissors')
end

def spock_win_message(loser_choice)
  if loser_choice == 'scissors'
    'spock crushes scissors'
  else
    'spock vaporizes rock'
  end
end

def winning_message(winner_choice, loser_choice)
  inputs = [winner_choice, loser_choice]
  if lizard_win?(inputs)
    lizard_win_message(loser_choice)
  elsif paper_win?(inputs)
    paper_win_message(loser_choice)
  elsif rock_win?(inputs)
    rock_win_message(loser_choice)
  elsif scissors_win?(inputs)
    scissors_win_message(loser_choice)
  elsif spock_win?(inputs)
    spock_win_message(loser_choice)
  else
    "They are the same"
  end
end

def single_round_result(my_choice, cpu_choice)
  if who_win_who?(my_choice, cpu_choice)
    "You won this round! " + winning_message(my_choice, cpu_choice)
  elsif who_win_who?(cpu_choice, my_choice)
    "Computer won this round! " + winning_message(cpu_choice, my_choice)
  else
    "It is a tie this round."
  end
end

def new_score(player, computer)
  if who_win_who?(player, computer)
    [1, 0]
  elsif who_win_who?(computer, player)
    [0, 1]
  else
    [0, 0]
  end
end

loop do
  total_games = 0
  total_score = [0, 0]
  system('clear')
  prompt("You are invited to play a 'rock paper scissors lizard and spock'game against the computer.")
  prompt("Whoever accumulate a preset number of wins will be the grand winner.")
  prompt("Enter a positive integer as a preset number, such as 3 or 5.")

  num = ''
  loop do
    num = Kernel.gets.chomp
    if (num.to_i.to_s == num) && (num.to_i > 0)
      break
    else
      prompt("You must enter a positive integer.")
    end
  end

  preset_total = num.to_i

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

    system('clear')

    prompt("You chose: #{choice}; Computer chose: #{computer_choice}")

    prompt(single_round_result(choice, computer_choice))

    prompt('')

    total_games += 1
    score_update = new_score(choice, computer_choice)
    total_score = total_score.each_with_index.map do |item, index|
      item + score_update[index]
    end

    prompt("You have played #{total_games} games. And the current score is \[You #{total_score[0]} \: #{total_score[1]} Computer\]")

    prompt("Whoever reach #{preset_total} wins first will be the grand winner.")

    prompt('')

    break if total_score[0] == preset_total || total_score[1] == preset_total
  end

  if total_score[0] == preset_total
    prompt("You have won #{preset_total} rounds already. You are the Grand Winner!")
  else
    prompt("Computer have won #{preset_total} rounds already. Computer is the Grand Winner!")
  end

  prompt('')
  prompt("Do you want to play again? ('y' to continue, otherwise to stop)")
  answer = Kernel.gets.chomp
  break unless answer.downcase == 'y'
end

prompt("Thank you for playing. Good Bye!")
