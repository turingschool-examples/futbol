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

  def game_teams_by_season(season)
    game_teams = []
    @game_teams_collection.game_teams.each do |game_team|
      if game_ids_by_season(season).include?(game_team.game_id)
        game_teams << game_team
      end
    end
    game_teams
  end
end
