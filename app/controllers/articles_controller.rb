class ArticlesController < ApplicationController
  def index
    articles = Article.all.extend(ArticlesSerializer)
    render json: articles.to_json
  end

  def create
    article = Article.new(article_params).extend(ArticleSerializer)

    if article.save
      render json: { article: article.to_json }, status: :created
    end
  end

  private

  def article_params
    params.require(:article).permit(:title)
  end
end
