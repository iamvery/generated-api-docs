module ArticlesSerializer
  def to_json(_ = nil)
    articles = map { |a| a.extend(ArticleSerializer).to_json }
    { articles: articles }
  end
end
