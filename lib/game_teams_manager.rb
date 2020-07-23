require './lib/game_teams'



class GameTeamsManager
  attr_reader :game_teams_array

def initialize(game_teams_path)
  @game_teams_array = []
    CSV.foreach(game_teams_path, headers: true) do |row|
      @game_teams_array << GameTeam.new(row)
    end
end

def percentage_home_wins
    home_games = []
    @game_teams_array.each do |game|
      if game.hoa.to_s == 'home'
        home_games << game
      end
    end
    home_wins = []
    home_games.each do |game|
      home_wins << game if game.result.to_s == 'WIN'
    end
    (home_wins.count.to_f/home_games.count.to_f).round(2)
  end

  def percentage_visitor_wins
    home_games = []
    @game_teams_array.each do |game|
      if game.hoa.to_s == 'home'
        home_games << game
      end
    end
    home_losses = []
    home_games.each do |game|
      home_losses << game if game.result.to_s == 'LOSS'
    end
    (home_losses.count.to_f/home_games.count.to_f).round(2)
  end

end
