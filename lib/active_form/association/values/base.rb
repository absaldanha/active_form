# frozen_string_literal: true

module ActiveForm
  class Association
    module Values
      class Base
        attr_reader :current, :key

        def initialize(current = nil)
          if current
            self.current = current.respond_to?(:call) ? current.call : current
          else
            @current = nil
            @key = nil
          end
        end

        def current=(_new_value); end

        def key=(_new_key); end
      end
    end
  end
end
