require 'csv'

class StatTracker

  attr_reader :games, :teams, :game_teams
  def initialize (games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = CSV.table(locations[:games])
    teams = CSV.table(locations[:teams])
    game_teams = CSV.table(locations[:game_teams])
    StatTracker.new(games, teams, game_teams)
  end

  def total_scores_by_game
    @games.values_at(:away_goals, :home_goals).map do |game|
      game[0] + game[1]
    end
  end

  def lowest_total_score
      total_scores_by_game.min
  end

  def highest_total_score
    total_scores_by_game.max
  end

  def percentage_ties
    ties = 0.0
    total_games = total_scores_by_game.count

    @games.values_at(:away_goals, :home_goals).each do |game|
      ties += 1 if game[0] == game[1]
    end
    ((ties/total_games)*100).round(1)
  end

  def percentage_home_wins
    percentage = (home_wins/home_games) * 100
  end

  def game_wins
    win = 0.0
    @game_teams[:result].map {|row| win += 1 if row == "WIN"}; win
  end 

  def game_losses
    loss = 0.0
    @game_teams[:result].map {|row| loss += 1 if row == "LOSS"}; loss
  end

  def home_games
    home = 0.0
    @game_teams[:hoa].map {|row| home += 1 if row == "home"}; home
  end

  def away_games
    away = 0.0
    @game_teams[:hoa].map {|row| away += 1  if row == "away"}; away
  end

  def home_wins
    home_win = 0.0
    @game_teams.values_at(:result, :hoa).flat_map {|row| home_win += 1 if row == ["WIN", "home"]}; home_win
  end

  def average_goals_per_game
    total_scores_by_game.sum/@games.size
  end 
end
