module Hashify
  module Convert
    Pass = nil
    Time = [Proc.new{|x| x.nil? ? nil : x.to_i}, Proc.new{|x| x.nil? ? nil : Time.at(x.to_i)}]
  end
end