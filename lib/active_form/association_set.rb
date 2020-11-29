# frozen_string_literal: true

module ActiveForm
  class AssociationSet
    attr_accessor :form

    def initialize(associations: {}, form: nil)
      @associations = associations
      @form = form
    end

    def add(association)
      associations[association.name] = association
    end

    def read_value(assoc_name)
      assoc = fetch(assoc_name)

      return assoc.value if assoc.loaded?

      loaded_value = assoc.load(read_key(assoc_name), form)
      write_value(assoc_name, loaded_value)
    end

    def write_value(assoc_name, new_value)
      fetch(assoc_name).value = new_value
    end

    def read_key(assoc_name)
      fetch(assoc_name).key
    end

    def write_key(assoc_name, new_key)
      fetch(assoc_name).key = new_key
    end

    def to_h
      associations.keys.each_with_object({}) do |assoc_name, hash|
        hash[assoc_name.to_s] = read_value(assoc_name)
      end
    end

    private

    attr_reader :associations

    def fetch(assoc_name)
      associations.fetch(assoc_name)
    end
  end
end
