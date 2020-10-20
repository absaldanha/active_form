# frozen_string_literal: true

require "active_support/core_ext/string"

module ActiveForm
  class AssociationFinder
    attr_reader :class_name

    def initialize(name:)
      @class_name = name.to_s.classify.constantize
    end

    def find(id:)
      class_name.find_by(id: id)
    end
  end
end
