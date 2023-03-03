require_relative './season'
require_relative './team'

class League
  attr_reader :name,
              :teams,
              :seasons,
              :games

  def initialize(name, data)
    @name = name
    @teams = create_teams(data[:teams])
    @games = create_games(data)
    @seasons = create_seasons(data)
  end

  def create_teams(teams_data)
    teams_data.map do |team_data|
      Team.new(team_data)
    end
  end

  def create_seasons(data)
    games_with_unique_seasons = data[:games].uniq do |game_data|
      game_data[:season]
    end
    games_with_unique_seasons.map do |game_data|
      season_game_refs = @games.filter do |game|
        game.info[:season] == game_data[:season]
      end

      season_team_refs = @teams.filter do |team|
        season_team_ids = season_game_refs.map do |game|
          [game.info[:home_team_id], game.info[:away_team_id]]
        end.flatten.uniq
        season_team_ids.include?(team.id)
      end
      Season.new(game_data[:season], season_team_refs, season_game_refs)
    end
  end

  def create_games(data)
    data[:games].map do |game|
      game_data = {}
      game_data[:game] = game
      game_data[:game_teams] = data[:game_teams].filter do |game_team|
        game_team[:game_id] == game[:game_id]
      end

      home_team = @teams.find do |team|
        team.id == game_data[:game][:home_team_id]
      end

      away_team = @teams.find do |team|
        team.id == game_data[:game][:away_team_id]
      end

      team_refs = {
        home_team: home_team,
        away_team: away_team
      }

      Game.new(game_data, team_refs)
    end
  end

end
