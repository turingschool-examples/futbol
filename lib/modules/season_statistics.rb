require_relative 'calculable'
require_relative 'hashable'

module SeasonStatistics
  include Calculable
  include Hashable

  def find_games_in_season(season)
    @games.find_all do |game|
      game.season == season
    end
  end

  def find_game_teams_in_season(season)
    @game_teams.find_all do |game_team|
      game_team_season = @games.find do |game|
        game.game_id == game_team.game_id
      end.season
      game_team_season == season
    end
  end

  def all_teams_playing
    @game_teams.map {|game_team| game_team.team_id}.uniq
  end

  def gameid_of_games_that_season(season_id)
    games_that_season = @games.find_all {|game| game.season == season_id}
    games_that_season.map {|game| game.game_id}
  end

  def game_teams_that_season(team_id, season_id)
    @game_teams.find_all do |game_team|
      gameid_of_games_that_season(season_id).include?(game_team.game_id) && game_team.team_id == team_id
    end
  end

  def create_hash_with_team_games_by_team(season_id)
    all_teams_playing.reduce({}) do |teams_and_games, team_id|
      teams_and_games[team_id] = game_teams_that_season(team_id, season_id)
      teams_and_games
    end
  end

  def tackles_per_team_in_season(team_id, season_id)
    create_hash_with_team_games_by_team(season_id)[team_id].sum { |game_team| game_team.tackles }
  end

  def most_tackles(season_id)
    team_id = all_teams_playing.max_by do |team|
      tackles_per_team_in_season(team, season_id)
    end
    find_team_names(team_id)
  end

  def fewest_tackles(season_id)
    team_id = all_teams_playing.min_by do |team|
      tackles_per_team_in_season(team, season_id)
    end
    find_team_names(team_id)
  end
end
