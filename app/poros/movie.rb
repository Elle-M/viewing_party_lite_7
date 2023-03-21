class Movie
  attr_reader :title, :vote_average, :id, :runtime, :genres, :overview, :cast, :reviews

  def initialize(data)
    @title = data[:title]
    @vote_average = data[:vote_average]
    @id = data[:id]
    @runtime = data[:runtime]
    @genres = data[:genres]
    @overview = data[:overview]
    @cast = data[:cast]
    @reviews = data[:reviews]
  end
end