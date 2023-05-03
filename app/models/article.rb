class Article
  include ActiveModel::API
  attr_accessor :id, :title, :description, :content, :url, :image, :published_at, :source
end