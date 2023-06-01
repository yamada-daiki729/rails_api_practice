# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      include Api::ExceptionHandler

      private

      def form_authenticity_token; end

      def create_access_token(user)
        # access_tokenがあるか確認しかつ有効期限が過ぎていないtokenを確認する
        if user_has_access_token?(user) && find_valid_access_token(user)
          # 有効期限が切れていないtokenがあるならばそのトークンを返す
          find_valid_access_token(user).access_token
        else
          # access_tokenがないか、有効期限切れているならば新規発行をする
          apikey = Apikey.new(user_id: user.id, access_token: generate_access_token, expires_at: Time.current + 1.week)
          if apikey.save
            apikey.access_token
          else
            raise "Failed to create API key"
          end
        end
      end

      def find_valid_access_token(user)
        user.apikeys.still_valid.order(created_at: :desc).first
      end

      def user_has_access_token?(user)
        Apikey.exists?(user_id: user.id)
      end

      def generate_access_token
        SecureRandom.uuid
      end
    end
  end
end
