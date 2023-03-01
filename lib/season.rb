class Season
  attr_reader :years, :type, :games

  def initialize(season_details)
    @years = season_details[:season]
    @type = season_details[:type]
    @games = []
  end
end
