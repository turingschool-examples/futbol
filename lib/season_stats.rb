class SeasonStats
  attr_reader :games_collection,
              :teams_collection,
              :game_teams_collection

  def initialize(file_path)
    @games_collection = file_path[:games_collection]
    @teams_collection = file_path[:teams_collection]
    @game_teams_collection = file_path[:game_teams_collection]
  end

  # # def games_by_coach(head_coach)
  # #   @game_teams_collection.game_teams.find_all do |game_team|
  # #     game_team.head_coach == head_coach
  # #   end
  # # end
  # def games_by_season(season)
  #   @games_collection.games.find_all do |game|
  #     game.season == season
  #   end
  # end
  #
  # def game_teams_by_season(season)
  #   acc = []
  #   @game_teams_collection.game_teams.each do |game_team|
  #     games_by_season(season).each do |game|
  #       if game_team.game_id == game.game_id
  #         acc << game_team
  #       end
  #     end
  #   end
  #   acc
  # end
  #
  # def winningest_coach(season)
  #   wins = Hash.new(0)
  #   games_by_season(season).each do |game|
  #   end
  # end
  #
  # def winningest_coach(season)
  #   wins = 0
  #   games_by_season(season).each do |game|
  #     if game.result == "WIN"
  #       wins += 1
  #     end
  #   end
  # end

  def most_tackles(season)
    year = season[0..3]
    season_games = @game_teams_collection.game_teams.select do |game|
      game.game_id.start_with?(year)
    end
    by_teams = season_games.group_by { |team| team.team_id }
    by_teams.map do |team_id, games|
      by_teams[team_id] = games.sum { |game| game.tackles.to_i }
    end
    tackles = by_teams.select { |_,value| value == by_teams.values.max}
    @teams_collection.teams.find do |team|
      team.team_id == tackles.keys[0]
    end.teamname
  end

  def fewest_tackles(season)
    year = season[0..3]
    season_games = @game_teams_collection.game_teams.select do |game|
      game.game_id.start_with?(year)
    end
    by_teams = season_games.group_by { |team| team.team_id }
    by_teams.map do |team_id, games|
      by_teams[team_id] = games.sum { |game| game.tackles.to_i }
    end
    tackles = by_teams.select { |_,value| value == by_teams.values.min}
    @teams_collection.teams.find do |team|
      team.team_id == tackles.keys[0]
    end.teamname
  end

end
