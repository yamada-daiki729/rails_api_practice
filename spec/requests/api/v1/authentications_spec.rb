RSpec.describe 'Api::V1::Authentications', type: :request do
  let(:password) { 'password' }
  let!(:user) { create(:user, password: password) }

  describe 'POST /authentications' do
    context 'when email and password is valid' do
      it 'returns user in json format' do
        request_hash = { headers: { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }, params: { email: user.email, password: password }.to_json }
        post api_v1_authentication_path, request_hash

        expect(body['data']['id'].to_i).to eq(user.id)
        expect(body['data']['type']).to eq('user')
        expect(body['data']['attributes']['name']).to eq(user.name)
        expect(body['data']['attributes']['email']).to eq(user.email)
        expect(response.headers['AccessToken']).to be_present
        expect(response).to be_successful
        expect(response).to have_http_status(200)
      end
    end

    context 'when email and password is invalid' do
      it 'returns user in json format' do
        post api_v1_authentication_path, { headers: { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }, params: { email: user.email, password: 'wrong_password' }.to_json }

        expect(body['message']).to eq('Record Not Found')
        expect(body['errors'].count).to eq(1)
        expect(response).to have_http_status(404)
      end
    end
  end
end
