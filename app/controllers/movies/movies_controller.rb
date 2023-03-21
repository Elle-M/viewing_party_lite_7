class MoviesController < ApplicationController
  def index 
    @facade = MoviesFacade.new
  end

  def search
    conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
      faraday.params['api_key'] = ENV['MOVIE_API_KEY']
    end

    response = conn.get("/3/search/movie") do |req|
      req.params['query'] = params[:search]
    end

    data = JSON.parse(response.body, symbolize_names: true)

    @movies = data[:results].map do |movie_data|
      Movie.new(movie_data)
    end
  end
