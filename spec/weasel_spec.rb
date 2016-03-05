require 'spec_helper.rb'
require_relative '../weasel.rb'

describe Weasel do 
  before(:each) { @weasle = Weasel.new }
  
  # run :: compiles and sorts other methods to produce the output
  describe "steps required to reach goal ::", :focus => false do
    before(:each) { @w = Weasel.new }
  
    it "should be an Integer", :focus => false do
      @w.run.should be_a Integer
    end
  
    it "should be greater than 0", :focus => false do
      @w.run.should be > 0
    end
  end
  
  # compare :: scores a string against the goal
  describe "a score based on similarity ::", :focus => false do
    before(:each) { @w = Weasel.new; @goal = "ABCDEFGHIJ" } 
    
    it "should be an Integer", :focus => false do
      @w.compare(@goal, ["A","J","G","H","S","U","E","L","F","P"]).should be_a Integer
    end
    
    it "should be out of goal's length", :focus => false do
      @w.compare(@goal, ["A","J","G","H","S","U","E","L","F","P"]).should be <= @goal.length
    end
    
    it "should be 3", :focus => false do
      @w.compare(@goal, ["A","J","G","D","S","U","G","L","F","P"]).should be 3
    end
  end
  
  # copy_mutate :: creates x mutated copies of a string
  describe "strings in an array ::", :focus => false do
    before(:each) { @muts = Weasel.new.copy_mutate("ABCDEFGHIJ", 100, 0.05) }
    
    it "should be an Array", :focus => false do 
      @muts.should be_a Array
    end
    
    it "should be of Arrays", :focus => false do
      @muts.map{ |i| i.is_a?(Array) }.all?.should be_truthy
    end
    
    it "should be 100 Arrays", :focus => false do
      @muts.size.should be 100
    end
  end

  # generate_ltr :: generates a letter that is different to the current one
  describe "a randomly selected letter ::", :focus => false do 
    before(:each) { @ltr = Weasel.new.generate_ltr("A") }
    
    it "should be a String", :focus => false do
      @ltr.should be_a String
    end
    
    it "should be a different letter", :focus => false do
      @ltr.should_not be "A"
    end
  
    it "should be one character", :focus => false do
      @ltr.length.should be 1
    end
  end
  
  # generate_str :: generates a random string of a given length
  describe "a random string of a given length ::", :focus => false do
    before(:each) { @str = Weasel.new(:goal => "ABCDEFGHIJ").generate_str }
    
    it "should be a String", :focus => false do
      @str.should be_a String
    end
    
    it "should be the length of the goal ", :focus => false do
      @str.length.should be 10
    end
  end
  
  # mutate :: alters each character of a string at a % chance
  describe "generate a string similar to original ::", :focus => false do
    before(:each) { @w = Weasel.new }
    
    it "should be an Array", :focus => false do
      @w.mutate("ABCDEFGHIJ", 0.05).should be_a Array
    end
    
    it "should be same length as passed str", :focus => false do
      @w.mutate("ABCDEFGHIJ", 0.05).size.should be 10
    end
  end
end
















