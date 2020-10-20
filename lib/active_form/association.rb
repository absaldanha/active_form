# frozen_string_literal: true

module ActiveForm
  class Association
    attr_reader :id, :finder, :loaded

    def initialize(id: nil, finder:, current_value: nil, loaded: false)
      @id = id
      @loaded = loaded
      @current_value = current_value
      @finder = finder
    end

    def current_value
      return @current_value if loaded?

      load_value!
    end

    def current_value=(new_value)
      raise "Invalid Association" unless new_value.respond_to?(:id)

      @loaded = true
      @id = new_value.id
      @current_value = new_value
    end

    def id=(new_id)
      @loaded = false
      @current_value = nil
      @id = new_id
    end

    private

    def loaded?
      loaded
    end

    def load_value!
      value = finder.find(id: id) if id

      @loaded = true
      @current_value = value
    end
  end
end
