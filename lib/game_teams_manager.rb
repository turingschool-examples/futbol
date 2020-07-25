require './lib/game_teams'

class GameTeamsManager

  attr_reader :game_teams_array

  def initialize(game_teams_path)
    @game_teams_array = []
    CSV.foreach(game_teams_path, headers: true) do |row|
      @game_teams_array << GameTeam.new(row)
    end
  end

  def count_home_games
    home_games = []
    @game_teams_array.each do |game|
      if game.hoa.to_s == 'home'
        home_games << game
      end
    end
    home_games
  end

  def home_game_results(home_games)
    home_wins = []
    home_losses = []
    tie_games = []
    results = {}
    home_games.each do |game|
      home_wins << game.game_id if game.result.to_s == 'WIN'
      home_losses << game.game_id if game.result.to_s == 'LOSS'
      tie_games << game.game_id if game.result.to_s == 'TIE'
    end
    results[:wins] = home_wins
    results[:losses] = home_losses
    results[:ties] = tie_games
    results
  end

  def percentage_home_wins(home_games, home_wins)
    (home_wins.count.to_f/home_games.count.to_f).round(2)
  end
  
  def percentage_visitor_wins(home_games, home_losses)
    (home_losses.count.to_f/home_games.count.to_f).round(2)
  end

  def percentage_ties(home_games, tie_games)
    (tie_games.count.to_f/home_games.count.to_f).round(2)
  end

end
