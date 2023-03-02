require_relative './season'
require_relative './team'

class League
  attr_reader :name,
              :teams,
              :seasons

  def initialize(name, data)
    @name = name
    @teams = create_teams(data[:teams])
    @seasons = create_seasons(data)
  end

  def create_teams(teams_data)
    teams_data.map do |team_data|
      Team.new(team_data)
    end
  end

  def create_seasons(data)
    seasons = data[:games].map do |game|
      game.filter { |key, _| key == :season || key == :type }
    end.uniq

    seasons.map do |season|
      season_data = season_data(season, data)

      games = season_data[:games].map do |game|
        [game[:home_team_id], game[:away_team_id]]
      end

      season_team_refs = @teams.filter do |team|
        games.flatten.include?(team.id)
      end

      Season.new(season_data, season_team_refs)
    end
  end

  def season_data(season, data)
    season_data = {}
    season_data[:games] = game_data_for_season(season, data)
    season_data[:teams] = team_data_for_season(season, data)
    season_data[:game_teams] = game_teams_data_for_season(season, data)
    season_data
  end

  def game_data_for_season(season, data)
    data[:games].filter do |game|
      game[:season] == season[:season] && game[:type] == season[:type]
    end
  end

  def team_data_for_season(season, data)
    data[:teams].filter do |team|
      season_team_ids = game_data_for_season(season, data).map do |game|
        game.filter { |key, _| key == :home_team_id || key == :away_team_id }
          .values
      end.flatten
      season_team_ids.include?(team[:team_id])
    end
  end

  def game_teams_data_for_season(season, data)
    data[:game_teams].filter do |game_team|
      season_game_ids = game_data_for_season(season, data).map do |game|
        game[:game_id]
      end
      season_game_ids.include?(game_team[:game_id])
    end
  end
end
