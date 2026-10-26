# frozen_string_literal: true

# Logic for serializing to/from JSON. We assume that the standard library's JSON
# module is good enough for our purposes.

require 'json'

module Que
  module Utils
    module JSONSerialization
      def serialize_json(object)
        JSON.dump(object)
      end

      def deserialize_json(json)
        major = Integer(JSON::VERSION[0])
        if major <= 2
          # Allowing `create_additions` would be a security vulnerability.
          JSON.parse(json, symbolize_names: true, create_additions: false)
        else
          # json v3+ has dropped the 'create_additions' option for secrity reasons:
          # https://github.com/ruby/json/blob/master/CHANGES.md
          JSON.parse(json, symbolize_names: true)
        end
      end
    end
  end
end
