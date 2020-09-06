require 'csv'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = CSV.read(locations[:games], headers:true)
    teams = CSV.read(locations[:teams], headers:true)
    game_teams = CSV.read(locations[:game_teams], headers:true)

    new(games, teams, game_teams)
  end

  def highest_total_score
    high_score = @games.max_by do |game|
      game["away_goals"].to_i + game["home_goals"].to_i
    end
    high_score["away_goals"].to_i + high_score["home_goals"].to_i
  end


end
