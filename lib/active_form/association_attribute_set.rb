# frozen_string_literal: true

require "active_support/core_ext/object/deep_dup"

module ActiveForm
  class AssociationAttributeSet
    def initialize(associations = {})
      @associations = associations
    end

    def []=(name, value)
      associations[name] = value
    end

    def read_association_value(name)
      associations[name].current_value
    end

    def write_association_value(name, value)
      associations[name].current_value = value
    end

    def to_hash
      associations.transform_values(&:current_value)
    end
    alias to_h to_hash

    def deep_dup
      self.class.new(associations.deep_dup)
    end

    private

    attr_reader :associations
  end
end
