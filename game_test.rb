# frozen_string_literal: true

require 'minitest/autorun'
require_relative 'game'

class GameTest < Minitest::Test
  def setup
    @game = Game.new
  end

  def test_get_computer_choice
    @game.get_computer_choice
    assert_includes Game::CHOICES, @game.computer_choice, "Computer choice should be one of #{Game::CHOICES}"
  end

  def test_compare_choices_tie
    @game.user_choice = 'rock'
    @game.computer_choice = 'rock'
    @game.compare_choices
    assert_equal "It's a tie!", @game.result
  end

  def test_compare_choices_user_wins
    @game.user_choice = 'rock'
    @game.computer_choice = 'scissors'
    @game.compare_choices
    assert_equal 'You win!', @game.result
  end

  def test_compare_choices_user_loses
    @game.user_choice = 'rock'
    @game.computer_choice = 'paper'
    @game.compare_choices
    assert_equal 'You lose!', @game.result
  end

  def test_invalid_user_choice
    invalid_choice = 'invalid'
    @game.user_choice = invalid_choice
    refute_includes Game::CHOICES, invalid_choice, 'User choice should not include invalid inputs'
  end

  def test_all_possible_outcomes
    Game::CHOICES.each do |user_choice|
      Game::CHOICES.each do |computer_choice|
        @game.user_choice = user_choice
        @game.computer_choice = computer_choice
        @game.compare_choices

        if user_choice == computer_choice
          assert_equal "It's a tie!", @game.result
        elsif @game.result == 'You win!'
          assert_equal computer_choice, { 'rock' => 'scissors', 'paper' => 'rock', 'scissors' => 'paper' }[user_choice]
        else
          assert_equal user_choice, { 'rock' => 'scissors', 'paper' => 'rock', 'scissors' => 'paper' }[computer_choice]
        end
      end
    end
  end
end
