# frozen_string_literal: true

class ServiceResponse
  attr_accessor :success, :data, :error

  def initialize(success_, data_ = nil, error_ = nil)
    @success = success_
    @data = data_
    @error = error_
  end
end
