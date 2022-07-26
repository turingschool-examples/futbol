require 'csv'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams
              :percentage_visitor_wins

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = CSV.table(locations[:games], converters: :all)
    teams = CSV.table(locations[:teams], converters: :all)
    game_teams = CSV.table(locations[:game_teams], converters: :all)
    StatTracker.new(games, teams, game_teams)
  end


  def percentage_visitor_wins
    
    # require 'pry';binding.pry
    total_away_wins = @game_teams.count do |game_team| 
      game_team[:hoa] == "away" && game_team[:result] == "WIN"
    end
    (total_away_wins/@games.length.to_f).round(2)
    # (game[:away_wins]/(total_away_games.to_f).round(2))
  end
end
