# frozen_string_literal: true

module ActiveForm
  class Association
    module Loaders
      class SingularLoader < Base
        private

        def find_by_key(relation, key)
          relation.find_by(id: key)
        end
      end
    end
  end
end
