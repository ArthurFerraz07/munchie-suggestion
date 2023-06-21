# frozen_string_literal: true

module Api
  class IdentitySerializer < ApplicationSerializer
    def serialize
      {
        id: object.id,
        email: object.login
      }
    end
  end
end
