# frozen_string_literal: true

module Api
  class IdentitiesController < ApiController
    def signup
      service_response = SignupService.new(signup_params[:email], signup_params[:password]).call
      if service_response.success
        return_response(data: IdentitySerializer.new(service_response.data).serialize)
      else
        return_response(status: :bad_request, data: service_response.error)
      end
    end

    private

    def signup_params
      params.permit(:email, :password)
    end
  end
end
