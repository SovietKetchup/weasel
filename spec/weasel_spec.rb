require 'spec_helper.rb'
require_relative '../weasel.rb'

describe Weasel do 
  before(:each) { @weasle = Weasel.new }
  
  # generate_ltr method
  describe "generate a letter different to the current letter ::" do 
    before(:each) do 
      @ltr = Weasel.new.generate_ltr("A")
    end
    
    it "should be a String" do
      @ltr.should be_a String
    end
    
    it "should return a letter different to current" do
      @ltr.should_not be "A"
    end
  
    it "should be one character" do
      @ltr.length.should be 1
    end
  end
  
  # generate_str method
  describe "generate a string of a given length ::" do
    before(:each) do
      @str = Weasel.new(:goal => "0123456789").generate_str
    end
    
    it "should be a String" do
      @str.should be_a String
    end
    
    it "should be the length of the goal string" do
      @str.length.should be 10
    end
  end
  
  # compare method
  describe "give a score based on similarity ::" do
    before(:each) do
      @w = Weasel.new
      @goal = "ABCDEFGHIJ"
    end 
    
    it "should be an Integer" do
      @w.compare(@goal, ["A","J","G","H","S","U","E","L","F","P"]).should be_a Integer
    end
    
    it "should be out of :goal's length" do
      @w.compare(@goal, ["A","J","G","H","S","U","E","L","F","P"]).should be <= @goal.length
    end
    
    it "should be 3" do
      @w.compare(@goal, ["A","J","G","D","S","U","G","L","F","P"]).should be 3
    end
  end
  
  # mutate method
  describe "generate a string similar to original ::" do
    before(:each) do
      @mut = Weasel.new
    end
    
    it "should be an Array" do
      @mut.mutate("0123456789", 0.05).should be_a Array
    end
    
    it "should be same length as passed str" do
      @mut.mutate("0123456789", 0.05).size.should be 10
    end
  end
end
















