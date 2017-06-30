class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end

  attr_accessor :word, :guesses, :wrong_guesses

  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
    @list_of_try = Array.new
    @list_of_correct_char = Array.new 
    @num_of_fail = 0
  end
  
  #main guess method 
  def guess(g)
    if g.to_s.empty? or ( g.to_s =~ /[a-zA-Z]/ ).nil?  
      raise ArgumentError.new("Invalid guess")
    end 
    
    # Chang all characters to lower case 
    g = g.downcase 
    
    if @list_of_try.include? g
      return false
    else
      @list_of_try.push g
      
      if @word.include? g 
        @guesses = g
        @list_of_correct_char.push g
      else
        @wrong_guesses << g 
        @num_of_fail += 1
      end  
      return true
      
    end
  end
  
  #Current guessing status
  def word_with_guesses
    @ans = ''
    @word.split("").each do |i|
      if @list_of_correct_char.include? i 
        @ans << i
      else
        @ans << '-'
      end
    end
    return @ans 
  end
    
  #Game status 
  def check_win_or_lose
    if @num_of_fail >= 7 
      return :lose 
    elsif not word_with_guesses.to_s.include? "-"
      return :win 
    else 
      return :play
    end 
  end
  
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
