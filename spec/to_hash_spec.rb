require 'spec/spec_helper'

describe "Basic object", 'to_hash' do
  it "should convert into a hash" do
    
    test = Class.new do 
      include Hashify
      attr_accessor :prop1, :prop2, :prop3, :prop4
      hash_accessor :prop1, :prop2, :prop3, :prop4
    end
    
    t = test.new
    t.prop1 = "prop_val_1"
    t.prop2 = "prop_val_2"
    t.prop3 = "prop_val_3"
    t.prop4 = "prop_val_4"
    t.to_hash.should == {:prop1 => 'prop_val_1', :prop2 => 'prop_val_2', :prop3 => 'prop_val_3', :prop4 => 'prop_val_4'}
  end

  it "should convert into a hash for subclasses" do
    
    test = Class.new do 
      include Hashify
      attr_accessor :prop1, :prop2, :prop3, :prop4
      hash_accessor :prop1, :prop2, :prop3, :prop4
    end
    
    test2 = Class.new(test) do 
    end
    
    t = test2.new
    t.prop1 = "prop_val_1"
    t.prop2 = "prop_val_2"
    t.prop3 = "prop_val_3"
    t.prop4 = "prop_val_4"
    t.to_hash.should == {:prop1 => 'prop_val_1', :prop2 => 'prop_val_2', :prop3 => 'prop_val_3', :prop4 => 'prop_val_4'}
  end

  it "should convert into a hash for subclasses with specific hash accessors" do
    
    test = Class.new do 
      include Hashify
      attr_accessor :prop1, :prop2, :prop3, :prop4
      hash_accessor :prop1, :prop2, :prop3, :prop4
    end
    
    test2 = Class.new(test) do 
      attr_accessor :prop5, :prop6
      hash_accessor :prop5, :prop6
    end
    
    t = test2.new
    t.prop1 = "prop_val_1"
    t.prop2 = "prop_val_2"
    t.prop3 = "prop_val_3"
    t.prop4 = "prop_val_4"
    t.prop5 = "prop_val_5"
    t.prop6 = "prop_val_6"
    t.to_hash.should == {:prop1 => 'prop_val_1', :prop2 => 'prop_val_2', :prop3 => 'prop_val_3', :prop4 => 'prop_val_4', :prop5 => 'prop_val_5', :prop6 => 'prop_val_6'}
  end

end