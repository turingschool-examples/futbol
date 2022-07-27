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
  
    def count_of_games_by_season
        counts = {}
        games.each do |game|
            season = game[:season]
            if counts[season].nil?
                 counts[season] = 0
            end
            counts[season] += 1
        end
        counts

        games.reduce({}) do |counts, game|
            season = game[:season]
            counts[season] = 0 if counts[season].nil?
            counts[season] += 1
            counts
        end
    end

end

