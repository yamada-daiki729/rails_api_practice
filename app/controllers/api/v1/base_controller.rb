# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      include Api::ExceptionHandler
      include ActionController::HttpAuthentication::Token::ControllerMethods

      before_action :authenticate

      protected

      def authenticate
        authenticate_or_request_with_http_token do |token, _options|
          @_current_user ||= ApiKey.still_valid.find_by(access_token: token)&.user
        end
      end

      def current_user
        @_current_user
      end

      def set_access_token!(user)
        api_key = find_valid_access_token(user)
        response.headers['AccessToken'] = api_key
      end

      private

      def form_authenticity_token; end

      def create_access_token(user)
        # access_tokenがあるか確認しかつ有効期限が過ぎていないtokenを確認する
        if user_has_access_token?(user) && find_valid_access_token(user)
          # 有効期限が切れていないtokenがあるならばそのトークンを返す
          return find_valid_access_token(user).access_token
        end

        # access_tokenがないか、有効期限切れているならば新規発行をする
        api_key = ApiKey.new(user_id: user.id, access_token: generate_access_token, expires_at: Time.current + 1.week)

        raise 'Failed to create API key' unless api_key.save

        api_key.access_token
      end

      def find_valid_access_token(user)
        user.apikeys.still_valid.order(created_at: :desc).first
      end

      def user_has_access_token?(user)
        ApiKey.exists?(user_id: user.id)
      end

      def generate_access_token
        SecureRandom.uuid
      end
    end
  end
end
