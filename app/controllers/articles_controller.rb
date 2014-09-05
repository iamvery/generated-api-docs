class ArticlesController < ApplicationController
  def index
    articles = Article.all.extend(ArticlesSerializer)
    render json: articles.to_json
  end
end
