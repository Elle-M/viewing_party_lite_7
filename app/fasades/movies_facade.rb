class MovieFacade
  def initialize(params)
    @params = params
  end

  def movies
    @movies ||= MovieService.new(@params).movies
  end
end