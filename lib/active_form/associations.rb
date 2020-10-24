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

    def self.has_one(name:, form:, default: nil, **finder_options)
      HasOne.new(
        name: name,
        form: form,
        default: default,
        finder_options: finder_options
      )
    end
  end
end
