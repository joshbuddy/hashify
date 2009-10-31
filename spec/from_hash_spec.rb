require 'spec/spec_helper'

describe "Basic object", "from_hash" do
  it "should convert from a hash" do
    
    test = Class.new do 
      include Hashify
      attr_accessor :prop1, :prop2, :prop3, :prop4
      hash_accessor :prop1, :prop2, :prop3, :prop4
    end
    
    t = test.from_hash(:prop1 => 'prop_val_1', :prop2 => 'prop_val_2', :prop3 => 'prop_val_3', :prop4 => 'prop_val_4')
    
    t.prop1.should == "prop_val_1"
    t.prop2.should == "prop_val_2"
    t.prop3.should == "prop_val_3"
    t.prop4.should == "prop_val_4"
  end

  it "should convert from a hash for a subclass" do
    
    test = Class.new do 
      include Hashify
      attr_accessor :prop1, :prop2, :prop3, :prop4
      hash_accessor :prop1, :prop2, :prop3, :prop4
    end
    
    test2 = Class.new(test)
    
    t = test2.from_hash(:prop1 => 'prop_val_1', :prop2 => 'prop_val_2', :prop3 => 'prop_val_3', :prop4 => 'prop_val_4')
    
    t.prop1.should == "prop_val_1"
    t.prop2.should == "prop_val_2"
    t.prop3.should == "prop_val_3"
    t.prop4.should == "prop_val_4"
  end

  it "should convert from a hash for subclasses with specific hash accessors" do
    
    test = Class.new do 
      include Hashify
      attr_accessor :prop1, :prop2, :prop3, :prop4
      hash_accessor :prop1, :prop2, :prop3, :prop4
    end
    
    test2 = Class.new(test) do 
      attr_accessor :prop5, :prop6
      hash_accessor :prop5, :prop6
    end
    
    t = test2.from_hash(:prop1 => 'prop_val_1', :prop2 => 'prop_val_2', :prop3 => 'prop_val_3', :prop4 => 'prop_val_4', :prop5 => 'prop_val_5', :prop6 => 'prop_val_6')
    t.prop1.should == "prop_val_1"
    t.prop2.should == "prop_val_2"
    t.prop3.should == "prop_val_3"
    t.prop4.should == "prop_val_4"
    t.prop5.should == "prop_val_5"
    t.prop6.should == "prop_val_6"
  end


end