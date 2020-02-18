require "CSV"

class Season
attr_reader :id, :games_in_season

  def initialize(season_hash)
    @id = season_has[:id]
    @games_in_season = games_gather(season_hash[:path])
  end


end
