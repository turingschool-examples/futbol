class SeasonManager
  def initialize(hash)
    @seasons = hash
  end

  def games_in_season(season)
    @seasons[season]
  end

  def game_id_by_season(season)
    games_in_season(season).map do |game|
      game.game_id
    end
  end
end
