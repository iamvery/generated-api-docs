module ArticleSerializer
  def to_json
    {
      id: id,
      title: title,
    }
  end
end
