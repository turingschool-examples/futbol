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
      def lowest_total_score
        low_score = @games.min_by{|game| game.away_goals + game.home_goals}
        low_score.away_goals + low_scores.home_goals 
    end

end

