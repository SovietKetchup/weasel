# Evolutionary system to acheive a string
# `-- https://en.wikipedia.org/wiki/Weasel_program
# SovietKetchup
# v1.1.0

class Weasel
  LETTERS = ("A".."Z").to_a + [" "]
  attr_reader :args
  def initialize args = {}
    args = {:goal => "METHINKS IT IS LIKE A WEASEL", :copies => 100, 
            :chance => 2.5}.merge(args)  # defaults
    @goal = args[:goal].upcase
    @copies = args[:copies]
    @chance = args[:chance].to_f/100
  end
  
  # Run the logic
  def run
    @current = generate_str
    c = 0
    # Keep running until a succesful copy has been made
    until @current == @goal
      # Generate mutated copies with each char having a % chance to mutate
      t = copy_mutate
      
      # Get highest scoring mutation of string
      top_s = 0
      top = ""
      @current = t.sort_by { |str| compare(str) }.last
      
      # If it's an array, make it a string
      @current.is_a?(Array) ? @current = @current.join : @current = @current
      
      c += 1
    end
    # return step count
    c
  end
  
  # Create 100 mutated copies
  def copy_mutate
    mut = []
    # Create 100 mutations of the current string
    @copies.times do |c|
      mut[c] = mutate(@current)
    end
    mut
  end
  
  # Mutate each character of the string on a 2.5% chance
  def mutate str
    # Convert to a string if it's an array
    str = str.is_a?(Array) ? str.join : str
    str.each_char.map{|x| rand < @chance ? generate_ltr(x) : x}
  end
  
  # Get rating of string against the goal
  def compare arr
    @goal.scan(/./).zip(arr).map{|n| n[0]==n[1] ? 1 : 0}.inject{ |i,j| i+j } 
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

# Create a new Weasel object with the goal string, number of copies per cycle 
# and % chance of mutation per character
w = Weasel.new :goal => "METHINKS IT IS LIKE A WEASEL", :copies => 100, :chance => 2

# Returns the number of cycles taken to acheive goal string
puts w.run

