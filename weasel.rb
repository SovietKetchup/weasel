# Evolutionary system to acheive a string
# `-- https://en.wikipedia.org/wiki/Weasel_program
# SovietKetchup
# v0.0.0

class Weasel
  LETTERS = ("A".."Z").to_a + [" "]
  attr_reader :goal
  def initialize goal
    @word = [ [], [] ]
    @word[0][0] = goal.upcase
    @word[0][1] = generate_str
    run
  end
  
  private
  # Run the logic
  def run
  
    puts @word[0][0]
  
    # Keep running until a succesful copy has been made
    until @word[0][1] == @word[0][0]
      # Generate 100 mutated copies with each char having a 5% chance to mutate
      copy
      
      # Take best scoring copy
      @word[0][1] = @word[1][@word[1].each_with_index.max[1]]
      
      # loopy loop
      puts "#{@word[0][1]} : #{}"
    end
  end
  
  # Create 100 mutated copies
  def copy
    100.times do |c|
      @word[1][c] = mutate(@word[0][1])
    end
  end
  
  # Score each copy (based on similarity to the goal)
  def rate
    score = []
    @word[1].size.times do |c|
      score[c] = compare (@word[1][c])
      c += 1
    end
    score
  end
  
  # Mutate each character of the string on a 5% (5/100) chance
  def mutate str
    str = str.to_s.each_char.map{|x| rand < 0.05 ? generate_ltr(x) : x}
  end
  
  # Get rating of string against the goal
  def compare str
    @word[0][0].scan(/./).zip(str.each).map{|n| n[0]==n[1] ? 1 : 0}.inject{ |i,j| i+j } 
  end
  
  # Generate a string of the original's length
  def generate_str
    str = ""
    @word[0][0].length.times do 
      str +=  LETTERS.sample
    end
    str
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
