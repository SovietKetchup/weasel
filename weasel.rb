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
    
    run    
  end
  
  
  
  # Run the logic
  def run
    # Keep running until a succesful copy has been made
    until @current == @goal
      # Generate 100 mutated copies with each char having a 5% chance to mutate
      t = copy_m
      
      # Get highest scoring mutation of string
      top_s = 0
      top = ""
      
      @current = t.sort_by { |str| compare(str) }.last
      
      print @current
      ##exit
    end
  end
  
  
  
  # Create 100 mutated copies
  def copy_m
    mut = []
    100.times do |c|
      mut[c] = mutate(@current)
    end
    mut
  end
  
  # Mutate each character of the string on a 5% (5/100) chance
  def mutate str
    str.to_s.each_char.map{|x| rand < 0.05 ? generate_ltr(x) : x}
  end
  
  # Get rating of string against the goal
  def compare str
    @goal.scan(/./).zip(str).map{|n| n[0]==n[1] ? 1 : 0}.inject{ |i,j| i+j } 
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
    ##a[a.index(cur)+1] || a.first
    begin
      a[a.index(cur)+1] || a.first
    rescue => e
      puts "omg it sploded on #{cur.inspect}\n error was #{e}"
    end
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
