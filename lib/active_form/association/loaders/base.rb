# frozen_string_literal: true

module ActiveForm
  class Association
    module Loaders
      class Base
        attr_reader :name, :scope, :conditions

        def initialize(name:, scope: nil, conditions: nil)
          @name = name
          @scope = scope
          @conditions = conditions
        end

        def load(key, form)
          finder_class
            .yield_self { |relation| scope_relation(relation, form) }
            .yield_self { |relation| add_conditions(relation) }
            .yield_self { |relation| find_by_key(relation, key) }
        end

        def initialize_dup(*)
          @scope = @scope.deep_dup
          @conditions = @conditions.deep_dup

          super
        end

        private

        def finder_class
          name.to_s.classify.constantize
        end

        def scope_relation(relation, form)
          return relation if scope.blank?

          Array(scope).each do |scope_item|
            scope_value = form.public_send(scope_item)
            relation = relation.where(scope_item => scope_value)
          end

          relation
        end

        def add_conditions(relation)
          return relation if conditions.blank?

          relation.merge(conditions)
        end

        def find_by_key(_relation, _key); end
      end
    end
  end
end
