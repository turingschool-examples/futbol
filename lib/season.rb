require_relative 'game_collection'
require_relative 'game_team_collection'
require_relative 'team_collection'

class SeasonStat
  attr_reader :all_games

  def initialize(game_collection, team_collection, game_team_collection)
    @game_collection = game_collection
    @team_collection = team_collection
    @game_team_collection = game_team_collection
    @all_games = get_season_games(season)
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

  def games_by_type(game_type)
    @all_games.find_all do |game|
      game.type == game_type
    end
  end

  def get_team_info
    @team_collection.teams_list.reduce({}) do |team_hash, team|
      team_hash[team.team_id] = {
         team_name: team.team_name,
         season_win_percent: team_win_percentage(team.team_id, 'Regular Season'),
         postseason_win_percent: team_win_percentage(team.team_id, 'Postseason')
}
      @team_info = team_hash
    end
  end

  def total_team_games_by_game_type(team_id, game_type)
    total_games = 0

    total_games += @all_games.find_all do |game|
       game.away_team_id == team_id && game.type == game_type
     end.length

    total_games += @all_games.find_all do |game|
       game.home_team_id == team_id  && game.type == game_type
     end.length

    total_games
  end

  def total_team_wins_by_game_type(team_id, game_type)
    wins = 0
    wins += @all_games.find_all do |game|
      game.away_team_id == team_id && game.away_goals > game.home_goals && game.type == game_type
    end.length
    wins += @all_games.find_all do |game|
      game.home_team_id == team_id && game.home_goals > game.away_goals && game.type == game_type
    end.length
  end

  def team_win_percentage(team_id, game_type)
    total_wins = total_team_wins_by_game_type(team_id, game_type).to_f
    total_games = total_team_games_by_game_type(team_id, game_type)
    ((total_wins / total_games) * 100).round(2)
  end

  def get_regular_percents(game_type)
    @team_info.map do |team_info, team|
      team_info[team] = team_win_percentage(team, game_type)
    end
  end
end
