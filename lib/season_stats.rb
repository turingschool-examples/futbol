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

  def accuracy_by_game_team(season)
    accuracy_by_team = Hash.new(0)
    game_teams_by_season(season).each do |game_team|
      accuracy = (game_team.goals.to_f / game_team.shots.to_f).round(2)
      accuracy_by_team[game_team] = accuracy
    end
    accuracy_by_team
  end

  def most_accurate_team(season)
    most_accurate = accuracy_by_game_team(season).max_by do |game_team, accuracy|
      accuracy
    end.first.team_id
    @teams_collection.teams.find do |team|
      team.team_id == most_accurate
    end.teamname
  end
end
