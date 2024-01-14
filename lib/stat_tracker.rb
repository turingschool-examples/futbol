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

    def highest_total_score
        @games.map {|game| game.total_score}.max
    end

    def lowest_total_score
        @games.map {|game| game.total_score}.min
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

    def average_goals_per_game
        @games.map! {|game| game.total_score}
        (@games.sum.to_f / @games.size.to_f).round(2)
    end

    def average_goals_per_season
        games_by_season = @games.group_by {|game| game.season}
        games_by_season.each_value do |games| 
            games.map! do |game|
                game.total_score
            end
        end
        games_by_season.each do |season, game_total_score| 
            games_by_season[season] = (game_total_score.sum.to_f / game_total_score.size.to_f).round(2)
        end
    end

    def count_of_teams
        @teams.map do |team|
            team.team_id
        end.uniq.count
    end

    def highest_scoring_visitor
        away_team = @game_teams.select { |game_team| game_team.home_or_away_game == "away" }
        highest_scoring = away_team.max_by { |game_team| game_team.goals.to_i }

        good_team = @teams.find { |team| team.team_id == highest_scoring.team_id }
        good_team.team_name
    end  

    def highest_scoring_home_team
        home_team = @game_teams.select { |game_team| game_team.home_or_away_game == "home" }
        highest_scoring = home_team.max_by { |game_team| game_team.goals.to_i }

        good_team = @teams.find { |team| team.team_id == highest_scoring.team_id }
        good_team.team_name
    end

    def lowest_scoring_visitor
        away_team = @game_teams.select { |game_team| game_team.home_or_away_game == "away" }
        lowest_scoring = away_team.min_by { |game_team| game_team.goals.to_i }

        bad_team = @teams.find { |team| team.team_id == lowest_scoring.team_id }
        bad_team.team_name
    end 

    def lowest_scoring_home_team
        home_team = @game_teams.select { |game_team| game_team.home_or_away_game == "home" }
        lowest_scoring = home_team.min_by { |game_team| game_team.goals.to_i }

        bad_team = @teams.find { |team| team.team_id == lowest_scoring.team_id }
        bad_team.team_name
    end

    def winningest_coach(season_id)
        # games_by_season = @games.group_by {|game| game.season}
        # season_game_ids = games_by_season[:season_id].map

        season_game_ids = @games.filter_map {|game| game.game_id if game.season == season_id}
    end

    def worst_coach(season_id)
        #code
    end
end