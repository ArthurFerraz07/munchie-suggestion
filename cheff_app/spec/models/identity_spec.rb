require 'rails_helper'

RSpec.describe Identity, type: :model do
  let(:identity) { Identity.new(params) }

  describe 'Validations' do
    context 'when parameters are valid' do
      let(:params) { { login: 'login@email.com', encrypted_password: 'ENCRYPTED_PASSWORD' } }

      it 'is expected to be valid' do
        expect(identity).to be_valid
      end
    end

    context 'when login is missing' do
      let(:params) { { login: nil, encrypted_password: 'ENCRYPTED_PASSWORD' } }

      it 'is expected to be valid' do
        expect(identity).to be_invalid
        expect(identity.errors.messages[:login]).to include("can't be blank")
      end
    end

    context 'when login is not unique' do
      before do
        create(:identity, login: 'not_unique_login')
      end

      let(:params) { { login: 'not_unique_login', encrypted_password: 'ENCRYPTED_PASSWORD' } }

      it 'is expected to be valid' do
        expect(identity).to be_invalid
        expect(identity.errors.messages[:login]).to include('has already been taken')
      end
    end

    context 'when encrypted_password id missing' do
      let(:params) { { login: 'login@email.com', encrypted_password: nil } }

      it 'is expected to be valid' do
        expect(identity).to be_invalid
        expect(identity.errors.messages[:encrypted_password]).to include("can't be blank")
      end
    end
  end
end
