# frozen_string_literal: true

module ActiveForm
  class AssociationAttributeSet
    def self.build(associations:, form:)
      new.tap do |set|
        associations.each do |name, options|
          finder = AssociationFinder.new(options.merge(form: form))
          set[name] = Association.new(finder: finder)
        end
      end
    end

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

    def read_association_id(name)
      associations[name].id
    end

    def write_association_id(name, id)
      associations[name].id = id
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
