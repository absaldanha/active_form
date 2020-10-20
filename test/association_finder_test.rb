# frozen_string_literal: true

require "test_helper"
require "models/user"

module ActiveForm
  class AssociationFinderTest < Minitest::Test
    def test_find
      finder = AssociationFinder.new(name: :user)

      assert_equal("a result", finder.find(id: 42))
    end
  end
end
