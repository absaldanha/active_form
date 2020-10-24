# frozen_string_literal: true

module ActiveForm
  class AssociationMethodBuilder
    def self.generate(name:, klass:)
      klass.class_eval(<<-RUBY)
        def #{name}
          associations[:#{name}].value
        end

        def #{name}=(new_value)
          associations[:#{name}].value = new_value
        end

        def #{name}_id
          associations[:#{name}].key
        end

        def #{name}_id=(new_id)
          associations[:#{name}].key = new_id
        end
      RUBY
    end
  end
end
