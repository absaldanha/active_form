# frozen_string_literal: true

require "test_helper"
require "support/database_setup"
require "support/models/team"

module ActiveForm
  class AssociationWithDefaultTest < Minitest::Test
    class SampleWithDefault
      include ActiveForm::Form

      has_one :team, default: -> { Team.first }
    end

    def setup
      @team = Team.create(name: "FooTeam")
    end

    def test_association_with_default
      form = SampleWithDefault.new

      assert_instance_of(Team, form.team)
      assert_equal(@team.id, form.team.id)
    end
  end
end
