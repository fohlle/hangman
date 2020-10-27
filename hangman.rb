
class Dictionary

  def initialize
    
  end
end

class Game

  attr_reader :word
  def initialize
    welcome
    @secret_word = "abcdef"
    @word_array = Array.new(@secret_word.length,"_")
  end

  def welcome
    puts "Welcome to hangman game"
    puts "Make guesses a-z to figure out the word in 5 turns"
  end

  def make_guess
    puts "Guess a letter:"
    guess = gets.chomp
    guess = guess.downcase
    p guess
  end

  def show_word
    #word_array = Array.new(@secret_word.length,"_")   
    p @word_array 
  end

  def logic(guess)
    if @secret_word.include?(guess)
      puts "yay"
    else
      puts "not"
    end
  end


end

game = Game.new
game.show_word
guess = game.make_guess
game.logic(guess)
