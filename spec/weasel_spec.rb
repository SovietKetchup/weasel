require 'spec_helper.rb'
require_relative '../weasel.rb'

describe Weasel do 
  before(:each) { @weasle = Weasel.new }
  
  # generate_ltr method
  describe "generate a letter different to the current letter ::", :focus => false do 
    before(:each) do 
      @ltr = Weasel.new.generate_ltr("A")
    end
    
    it "should be a String", :focus => false do
      @ltr.should be_a String
    end
    
    it "should return a letter different to current", :focus => false do
      @ltr.should_not be "A"
    end
  
    it "should be one character", :focus => false do
      @ltr.length.should be 1
    end
  end
  
  # generate_str method
  describe "generate a string of a given length ::", :focus => false do
    before(:each) do
      @str = Weasel.new(:goal => "ABCDEFGHIJ").generate_str
    end
    
    it "should be a String", :focus => false do
      @str.should be_a String
    end
    
    it "should be the length of the goal string", :focus => false do
      @str.length.should be 10
    end
  end
  
  # compare method
  describe "give a score based on similarity ::", :focus => false do
    before(:each) do
      @w = Weasel.new
      @goal = "ABCDEFGHIJ"
    end 
    
    it "should be an Integer", :focus => false do
      @w.compare(@goal, ["A","J","G","H","S","U","E","L","F","P"]).should be_a Integer
    end
    
    it "should be out of :goal's length", :focus => false do
      @w.compare(@goal, ["A","J","G","H","S","U","E","L","F","P"]).should be <= @goal.length
    end
    
    it "should be 3", :focus => false do
      @w.compare(@goal, ["A","J","G","D","S","U","G","L","F","P"]).should be 3
    end
  end
  
  # mutate method
  describe "generate a string similar to original ::", :focus => false do
    before(:each) do
      @w = Weasel.new
    end
    
    it "should be an Array", :focus => false do
      @w.mutate("ABCDEFGHIJ", 0.25).should be_a Array
    end
    
    it "should be same length as passed str", :focus => false do
      @w.mutate("ABCDEFGHIJ", 0.25).size.should be 10
    end
  end
  
  # copy_mutate method
  describe "should make x strings in an array ::", :focus => false do
    before(:each) do
      @w = Weasel.new
    end
    
    it "should be an Array", :focus => false do 
      @w.copy_mutate("ABCDEFGHIJ", 100, 0.25).should be_a Array
    end
  end
end
















