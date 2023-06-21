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

    context 'when email is missing' do
      let(:email) { nil }
      let(:password) { '!@#123QWEqwe' }

      it 'is expected to have the correct response' do
        expect(response.success).to be_falsey
        expect(response.error).to eq('Email is blank')
      end

      it 'is expected to not have created the identity' do
        response
        expect(Identity.find_by_login(email)).to be_blank
      end
    end

    context 'when email is invalid' do
      let(:email) { 'invalid_email' }
      let(:password) { '!@#123QWEqwe' }

      it 'is expected to have the correct response' do
        expect(response.success).to be_falsey
        expect(response.error).to eq('Email is invalid')
      end

      it 'is expected to not have created the identity' do
        response
        expect(Identity.find_by_login(email)).to be_blank
      end
    end

    context 'when email already existis' do
      let(:email) { 'already_registered@email.com' }
      let(:password) { '!@#123QWEqwe' }

      before do
        create(:identity, login: email)
      end

      it 'is expected to have the correct response' do
        expect(response.success).to be_falsey
        expect(response.error).to eq('Email already exists')
      end
    end

    context 'when password is missing' do
      let(:email) { 'login@email.com' }
      let(:password) { nil }

      it 'is expected to have the correct response' do
        expect(response.success).to be_falsey
        expect(response.error).to eq('Password is blank')
      end

      it 'is expected to not have created the identity' do
        response
        expect(Identity.find_by_login(email)).to be_blank
      end
    end

    context 'when password is invalid' do
      let(:email) { 'login@email.com' }
      let(:password) { 'invalid pass' }

      it 'is expected to have the correct response' do
        expect(response.success).to be_falsey
        expect(response.error).to eq('Password is invalid')
      end

      it 'is expected to not have created the identity' do
        response
        expect(Identity.find_by_login(email)).to be_blank
      end
    end
  end
end
