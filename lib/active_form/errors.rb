# frozen_string_literal: true

module ActiveForm
  class Error < StandardError; end

  class InvalidAssociationValue < Error
    def initialize
      super("Associations values must respond to a id method")
    end
  end

  class InvalidAssociationKey < Error
    def initialize
      super("Association Key value must be parseable to an Integer")
    end
  end

  class InvalidAssociationType < Error
    def initialize(value)
      super(
        "Association has invalid value #{value}, must be either " \
          "`:singular` or `:multiple`"
      )
    end
  end
end
