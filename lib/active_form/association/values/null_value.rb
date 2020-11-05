# frozen_string_literal: true

module ActiveForm
  class Association
    module Values
      class NullValue < Base
        def initialize(*)
          super(nil)
        end
      end
    end
  end
end
