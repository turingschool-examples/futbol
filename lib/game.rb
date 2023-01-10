require_relative 'array_generator'

class Game
    attr_reader :game_id,
                :season,
                :type,
                :date_time,
                :away_team_id,
                :home_team_id,
                :away_goals,
                :home_goals,
                :venue,
                :venue_link

    def initialize(info)
        @game_id = info[:game_id]
        @season = info[:season]
        @type = info[:type]
        @date_time = info[:date_time]
        @away_team_id = info[:away_team_id]
        @home_team_id = info[:home_team_id]
        @away_goals = info[:away_goals].to_i
        @home_goals = info[:home_goals].to_i
        @venue = info[:venue]
        @venue_link = info[:venue_link]
    end

    def game_total_score
        # games.map { |game| game[:away_goals] + game[:home_goals] } 
        @away_goals + @home_goals
    end

    def home_wins
        total_home_wins = 0
        if @away_goals < @home_goals
            total_home_wins += 1
        end
    end

    def visitor_wins
        total_visitor_wins = 0
        if @away_goals > @home_goals
            total_visitor_wins += 1
        elsif @away_goals < @home_goals || @away_goals == @home_goals
            total_visitor_wins += 0
        end
    end

    def game_ties
        total_ties = 0
        if @away_goals == @home_goals
            total_ties += 1
        elsif @away_goals != @home_goals
            total_ties += 0
        end
    end

end
