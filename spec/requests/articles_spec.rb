require 'rails_helper'

describe '# Group Articles' do
  let(:response_json) { JSON.parse(response.body) }

  describe '## Articles Collection [/articles]' do
    describe '### List all Articles [GET]' do
      it 'responds with success' do |ex|
        get '/articles.json'

        expect(response.status).to eq(200)
      end

      it 'responds with collection of articles', :json  do |ex|
        article = Article.create!(title: 'Write API Docs With This One Weird Trick')

        get '/articles.json'

        expect(response_json).to eq(
          'articles' => [
            {
              'id' => article.id,
              'title' => article.title,
            },
          ],
        )
      end
    end
  end
end
