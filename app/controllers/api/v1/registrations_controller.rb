module Api
  module V1
    class RegistrationsController < BaseController
      def create
        @user = User.new(user_params)

        if @user.save
          json_string = UserSerializer.new(@user).serialized_json
          render json: json_string
        else
          render_bad_request(nil, @user.errors.full_messages)
        end
      end

      private

      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end
    end
  end
end
