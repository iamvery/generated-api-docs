require 'rails_helper'

describe '# Group Articles', :api do
  let(:response_json) { JSON.parse(response.body) }

  class Doc
    attr_reader :example, :expectation, :target

    def initialize(example)
      @example = example
      @expectation = yield
    end

    def to(matcher, output)
      example.metadata[:output] = output
      expectation.to(matcher)
    end
  end

  class StatusCodeDoc < Doc
    def to(matcher)
      super matcher, "+ Response #{matcher.expected}"
    end
  end

  class JsonDoc < Doc
    def to(matcher)
      super matcher, "\n        #{matcher.expected.to_json}\n\n"
    end
  end

  def doc_status_code(*args, &block)
    StatusCodeDoc.new(*args, &block)
  end

  def doc_json(*args, &block)
    JsonDoc.new(*args, &block)
  end

  describe '## Articles Collection [/articles]' do
    describe '### List all Articles [GET]' do
      it 'responds with success' do |ex|
        get '/articles.json'

        doc_status_code(ex) { expect(response.status) }.to eq(200)
      end

      it 'responds with collection of articles', :json  do |ex|
        article = Article.create!(title: 'Write API Docs With This One Weird Trick')

        get '/articles.json'

        doc_json(ex) { expect(response_json) }.to eq(
          'articles' => [
            {
              'id' => article.id,
              'title' => article.title,
            },
          ],
        )
      end
    end

    describe '### Create a new Article [POST]' do
      it 'responds with created' do |ex|
        post '/articles.json', article: { title: 'The Answer' }

        doc_status_code(ex) { expect(response.status) }.to eq(201)
      end

      it 'responds with the created article' do |ex|
        post '/articles.json', article: { title: 'The Answer' }

        doc_json(ex) { expect(response_json) }.to eq(
          'article' => {
            'id' => 1,
            'title' => 'The Answer',
          }
        )
      end
    end
  end
end
