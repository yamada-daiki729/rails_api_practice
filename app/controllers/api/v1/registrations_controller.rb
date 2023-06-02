module Api
  module V1
    class RegistrationsController < BaseController
      skip_before_action :authenticate

      def create
        @user = User.new(user_params)
        if @user.save
          api_key = create_access_token(@user)
          json_string = UserSerializer.new(@user).serialized_json
          response.headers['AccessToken'] = api_key
          render json: json_string
        else
          render_bad_request(nil, @user.errors.full_messages)
        end
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :password)
      end
    end
  end
end
