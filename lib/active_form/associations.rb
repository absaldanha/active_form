# frozen_string_literal: true

require "active_form/associations/base"
require "active_form/associations/has_one"

module ActiveForm
  module Associations
    def self.build_from_options(options:, form:)
      options.transform_values do |opts|
        Associations.build(form: form, **opts)
      end
    end

    def self.build(name:, type:, form:, **options)
      case type
      when :has_one
        has_one(name: name, form: form, **options)
      end
    end

    def self.has_one(name:, form:, value: nil, **options)
      HasOne.new(name: name, form: form, value: value, finder_options: options)
    end
  end
end
