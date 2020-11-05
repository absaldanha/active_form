# frozen_string_literal: true

module ActiveForm
  module Form
    extend ActiveSupport::Concern

    included do
      include ActiveModel::Attributes
      include ActiveModel::AttributeAssignment
      include ActiveModel::Validations
      include DSL
    end

    def initialize(attributes = {})
      super()

      assign_attributes(attributes) if attributes
    end
  end
end
