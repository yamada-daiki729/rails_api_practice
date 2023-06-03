RSpec.describe 'Api::V1::Articles', type: :request do
  let!(:user) { create(:user) }
  let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' } }

  describe 'GET /articles' do
    let(:article_num) { 10 }
    let(:http_request) { get api_v1_articles_path, headers: headers }

    before do
      create_list(:article, article_num, user: user)
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

  describe 'GET /article/{id}' do
    let!(:article) { create(:article, user: user) }
    let(:http_request) { get api_v1_article_path(article), headers: headers }

    context 'with access_token' do
      let!(:api_key) { create(:api_key, user: user) }
      let(:headers) { { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json', Authorization: "Bearer #{api_key.access_token}" } }

      it 'returns articles in json format' do
        http_request

        expect(body['data']['id'].to_i).to eq(article.id)
        expect(body.dig('data', 'relationships', 'user', 'data', 'id').to_i).to eq(user.id)
        expect(response).to be_successful
        expect(response).to have_http_status(:ok)
      end
    end

    it_should_behave_like 'unauthorized user'
  end
end