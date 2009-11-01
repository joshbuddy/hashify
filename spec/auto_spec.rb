require 'spec/spec_helper'

describe "Basic object", "auto hashify" do
  it "should convert into a hash" do
    
    test = Class.new do
      include Hashify::Auto

      attr_accessor :prop1
    end
    
    t = test.new
    t.prop1 = 'testing'
    t.to_hash.should == {:prop1 => 'testing'}
  end

  it "should convert from a hash" do
    
    test = Class.new do
      include Hashify::Auto

      attr_accessor :prop1
    end
    
    t = test.from_hash(:prop1 => 'testing')
    t.prop1.should == 'testing'
  end


end