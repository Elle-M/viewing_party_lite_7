class MovieService
  def initialize(params)
    @params = params
  end

  def get_url(url)
    response = conn.get(url) do |req|
      req.params['query'] = @params
    end
  end


  # def conn
  #   Faraday.new(url: "https://api.themoviedb.org") do |faraday|
  #     faraday.params['api_key'] = ENV['MOVIE_API_KEY']
  #   end
  # end
  # def search
  #   conn = Faraday.new(url: "https://api.themoviedb.org") do |faraday|
  #     faraday.params['api_key'] = ENV['MOVIE_API_KEY']
  #   end

  #   response = conn.get("/3/search/movie") do |req|
  #     req.params['query'] = params[:search]
  #   end

  #   data = JSON.parse(response.body, symbolize_names: true)

  #   @movies = data[:results].map do |movie_data|
  #     Movie.new(movie_data)
  #   end
end