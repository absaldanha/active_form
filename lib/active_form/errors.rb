# frozen_string_literal: true

module ActiveForm
  class Error < StandardError; end

  class InvalidAssociationDefault < Error
    def initialize(value)
      super("Default association value must be a Proc, got: #{value.class}")
    end
  end

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
end
