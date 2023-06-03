RSpec.describe 'Api::V1::User::Articles', type: :request do
  let!(:user) { create(:user) }
  let!(:another_user) { create(:user) }
  let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }

  describe 'GET articles owned by current_user' do
    let(:article_num) { 5 }
    let(:http_request) { get api_v1_user_articles_path, headers: headers }

    before do
      create_list(:article, article_num, user: user)
      create(:article, user: another_user)
    end

    context 'with access_token' do
      let!(:api_key) { create(:api_key, user: user) }
      let!(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json', Authorization: "Bearer #{api_key.access_token}" } }

      it 'returns articles in json format' do
        http_request

        expect(body['data'].count).to eq(article_num)
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    it_should_behave_like 'unauthorized user'
  end

  describe 'POST /user/articles' do
    let!(:request_hash) { {} }
    let(:http_request) { post api_v1_user_articles_path, request_hash }

    context 'with access_token' do
      let!(:api_key) { create(:api_key, user: user) }
      let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json', Authorization: "Bearer #{api_key.access_token}" } }
      let!(:request_hash) { { headers: headers, params: { article: attributes_for(:article) }.to_json } }

      it 'returns articles in json format' do
        expect {
          http_request
        }.to change(Article, :count).by(1)

        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    it_should_behave_like 'unauthorized user'
  end

  describe 'PATCH /user/articles/{id}' do
    let!(:request_hash) { {} }
    let!(:article) { create(:article, user: user) }
    let(:http_request) { patch api_v1_user_article_path(article), request_hash }

    context 'with access_token' do
      let!(:api_key) { create(:api_key, user: user) }
      let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json', Authorization: "Bearer #{api_key.access_token}" } }
      let(:changed_title) { 'changed_title' }
      let!(:request_hash) { { headers: headers, params: { article: { title: changed_title } }.to_json } }

      it 'returns articles in json format' do
        http_request

        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    it_should_behave_like 'unauthorized user'
  end

  describe 'DELETE /user/articles/{id}' do
    let!(:request_hash) { {} }
    let!(:article) { create(:article, user: user) }
    let(:http_request) { delete api_v1_user_article_path(article), request_hash }

    context 'with access_token' do
      let!(:api_key) { create(:api_key, user: user) }
      let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json', Authorization: "Bearer #{api_key.access_token}" } }
      let!(:request_hash) { { headers: headers } }

      it 'returns articles in json format' do
        expect {
          http_request
        }.to change(Article, :count).by(-1)

        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    it_should_behave_like 'unauthorized user'
  end
end
