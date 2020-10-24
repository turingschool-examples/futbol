require 'CSV'

class StatTracker

    def initialize(locations)
        @games_path = locations[:games]
        @teams_path = locations[:teams]
        @game_teams_path = locations[:game_teams]
        @games = make_games
    end

    def self.from_csv(locations)
        StatTracker.new(locations)
    end

    def make_games
        games = []
        CSV.foreach(@games_path, headers: true, header_converters: :symbol) do |row|
            game_id = row[:game_id].to_i
            season = row[:season].to_i
            type = row[:type]
            date_time = row[:date_time]
            away_team_id = row[:away_team_id].to_i
            home_team_id = row[:home_team_id].to_i
            away_goals = row[:away_goals].to_i
            home_goals = row[:home_goals].to_i
            venue = row[:venue]
            venue_link = row[:venue_link]

            games << Game.new(game_id, season, type, date_time, away_team_id, home_team_id, away_goals, home_goals, venue, venue_link)
        end
        games
    end

    def highest_total_score
        max_score_game = @games.max_by do |game|
            game.away_goals + game.home_goals
        end
        max_score_game.home_goals + max_score_game.away_goals
    end

    def lowest_total_score
        min_score_game = @games.min_by do |game|
            game.away_goals + game.home_goals
        end
        min_score_game.home_goals + min_score_game.away_goals
    end
end