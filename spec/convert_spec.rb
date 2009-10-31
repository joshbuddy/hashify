require 'spec/spec_helper'

describe "Basic object", "conversions" do
  it "should run conversions" do
    
    test = Class.new do 
      include Hashify
      attr_accessor :prop1
      hash_convert :prop1 => [proc{|x| x.to_i}, proc{|x| Time.at(x)}]
    end
    
    t = test.from_hash(:prop1 => 12345)
    
    t.prop1.should == Time.at(12345)
    
    t.to_hash.should == {:prop1 => 12345}
  end


end