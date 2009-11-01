require 'json' unless Object.respond_to?(:to_json)

module Hashify
  module Json
    def self.included(cls)
      cls.instance_eval("include Hashify") unless cls.include?(Hashify)

      cls.instance_eval "
      def self.from_json(json)
        from_hash(JSON.parse(json))
      end
      "
    end

    def to_json
      to_hash.to_json
    end

  end
end