# frozen_string_literal: true

module ActiveForm
  class Association
    module Loaders
      class NullLoader
        def load(*); end
      end
    end
  end
end
