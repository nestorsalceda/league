class MatchRepository
  def initialize
    @matches = []
  end

  def put(match)
    @matches << match
  end

  def all
    @matches
  end
end
