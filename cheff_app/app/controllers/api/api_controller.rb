# frozen_string_literal: true


module Api
  class ApiController < ApplicationController
    def return_response(status: :ok, data: nil)
      json = { status:, data: }
      render(json:, status:)
    end
  end
end
