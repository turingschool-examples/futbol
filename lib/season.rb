require "CSV"

class Season
  attr_reader :id, :games_in_season

  def initialize(season_hash)
    @id = season_hash[:id]
    @games_in_season = games_gather(season_hash[:path])
    # @type = season_hash[:type]
  end

  def games_gather(games_path)

  end
end
