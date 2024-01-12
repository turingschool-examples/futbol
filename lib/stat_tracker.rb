require 'csv'

class StatTracker
    attr_reader :games,
                :teams,
                :game_teams

    def self.from_csv(locations)
        StatTracker.new(locations)
    end

    def initialize(locations)
        @games = games_csv_reader(locations[:games])
        @teams = teams_csv_reader(locations[:teams])
        @game_teams = game_teams_csv_reader(locations[:game_teams])
    end

    def games_csv_reader(file_path)
       games_array = []
       CSV.readlines(file_path, headers: true, header_converters: :symbol).map do |row|
            game_id = row[:game_id]
            season = row[:season]
            type = row[:type]
            date_time= row[:date_time]
            away_team_id = row[:away_team_id]
            home_team_id = row[:home_team_id]
            away_goals = row[:away_goals]
            home_goals = row[:home_goals]
            venue = row[:venue]
            games_array << Game.new(game_id, season, type, date_time, away_team_id, home_team_id, away_goals, home_goals, venue)
        end
        games_array
    end

    def teams_csv_reader(file_path)
        teams_array = []
        CSV.readlines(file_path, headers: true, header_converters: :symbol).map do |row|
            team_id = row[:team_id]
            franchise_id = row[:franchiseid]
            team_name = row[:teamname]
            abbreviation = row[:abbreviation]
            stadium = row[:stadium]
            teams_array << Team.new(team_id, franchise_id, team_name, abbreviation, stadium)
        end
        teams_array
    end

    def game_teams_csv_reader(file_path)
        game_teams_array = []
        CSV.readlines(file_path, headers: true, header_converters: :symbol).map do |row|
            game_id = row[:game_id]
            team_id = row[:team_id]
            home_or_away_game = row[:hoa]
            result = row[:res]
            settled_in = row[:settled_in]
            head_coach = row[:head_coach]
            goals = row[:goals]
            shots = row[:shots]
            tackles = row[:tackles]
            pentalty_infraction_min = row[:pim]
            power_play_opportunities = row[:powerplayopportunities]
            power_play_goals = row[:powerplaygoals]
            face_off_win_percentage = row[:faceoffwinpercentage]
            give_aways = row[:giveaways]
            take_aways = row[:takeaways]
            game_teams_array << GameTeam.new(game_id, team_id, home_or_away_game, result, settled_in, head_coach, goals, shots, tackles, pentalty_infraction_min, power_play_opportunities, power_play_goals, face_off_win_percentage, give_aways, take_aways)
        end
        game_teams_array
    end

    def percentage_home_wins

        total_home_wins = @games.count do |game|
            game.home_goals > game.away_goals
        end
        (total_home_wins.to_f / @games.size).round(2)

    end

    def percentage_visitor_wins

        total_home_wins = @games.count do |game|
            game.home_goals < game.away_goals
        end
        (total_home_wins.to_f / @games.size).round(2)
    end

    def percentage_ties
        total_ties = @games.count do |game|
          game.home_goals == game.away_goals
        end
        (total_ties.to_f / @games.size).round(2)

    end
end
