# frozen_string_literal: true

module Api
  module V1
    class ArticlesController < BaseController
      def index
        render json: 'hello runteq!'
      end
    end
  end
end
