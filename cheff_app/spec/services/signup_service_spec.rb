require 'rails_helper'

RSpec.describe SignupService, type: :service do
  let(:service) { SignupService.new(email, password) }
  let(:call) { service.call }
  let(:response) { call }

  describe '#call' do
    context 'when parameters are valid' do
      let(:email) { 'login@email.com' }
      let(:password) { '!@#123QWEqwe' }

      it 'is expected to have the correct response' do
        expect(response.success).to be_truthy
        expect(response.error).to be_blank
      end

      it 'is expected to have created the identity' do
        response
        expect(Identity.find_by_login(email)).to be_present
      end
    end

    context 'when email is missing'

    context 'when email is invalid'

    context 'when password is missing'

    context 'when password is invalid'
  end
end
