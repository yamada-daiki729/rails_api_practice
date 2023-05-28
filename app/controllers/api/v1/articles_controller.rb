# frozen_string_literal: true

module Api
  module V1
    class ArticlesController < BaseController
      def index
        articles = Article.all
        json_articles = ArticleSerializer.new(articles).serializable_hash.to_json
        render json: json_articles
      end

      def show
        article = Article.find(params[:id])
        json_article = ArticleSerializer.new(article)
        render json: json_article
      end
    end
  end
end
