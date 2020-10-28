require "yaml"

class Dictionary

  attr_reader :random_word
  def initialize
    @random_word
    make_word
  end

  def make_word
    file = File.open("dic.txt","r")
    hi = file.read.split(" ")
    rand_word = hi[rand(hi.length)].downcase

    while rand_word.length < 5 || rand_word.length > 12
      rand_word = hi[rand(hi.length)].downcase
    end
    @random_word = rand_word
  end

end

class Game < Dictionary

  def initialize
    dicken = Dictionary.new
    welcome
    @secret_word = dicken.random_word
    @word_array = Array.new(@secret_word.length,"_")
    @guessed_words = []
    @countdown = 5
    @save
    @load
  end

  def welcome
    puts "Welcome to hangman game"
    puts "Make guesses a-z to guess the word"
    puts "You can make 5 incorrect guesses"
    puts "Want to load a game? Y/N"
  end

  def play_round
    load
    win = 0
    while @countdown > 0
      logic(make_guess)
      if winner?
        win = 1
        break
      end
    end
    if win == 0
      puts "You lose, the word was #{@secret_word}"
    elsif win == 1
      puts "Winner you guessed the word"
    end
  end

  def make_guess
    puts "Guess a letter: or type save to save the game"
    guess = gets.chomp
    guess = guess.downcase
    if guess == "save"
      save
      make_guess
    else
    @guessed_words.push(guess)
    guess
    end
    
  end

  def display_letter(guess)
    secret_word_array = @secret_word.split("")
    secret_word_array.each_with_index do |letter,index|
      if guess == letter
        @word_array[index] = letter
      end
    end
  end

  def show_word
    #word_array = Array.new(@secret_word.length,"_")   
    puts "#{@word_array}, Guessed letters: #{@guessed_words}"
    puts "Remaining guesses: #{@countdown}"
  end

  def logic(guess)
    if @secret_word.include?(guess)
      puts "#{guess} is correct"
      display_letter(guess)
      show_word
    else
      puts "#{guess} is incorrect"
      @countdown -= 1
      show_word
    end
  end

  def winner?
    if @word_array.join("") == @secret_word
      true
    else
      false
    end
  end

  def save
    puts "saving"
    @save = YAML.dump ({
      :secret => @secret_word,
      :word => @word_array,
      :guessed => @guessed_words,
      :count => @countdown
    })
    save_file = File.open("saved","w")
    save_file.puts @save
    save_file.close

  end

  def load
    answer = gets.chomp
    if answer == "y"
      puts "loading"
      loading_file = File.open("saved","r")
      data = YAML.load loading_file
      @guessed_words = data[:guessed]
      @countdown = data[:count]
      @word_array = data[:word]
      @secret_word = data[:secret]
      show_word
    elsif answer == "n"
      show_word
    end
  end



end

game = Game.new
game.play_round

#hi = File.open("look.txt","w")
#hi.puts "im filing"
#hi.close

#test = ["one","two",3]
#testTwo = [1,2,3]
#
#what = YAML.dump ({:test => test,:testTwo => testTwo})
#save = File.open("saved","w")
#save.puts what
#save.close
#test = [4,5,6]
#loading = File.open("saved","r")
#
#p YAML.load loading

