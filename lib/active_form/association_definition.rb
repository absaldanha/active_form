# frozen_string_literal: true

module ActiveForm
  class AssociationDefinition
    attr_reader :name, :value, :type, :loader_options

    def self.singular(name:, default: nil, **loader_options)
      new(
        type: :singular,
        name: name,
        value: default,
        loader_options: loader_options
      )
    end

    def initialize(name:, type:, value: nil, loader_options: {})
      @name = name
      @value = value
      @type = type
      @loader_options = loader_options
    end

    def to_association
      Association.build(
        name: name,
        type: type,
        value: value,
        loader_options: loader_options
      )
    end

    def initialize_dup(*)
      @loader_options = @loader_options.deep_dup
      @value = @value.deep_dup

      super
    end
  end
end
