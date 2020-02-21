require_relative 'game_collection'
require_relative 'game_team_collection'
require_relative 'team_collection'

class SeasonStat

  def initialize(game_file_path, team_file_path, game_team_file_path)
    @game_collection = GameCollection.new(game_file_path)
    @team_collection = TeamCollection.new(team_file_path)
    @game_team_collection = GameTeamCollection.new(game_team_file_path)
    @team_info = nil
    @season_list = @game_collection.get_all_seasons
  end

  def get_season_games(season)
    @game_collection.games_list.find_all do |game|
      game.season == season
    end
  end

  def count_of_season_games(season)
    get_season_games(season).size
  end

  def average_goals_per_game_per_season(season)
  total = 0
    get_season_games(season).each do |game|
      total += (game.home_goals + game.away_goals)
    end
    (total.to_f / count_of_season_games(season)).round(2)
  end

  def average_goals_by_season
    @season_list.reduce({}) do |season_goals, season|
      season_goals[season] = average_goals_per_game_per_season(season)
      season_goals
    end

  end

  def count_of_games_by_season
    @season_list.reduce({}) do |season_games_hash, season|
      season_games_hash[season] = count_of_season_games(season)
      season_games_hash
    end
  end

  def games_by_type(game_type, season)
    get_season_games(season).find_all do |game|
      game.type == game_type
    end
  end

  def get_team_info(season)
    @team_collection.teams_list.reduce({}) do |team_hash, team|
      team_hash[team.team_id] = {
         team_name: team.team_name,
         season_win_percent: team_win_percentage(team.team_id, 'Regular Season', season),
         postseason_win_percent: team_win_percentage(team.team_id, 'Postseason', season)
}
      @team_info = team_hash
    end
  end

  def total_team_games_by_game_type(team_id, game_type, season)
    total_games = 0

    total_games += get_season_games(season).find_all do |game|
       game.away_team_id == team_id && game.type == game_type
     end.length

    total_games += get_season_games(season).find_all do |game|
       game.home_team_id == team_id  && game.type == game_type
     end.length

    total_games
  end

  def total_team_wins_by_game_type(team_id, game_type, season)
    wins = 0
    wins += get_season_games(season).find_all do |game|
      game.away_team_id == team_id && game.away_goals > game.home_goals && game.type == game_type
    end.length
    wins += get_season_games(season).find_all do |game|
      game.home_team_id == team_id && game.home_goals > game.away_goals && game.type == game_type
    end.length
  end

  def team_win_percentage(team_id, game_type, season)
    total_wins = total_team_wins_by_game_type(team_id, game_type, season).to_f
    total_games = total_team_games_by_game_type(team_id, game_type, season)
    ((total_wins / total_games) * 100).round(2)
  end

  def get_regular_percents(game_type)
    @team_info.map do |team_info, team|
      team_info[team] = team_win_percentage(team, game_type)
    end
  end
end
