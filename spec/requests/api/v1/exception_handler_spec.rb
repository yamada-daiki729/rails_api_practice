RSpec.describe 'Api::ExceptionHandler', type: :request do
  let!(:user) { create(:user) }

  describe 'render 500' do
    it 'returns errors in json format' do
      allow(Article).to receive(:all).and_raise(StandardError)
      get api_v1_articles_path, headers: { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }

      expect(body['message']).to eq('Internal Server Error')
      expect(body['errors'].size).to eq(1)
      expect(response).to have_http_status(500)
    end
  end

  describe 'render 404' do
    let(:id) { 1 }

    it 'returns errors in json format' do
      get api_v1_article_path(id), headers: { CONTENT_TYPE: 'application/json', ACCEPT: 'application/json' }

      expect(body['message']).to eq('Record Not Found')
      expect(body['errors']).to eq(["Couldn't find Article with 'id'=#{id}"])
      expect(response).to have_http_status(404)
    end
  end
end
