# frozen_string_literal: true

module ActiveForm
  class Association
    module Values
      class SingularValue < Base
        def current=(new_value)
          if new_value
            raise InvalidAssociationValue unless new_value.respond_to?(:id)

            self.key = new_value.id
          end

          @current = new_value
        end

        def key=(new_key)
          @key = new_key.nil? ? new_key : Integer(new_key)
        rescue ArgumentError
          raise InvalidAssociationKey
        end
      end
    end
  end
end
