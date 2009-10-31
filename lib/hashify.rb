module Hashify

  autoload :Json, File.join(File.dirname(__FILE__), 'hashify', 'json')
  autoload :Convert, File.join(File.dirname(__FILE__), 'hashify', 'convert')
  
  def self.included(cls)
    
    cls.const_set(:HashConvertTable, {}) unless cls.const_defined?(:HashConvertTable)
    cls.instance_eval(<<-CLASS_DOC, __FILE__, __LINE__)
    def self.hash_convert_table
      self.const_set(:HashConvertTable, {}) unless self.const_defined?(:HashConvertTable)
      send(:const_get, :HashConvertTable)
    end
    
    def self.hash_accessor(*args)
      args.each {|a| hash_convert_table[a] = nil }
    end
      
    def self.hash_convert(map)
      hash_convert_table.merge!(map)
    end
    
    def self.from_hash(map)
      convert_map = assembled_hash_convert
      instance = new
      map.each do |name, val|
        convert_map[name.to_sym] ? 
          instance.send((name.to_s + '=').to_sym, convert_map[name.to_sym].last.call(val)) :
          instance.send((name.to_s + '=').to_sym, val)
      end
      instance
    end
    
    def self.assembled_hash_convert
      map = hash_convert_table.dup
      parent = self.superclass
      while (parent and parent.respond_to?(:hash_convert_table))
        map.merge!(parent.hash_convert_table) {|key, old_value, new_value| old_value || new_value }
        parent = parent.superclass
      end
      map
    end
    CLASS_DOC
  end
  
  def to_hash
    self.class.assembled_hash_convert.inject({}) do |hash, (name, converter)|
      converter ? 
        hash[name] = converter.first.call(self.send(name)) :
        hash[name] = self.send(name)
      hash
    end
  end
  
end
