# frozen_string_literal: true

FactoryBot.define do
  factory :identity do
    login { FFaker::Internet.email }
    encrypted_password { FFaker::Internet.password }
  end
end
