require_relative 'mathable'

class GameTeamsManager
  include Mathable

  def initialize(data)
    @game_teams = data.game_teams
  end

  def percentage_home_wins
    games = @game_teams.find_all do |game_team|
      game_team if game_team.hoa == "home"
    end
    wins = games.find_all do |game|
      game if game.result == "WIN"
    end
    arry_percentage(wins, games)
  end

  def percentage_visitor_wins
    games = @game_teams.find_all do |game_team|
      game_team if game_team.hoa == "away"
    end
    wins = games.find_all do |game|
      game if game.result == "WIN"
    end
    arry_percentage(wins, games)
  end

  def loss_percentage(team1, team2)
    (team1.losses / total_games ).round(2)
  end
end
