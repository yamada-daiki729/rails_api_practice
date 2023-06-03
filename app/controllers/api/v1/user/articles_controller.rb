module Api
  module V1
    class User::ArticlesController < BaseController
      def index
        articles = current_user.articles
        json_articles = ArticleSerializer.new(articles).serializable_hash.to_json

        render json: json_articles
      end

      def create
        article = current_user.articles.build(article_params)
        if article.save
          json_article = ArticleSerializer.new(article).serializable_hash.to_json
          render json: json_article
        else
          render_bad_request(nil, article.errors.full_messages)
        end
      end

      def update
        article = current_user.articles.find(params[:id])
        if article.update(article_params)
          json_article = ArticleSerializer.new(article).serializable_hash.to_json
          render json: json_article
        else
          render_bad_request(nil, article.errors.full_messages)
        end
      end

      def destroy
        article = current_user.articles.find(params[:id])
        article.destroy!
        render json: '削除成功'
      end

      private

      def article_params
        params.require(:article).permit(:title, :contents, :status)
      end
    end
  end
end
