module Api
  module V1
    class AuthenticationsController < BaseController
      def create
        @user = login(params[:email], params[:password])
        if @user
            api_key = create_access_token(@user)
        else
          raise ActiveRecord::RecordNotFound
        end
        response.headers['AccessToken'] = api_key
        json_string = UserSerializer.new(@user).serialized_json
        render json: json_string
      end
    end
  end
end
