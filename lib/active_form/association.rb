# frozen_string_literal: true

require "active_form/association/values"
require "active_form/association/loaders"

module ActiveForm
  class Association
    attr_reader :name, :loader

    delegate :load, to: :loader

    def self.build(type:, name:, value: nil, loader_options: {})
      case type
      when :singular
        value = Values::SingularValue.new(value)
        loader = Loaders::SingularLoader.new(name: name, **loader_options)

        new(name: name, value: value, loader: loader)
      else
        raise InvalidAssociationType, type
      end
    end

    def initialize(name:, value: nil, loader: nil)
      @name = name
      @value = value || Values::NullValue.new
      @loader = loader || Loaders::NullLoader.new
      @loaded = value.current.present?
    end

    def value=(new_value)
      @value.current = new_value

      loaded!

      value
    end

    def value
      @value.current
    end

    def key=(new_key)
      @value.key = new_key

      unloaded!

      key
    end

    def key
      @value.key
    end

    def loaded?
      @loaded
    end

    private

    def loaded!
      @loaded = true
    end

    def unloaded!
      @loaded = false
      @value.current = nil
    end
  end
end
