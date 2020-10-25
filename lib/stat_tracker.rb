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
            season = row[:season]
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

    def calculate_winner(game)
      if game.home_goals > game.away_goals
        :home
      elsif game.home_goals < game.away_goals
        :away
      else
        :tie
      end
    end

    def percentage_home_wins
      home_wins = @games.count do |game|
        calculate_winner(game) == :home
      end
      (home_wins.to_f / @games.count).round(2)
    end

    def percentage_visitor_wins
      visitor_wins = @games.count do |game|
        calculate_winner(game) == :away
      end
      (visitor_wins.to_f / @games.count).round(2)
    end

    def percentage_ties
      ties = @games.count do |game|
        calculate_winner(game) == :tie
      end
      (ties.to_f / @games.count).round(2)
    end

    def games_by_season
      @games.group_by do |game|
        game.season
      end
    end

    def count_of_games_by_season
      count = {}
      games_by_season.map do |season, games|
        count[season] = games.count
      end
      count
    end
end
