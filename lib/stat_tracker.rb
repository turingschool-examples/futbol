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

    def total_score
      @games.values_at(:away_goals, :home_goals).map do |game|
        game[0] + game[1]
      end
    end

    def lowest_total_score 
        total_score.min
    end
  
    def highest_total_score
      total_score.max
    end

    def percentage_home_wins
      percentage = home_wins/home_games
      p percentage
    end

    def game_win
      wins = []
      @game_teams[:result].map {|row| wins << row   if row == "WIN"}; p wins.count.to_f
    end 
  
    def game_loss
      losses = []
      @game_teams[:result].map {|row| losses << row   if row == "LOSS"}; p losses.count.to_f
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


