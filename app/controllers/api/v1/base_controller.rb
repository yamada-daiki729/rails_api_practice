# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      include Api::ExceptionHandler

      private

      def form_authenticity_token; end
    end
  end
end
