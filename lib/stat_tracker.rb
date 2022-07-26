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
    games = CSV.table(locations[:games], converters: :all)
    teams = CSV.table(locations[:teams], converters: :all)
    game_teams = CSV.table(locations[:game_teams], converters: :all)
    StatTracker.new(games, teams, game_teams)
  end

  def total_scores_per_game
    games[:away_goals].sum + games[:home_goals].sum
  end

  def lowest_total_score
    @games.map {|game| game[:away_goals] + game[:home_goals]}.min
  end

  def highest_total_score
    @games.map{|game| game[:away_goals] + game[:home_goals]}.max
  end

  def average_goals_per_game
    total_goals = @games.sum{ |game| game[:away_goals] + game[:home_goals] }
    (total_goals.to_f / @games.length).round(2)
  end


  def percentage_ties
    total_tie_games = @games.count{ |game| game[:away_goals] == game[:home_goals] }
    (total_tie_games.to_f / @games.length).round(2)
  end

  def percentage_home_wins
    home_wins = @game_teams.count{ |game_team| game_team[:hoa] == "home" && game_team[:result] == "WIN" }
    total_games = @games.length
    (home_wins.to_f / total_games).round(2)
  end

end
