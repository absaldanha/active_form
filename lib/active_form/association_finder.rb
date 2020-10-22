# frozen_string_literal: true

module ActiveForm
  class AssociationFinder
    attr_reader :class_name, :scope, :form

    def initialize(form:, name:, scope: nil)
      @class_name = name.to_s.classify.constantize
      @scope = scope
      @form = form
    end

    def find(id:)
      class_name
        .yield_self { |relation| scope_relation(form, relation) }
        .yield_self { |relation| relation.find_by(id: id) }
    end

    private

    def scope_relation(form, relation)
      return relation if scope.blank?

      Array(scope).each do |scope_item|
        scope_value = form.public_send(scope_item)
        relation = relation.where(scope_item => scope_value)
      end

      relation
    end
  end
end
