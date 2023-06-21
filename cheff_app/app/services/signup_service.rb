# frozen_string_literal: true

require 'bcrypt'

class SignupService < ApplicationService
  include ActiveSupport::Callbacks

  EMAIL_REGEXP = URI::MailTo::EMAIL_REGEXP
  PASSWORD_REGEX = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[\W]).{8,}$/.freeze

  attr_accessor :email, :encrypted_password, :password

  define_callbacks :call, :before

  before_call :validate_email, :validate_password, :encrypt_password

  def initialize(email_, password_)
    @email = email_
    @password = password_
  end

  def call
    run_callbacks :call do
      identity = Identity.create!(
        login: email,
        encrypted_password: encrypted_password
      )

      return_response(data: identity)
    end
  rescue SignupException => e
    return_response(success: false, error: e.message)
  rescue ActiveRecord::RecordInvalid => e
    return_response(success: false, error: e.message)
  rescue StandardError
    return_response(success: false, error: 'An unexpected error has occurred')
  end

  private

  def validate_email
    raise SignupException, 'Email is blank' if email.blank?
    raise SignupException, 'Email is invalid' unless email.match?(EMAIL_REGEXP)
  end

  def validate_password
    raise SignupException, 'Password is blank' if password.blank?
    raise SignupException, 'Password is invalid' unless password.match?(PASSWORD_REGEX)
  end

  def encrypt_password
    @encrypted_password = BCrypt::Password.create(@password)
  end
end
