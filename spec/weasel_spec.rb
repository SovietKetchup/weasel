require 'spec_helper.rb'
require_relative '../weasel.rb'

describe Weasel do 
  before(:each) { @weasle = Weasel.new }
  
  describe "generate a letter different to the current letter" do 
    before(:each) do 
      @w = Weasel.new
    end
    
    it "should return a letter different to current" do
      @w.generate_ltr("A").should_not be "A"
    end
  
    it "should be one character" do
      @w.generate_ltr("A").length.should be 1
    end
  end
  
  describe "generate a string of a given length" do
    before(:each) do
      @w = Weasel.new
      @w.instance_variable_set("@args", {:goal => "0123456789"})
    end
    
    it "should be the length of @args[:goal]" do
      @w.generate_str.length.should be 10
    end
  end
end
