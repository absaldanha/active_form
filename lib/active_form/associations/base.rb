# frozen_string_literal: true

module ActiveForm
  module Associations
    class Base
      attr_reader :name, :key, :form

      def initialize(name:, form:, value: nil, finder_options: {})
        @name = name
        @form = form
        @finder_options = finder_options

        initialize_value(value)
      end

      def value=(new_value)
        if new_value
          verify_value(new_value)
          assign_value(new_value)
        end

        @loaded = true

        value
      end

      def value
        return @value if loaded?

        load_value!
      end

      def key=(new_key)
        assign_key(new_key)
      end

      def loaded?
        @loaded
      end

      def finder
        @finder ||= finder_class.new(name: name, form: form, **finder_options)
      end

      def type
        :base
      end

      private

      attr_reader :finder_options

      def initialize_value(value)
        if value
          unless value.respond_to?(:call)
            raise InvalidAssociationDefault.new(value)
          end

          self.value = value.call
        else
          @value = nil
          @key = nil
          @loaded = false
        end
      end

      def load_value!
        self.value = finder.find(key)
      end

      def verify_value(_value); end

      def assign_value(_value); end

      def assign_key(_key); end

      def finder_class; Finders::Base; end
    end
  end
end
