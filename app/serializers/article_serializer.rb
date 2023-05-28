class ArticleSerializer
  include FastJsonapi::ObjectSerializer

  belongs_to :user
  attributes :title, :contents, :status
end
