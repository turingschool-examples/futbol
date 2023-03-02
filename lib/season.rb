require_relative './game'

class Season
  attr_reader :year,
              :type,
              :games,
              :teams

  def initialize(season_data, team_refs)
    @year = season_data[:games].first[:season]
    @type = season_data[:games].first[:type]
    @teams = team_refs
    @games = create_games(season_data)
  end

  def create_games(season_data)
    season_data[:games].map do |game|
      game_data = {}
      game_data[:game] = game
      game_data[:teams] = team_data_for_game(game, season_data)
      game_data[:game_teams] = game_teams_data_for_game(game, season_data)

      home_team = @teams.find do |team|
        team.id == game_data[:game][:home_team_id]
      end

      away_team = @teams.find do |team|
        team.id == game_data[:game][:away_team_id]
      end

      refs = {
        season: self,
        home_team: home_team,
        away_team: away_team
      }

      Game.new(game_data, refs)
    end
  end

  def team_data_for_game(game, season_data)
    season_data[:teams].filter do |team|
      team[:id] == game[:home_team_id] || team[:id] == game[:away_team_id]
    end
  end

  def game_teams_data_for_game(game, season_data)
    season_data[:game_teams].filter do |game_team|
      game_team[:game_id] == game[:game_id]
    end
  end
end
