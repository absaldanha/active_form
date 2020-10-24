# frozen_string_literal: true

module ActiveForm
  module Finders
    class HasOne < Base
      private

      def find_by_key(relation, key)
        relation.find_by(id: key)
      end
    end
  end
end
