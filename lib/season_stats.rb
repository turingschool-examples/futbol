class SeasonStats
  attr_reader :games_collection,
              :teams_collection,
              :game_teams_collection

  def initialize(file_path)
    @games_collection = file_path[:games_collection]
    @teams_collection = file_path[:teams_collection]
    @game_teams_collection = file_path[:game_teams_collection]
  end

  def games_by_season(season)
    @games_collection.games.find_all do |game|
      game.season == season
    end
  end

  def game_ids_by_season(season)
    games_by_season(season).map do |game|
      game.game_id
    end
  end
end
