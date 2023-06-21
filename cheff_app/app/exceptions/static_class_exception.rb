# frozen_string_literal: true

class StaticClassException < ApplicationException
  def initialize(message = 'This class should not be initialized')
    super(message)
  end
end
