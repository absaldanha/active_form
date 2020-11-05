# frozen_string_literal: true

require "active_support/concern"
require "active_support/core_ext/class/attribute"
require "active_support/core_ext/object/deep_dup"
require "active_support/core_ext/string"
require "active_support/core_ext/module/delegation"
require "active_model"

require "active_form/version"
require "active_form/errors"
require "active_form/association"
require "active_form/association_set"
require "active_form/association_definition"
require "active_form/association_definition_set"
require "active_form/dsl"
require "active_form/form"

module ActiveForm
end
