# Evolutionary system to acheive a string
# `-- https://en.wikipedia.org/wiki/Weasel_program
# SovietKetchup
# v1.0.2

class Weasel
  LETTERS = ("A".."Z").to_a + [" "]
  attr_reader :args
  def initialize args = {}
    args = {:goal => "METHINKS IT IS LIKE A WEASEL", :copies => 100, 
            :chance => 2.5, :test => false}.merge(args)  # defaults
    @test = args[:test]
    @goal = args[:goal].upcase
    @copies = args[:copies]
    @chance = args[:chance].to_f/100
    # Start main logic (if not in testing mode)
    run unless @test  
  end
  
  # Run the logic
  def run
    @current = generate_str
    @mutants = []
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
      
      # Unless in testing mode, print each evolution of string
      puts "#{c} : #{@current}" unless @test
    end
    # If in testing mode, return step count
    return c if @test
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

# Choose between testing mode or not by changing test variable
copies = 100
chance = 2
test = true

unless test
  str = "METHINKS IT IS LIKE A WEASEL"
  w = Weasel.new :goal => str, :copies => copies, :chance => chance, :test => test
  exit
else
  str = "ABCDEFGHIJKLMNOPQRSTUVWXYABCDEFGHIJKLMNOPQRSTUVWXYABCDEFGHIJKLMNOPQRSTUVWXYABCDEFGHIJKLMNOPQRSTUVWXY"
  w = Weasel.new :goal => str, :copies => copies, :chance => chance, :test => test
end

# Testing porpoises
all = []

2.times do puts "----------------------------------------" end

20.times do |c|
  all[c] = w.run
  puts "#{c+1} : #{all[c]}" 
end

lowest = all.min
highest = all.max
total = all.inject(:+)
len = all.length
average = total.to_f / len # to_f so we don't get an integer result
sorted = all.sort
median = len % 2 == 1 ? sorted[len/2] : (sorted[len/2 - 1] + sorted[len/2]).to_f / 2

2.times do puts "----------------------------------------" end

puts "          The Weasel Program"
puts "STRING LENGTH      : #{str.length}"
puts "COPIES PER CYCLE   : #{copies}"
puts "CHANCE OF MUTATION : #{chance}%"

2.times do puts "----------------------------------------" end

puts "AVERAGE CYCLES     : #{average}"
puts "MEDIAN CYCLE No    : #{median}"
puts "CYCLE RANGE        : #{highest-lowest}"
puts "LOWEST CYCLE No    : #{lowest}"
puts "HIGHEST CYCLE No   : #{highest}"

2.times do puts "----------------------------------------" end

