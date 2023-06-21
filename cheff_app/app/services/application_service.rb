# frozen_string_literal: true

class ApplicationService
  class << self
    def before_call(*callbacks)
      callbacks.each do |callback|
        set_callback :call, :before, callback
      end
    end
  end

  def initialize
    raise StaticClassException
  end

  private

  def return_response(success: true, data: nil, error: nil)
    ServiceResponse.new(success, data, error)
  end
end
