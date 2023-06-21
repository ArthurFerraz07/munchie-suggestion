# frozen_string_literal: true

class Identity < ApplicationRecord
  validates :login, uniqueness: { case_sensitive: false }
  validates :login, :encrypted_password, presence: true, allow_blank: false
end
