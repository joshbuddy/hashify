module Hashify
  module Auto
    
    def self.included(cls)
      cls.send(:const_set, :Auto__, false)
      
      cls.instance_eval("include Hashify") unless cls.include?(Hashify)
      
      cls.instance_eval(<<-HERE_DOC, __FILE__, __LINE__)
        def self.autoload_hash_accessors
          readers = instance_methods.find_all{|m| m.to_s[-1] == ?= && m.to_s[0] != ?=}.map{|m| str = m.to_s; str.slice!(-1); str.to_sym}
          readers.delete(:taguri) # i don't like this method
          readers.delete_if{|m| instance_method(m).nil? }
          instance_eval "hash_accessor \#{readers.map{|r| r.inspect} * ', '}"
        end
        
        def self.auto_guard
          if const_get(:Auto__).equal? false
            send(:remove_const, :Auto__)
            send(:const_set, :Auto__, true)
            autoload_hash_accessors
          end
          yield
        end
        
      HERE_DOC
      
      cls.class_eval(<<-HERE_DOC, __FILE__, __LINE__)
      def to_hash
        self.class.auto_guard do
          super
        end
      end
      
      class << self
        def self.from_hash(map)
          auto_guard do
            super
          end
        end
      end
      HERE_DOC
    
    end
    
  end
end