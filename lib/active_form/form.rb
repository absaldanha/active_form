# frozen_string_literal: true

module ActiveForm
  module Form
    extend ActiveSupport::Concern

    included do
      include ActiveModel::Attributes
      include ActiveModel::AttributeAssignment
      include ActiveModel::Validations
      include ActiveModel::Validations::Callbacks
      include DSL
    end

    def initialize(attributes = {})
      super()

      assign_attributes(attributes) if attributes
    end

    def attributes
      super.merge(association_set.to_h)
    end
  end
end
