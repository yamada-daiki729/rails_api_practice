module Api
  module V1
    class AuthenticationsController < BaseController
      def create
        @user = login(params[:email], params[:password])

        raise ActiveRecord::RecordNotFound unless @user

        json_string = UserSerializer.new(@user).serialized_json
        render json: json_string
      end
    end
  end
end
