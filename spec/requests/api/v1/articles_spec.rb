RSpec.describe 'Api::V1::Articles', type: :request do
  let!(:user) { create(:user) }

  describe 'GET /articles' do
    let(:article_num) { 10 }

    before do
      create_list(:article, article_num, user: user)
    end

    it 'returns articles in json format' do
      get api_v1_articles_path, headers: { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }

      expect(body['data'].count).to eq(article_num)
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /article/{id}' do
    let!(:article) { create(:article, user: user) }

    it 'returns articles in json format' do
      get api_v1_article_path(article), headers: { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }

      expect(body['data']['id'].to_i).to eq(article.id)
      expect(body.dig('data', 'relationships', 'user', 'data', 'id').to_i).to eq(user.id)
      expect(response).to be_successful
      expect(response).to have_http_status(:ok)
    end
  end
end