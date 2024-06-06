
class GameStats
    attr_reader :games
    def initialize(games)
        @games = games
    end

    def highest_total_score
        max_score = 0
        @games.each do |game|
          away_goals = game[:away_goals].to_i
          home_goals = game[:home_goals].to_i
          total_score = away_goals + home_goals
          max_score = total_score if total_score > max_score
        end
        max_score
      end
end