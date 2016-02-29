# Evolutionary system to acheive a string
# `-- https://en.wikipedia.org/wiki/Weasel_program
# SovietKetchup
# v0.0.0

class Weasel
  LETTERS = ("A".."Z").to_a + [" "]
  attr_reader :goal
  def initialize :goal
    @goal = goal.upcase
  end
  
  private
  # Mutate each character of the string on a 5% (5/100) chance
  def mutate str
    str = str.each_char.map{|x| rand < 0.05 ? generate_ltr(x) : x}
  end
  
  # Get rating of string against the goal
  def compare str
    @goal.each_char.to_a.zip(str.each_char.to_a).map{|n| n[0]==n[1] ? 1 : 0}.inject{ |i,j| i+j } 
    compared.each do |x|
  end
  
  # Generate a string of the original's length
  def generate_str
    str = ""
    @goal.length.times do 
      str += LETTERS.sample
    end
  end
  
  # Generate a letter DIFFERENT to the current letter
  def generate_ltr current
    l = current
    until l != current
      l = LETTERS.sample
    end
  end
  
end

w = Weasel.new "METHINKS IT IS LIKE A WEASEL"
