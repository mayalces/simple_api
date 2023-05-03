# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:params) do
    {
      title: 'Some title',
      description: 'Some description'
    }
  end

  let(:article) { Article.new(params) }

  context 'basic Article model' do
    it 'should return title' do
      expect(article.title).to eq(params[:title])
    end

    it 'should return description' do
        expect(article.description).to eq(params[:description])
      end
  end
end