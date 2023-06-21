# frozen_string_literal: true

module Api
  class ApplicationSerializer
    attr_accessor :object, :params

    def initialize(object, params = {})
      @object = object
      @params = params
    end

    def serialize
      raise NotImplementedError unless object.respond_to?(:attributes)

      object.attributes
    end
  end
end
