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
    p percentage
  end

  def game_wins
    win = []
    @game_teams[:result].map {|row| win << row   if row == "WIN"}; p win.count.to_f
  end 

  def game_losses
    loss = []
    @game_teams[:result].map {|row| loss << row   if row == "LOSS"}; p loss.count.to_f
  end

  def home_games
    home = []
    @game_teams[:hoa].map {|row| home << row   if row == "home" }; p home.count.to_f
  end

  def away_games
    away = []
    @game_teams[:hoa].map {|row| away << row   if row == "away"}; p away.count.to_f
  end

  def home_wins #(home, wins)
    home_win = [] 
    @game_teams.values_at(:result, :hoa).flat_map {|row| home_win << row if row == ["WIN", "home"]}; p home_win.count.to_f
  end

end
