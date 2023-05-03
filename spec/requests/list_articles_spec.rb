# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Articles - List', type: :request do
  describe 'list of articles' do
    let(:article_records) { build_list(:article, 2) }

    it 'succeeds' do
      get api_v1_articles_path

      expect(response).to have_http_status(:ok)
    end
  end
end