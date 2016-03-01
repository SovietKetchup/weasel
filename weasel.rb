# Evolutionary system to acheive a string
# `-- https://en.wikipedia.org/wiki/Weasel_program
# SovietKetchup
# v1.0.0

class Weasel
  LETTERS = ("A".."Z").to_a + [" "]
  attr_reader :goal
  def initialize goal
    @goal = goal.upcase
    @current = generate_str
    @mutants = []
    
    # Start main logic
    run    
  end
  
  # Run the logic
  def run
    c = 0
    # Keep running until a succesful copy has been made
    until @current == @goal
      # Generate 100 mutated copies with each char having a 5% chance to mutate
      t = copy_m
      
      # Get highest scoring mutation of string
      top_s = 0
      top = ""
      @current = t.sort_by { |str| compare(str) }.last
      
      # If it's an array, make it a string
      @current.is_a?(Array) ? @current = @current.join : @current = @current
      
      c += 1
      puts "#{c} : #{@current}"
    end
  end
  
  # Create 100 mutated copies
  def copy_m
    mut = []
    # Create 100 mutations of the current string
    10.times do |c|
      mut[c] = mutate(@current)
    end
    mut
  end
  
  # Mutate each character of the string on a 2.5% (5/100) chance
  def mutate str
    # Convert to a string if it's an array
    str = str.is_a?(Array) ? str.join : str
    str.each_char.map{|x| rand < 0.025 ? generate_ltr(x) : x}
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

w = Weasel.new "ME THINKS IT IS LIKE A WEASEL"
