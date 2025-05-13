# frozen_string_literal: true

class Game
  CHOICES = %w[rock paper scissors].freeze
  WELCOME_MESSAGE = 'Welcome to Rock-Paper-Scissors!'
  GOODBYE_MESSAGE = 'Thanks for playing! Goodbye!'
  INVALID_INPUT_MESSAGE = 'Invalid input. Please try again.'

  attr_accessor :user_choice, :computer_choice, :result

  def play
    puts WELCOME_MESSAGE
    loop do
      get_user_choice
      get_computer_choice
      compare_choices
      display_result
      break unless play_again?
    end
    goodbye
  end

  def goodbye
    puts GOODBYE_MESSAGE
  end

  def play_again?
    loop do
      puts 'Do you want to play again? (y/n)'
      answer = gets.chomp.downcase.strip
      return true if answer == 'y'
      return false if answer == 'n'

      puts 'Invalid input. Please enter "y" for yes or "n" for no.'
    end
  end

  def display_result
    puts "You chose #{user_choice}, computer chose #{computer_choice}."
    puts result
  end

  def compare_choices
    winning_combinations = {
      'rock' => 'scissors',
      'paper' => 'rock',
      'scissors' => 'paper'
    }

    self.result = if user_choice == computer_choice
                    "It's a tie!"
                  elsif winning_combinations[user_choice] == computer_choice
                    'You win!'
                  else
                    'You lose!'
                  end
  end

  def get_computer_choice
    self.computer_choice = CHOICES.sample
  end

  def get_user_choice
    loop do
      puts 'Choose rock, paper, or scissors:'
      self.user_choice = gets.chomp.downcase
      break if CHOICES.include?(user_choice)

      puts 'Invalid choice. Please choose rock, paper, or scissors.'
    end
  end
end

# Start the game
# game = Game.new
# game.play
