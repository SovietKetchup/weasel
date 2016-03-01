# Evolutionary system to acheive a string
# `-- https://en.wikipedia.org/wiki/Weasel_program
# SovietKetchup
# v0.0.0

class Weasel
  LETTERS = ("A".."Z").to_a + [" "]
  attr_reader :goal
  def initialize goal
    @goal = goal.upcase
    @current = generate_str
    @mutants = []
    ## run    
    
    100.times do
      print mutate(@goal)
    end
    
  end
  
  
  
  # Run the logic
  def run
    # Keep running until a succesful copy has been made
    until @current == @goal
      # Generate 100 mutated copies with each char having a 5% chance to mutate
      t = copy_m
      exit
      top_s = 0
      100.times do |c|
        if compare(t[c-1]) > top_s
          top_s = compare(t[c-1])
          top = t[c-1]
        end
      end
      ##raise t.inspect
      @current = t.sort_by { |str| compare(str) }
      
      # loopy loop
      print @current
    end
  end
  
  
  
  # Create 100 mutated copies
  def copy_m
    100.times do |c|
      @mutants[c] = mutate(@current)
    end
    @mutants
  end
  
  # Mutate each character of the string on a 5% (5/100) chance
  def mutate str
    str.each_char.map{|x| rand < 0.05 ? generate_ltr(x) : x}
  end
  
  # Get rating of string against the goal
  def compare str
    @goal.scan(/./).zip(str.each).map{|n| n[0]==n[1] ? 1 : 0}.inject{ |i,j| i+j } 
  end
  
  # Score each copy (based on similarity to the goal)
  def rate
    scores = []
    @mutants.size.times do |c|
      scores[c] = compare (@mutants[c])
      c += 1
    end
    scores
  end
  
  # Generate a letter DIFFERENT to the current letter
  def generate_ltr cur
    a = LETTERS.sort_by{rand}
    a[a.index(cur)+1] || a.first
  end
  
  # Generate a string of the original's length
  def generate_str
    s = ""
    @goal.length.times do 
      s += LETTERS.sample
    end
    s
  end
  
end

w = Weasel.new "METHINKS IT IS LIKE A WEASEL"
