class Api::V1::ArticlesController < ApplicationController
  BASE_URL = "https://gnews.io/api/v4/"
  VALID_CATEGORIES = %w(general world nation business technology entertainment sports science health)

  before_action :validate_category!, if: -> { params[:category].present? }

  api :GET, '/v1/articles/', 'List of Articles'
  param :keyword, String, desc: 'This parameter allows you to specify your search keywords to find the news articles you are looking for. If category provided then keyword is not needed.', :required => true
  param :category, String, desc: 'This parameter allows you to change the category for the request. The available categories are : general, world, nation, business, technology, entertainment, sports, science and health. If keyword provided then category is not needed', :required => true
  param :max_records, Integer, desc: 'This parameter allows you to specify the number of news articles returned by the API'
  returns :code => 200, :desc => "the list of articles" do
    property :totalArticles, Integer, desc: "Total articles matching the query"
    property :articles, Array, dess: "The list of articles" do
      property :title, String, desc: "The article's title"
      property :description, String, desc: "The article's description"
      property :content, String, desc: "The article's content"
      property :url, String, desc: "The article's url"
      property :image, String, desc: "The article's image url"
      property :publishedAt, String, desc: "The article's published date"
      property :source, Hash, desc: "The article's source" do
        property :name, String, desc: "The article's source name"
        property :url, String, desc: "The article's source url"
      end
    end
 end
  def index
    @articles = RestClient.get(build_url)
    render json: @articles, status: :ok
  end

  private

  def build_url
    if params[:category].present?
      "#{BASE_URL}#{search_by_category}#{search_max_records}#{authentication}"
    else
      "#{BASE_URL}#{search_by_keyword}#{search_max_records}#{authentication}"
    end
  end

  def validate_category!
    unless VALID_CATEGORIES.include?(params[:category])
      render json: { 
        error: "Invalid category. Valid categories are: #{VALID_CATEGORIES.join(", ")}"
      }, status: :bad_request
    end
  end

  def search_by_keyword
    "search?q=#{params[:keyword]}&in=title,description"
  end

  def search_max_records
    return "&max=#{params[:max_records]}" if params[:max_records].present?

    "&max=10"
  end

  def search_by_category
    "top-headlines?category=#{params[:category]}"
  end

  def authentication
    "&apikey=#{ENV['GNEWS_API_KEY']}"
  end
end