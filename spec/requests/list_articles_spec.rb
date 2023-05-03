# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Articles - List', type: :request do
  describe 'list of articles' do
    let(:article_records) { build_list(:article, 2) }

    it 'succeeds' do
      stub_request(:get, 
        "https://gnews.io/api/v4/search?q=example&in=title,description&max=10&apikey=test_api_key")
        .to_return(
          :body => "",
          :status => 200,
          :headers => { 'Content-Length' => 3 }
        )

      get api_v1_articles_path, params: { keyword: 'example' }

      expect(response).to have_http_status(:ok)
    end
  end

  describe 'validations' do
    let(:article_records) { build_list(:article, 2) }

    it 'failed with invalid data' do
      get api_v1_articles_path, params: { category: 'invalid' }

      expect(response).to have_http_status(:bad_request)
    end
  end
end