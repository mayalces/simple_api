# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Articles - Show', type: :request do
  describe 'show article' do
    let(:article_record) { build(:article) }

    it 'succeeds' do
      get api_v1_article_path(article_record.id)

      expect(response).to have_http_status(:ok)
    end
  end
end