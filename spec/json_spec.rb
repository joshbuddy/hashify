require 'spec/spec_helper'

describe "Basic object", "json" do
  it "should convert to json" do
    
    test = Class.new do 
      include Hashify::Json
      attr_accessor :prop1
      hash_accessor :prop1
    end
    
    t = test.new
    t.prop1 = 'property_value_1'
    t.to_json.should == '{"prop1":"property_value_1"}'
  end

  it "should convert from json" do
    
    test = Class.new do 
      include Hashify::Json
      attr_accessor :prop1
      hash_accessor :prop1
    end
    
    t = test.from_json '{"prop1":"property_value_1"}'
    t.prop1.should == 'property_value_1'
  end


end