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

    def percentage_visitor_wins
         #sum of visitor wins / total games played
     
        away_wins = []
        game_results = game_teams.values_at(:hoa, :result)

        total_games_played = []
     
     
    #    game_results.find_all do |game|
    #     game == ["away", "WIN"]

       game_results.each do |game|
        away_wins << game if game == ["away", "WIN"]
           
        end
        require 'pry'; binding.pry 
    end

end
