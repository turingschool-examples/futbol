require 'csv'
require 'pry'

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
            result = row[:result]
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

    def count_of_games_by_season
        season_counts = Hash.new(0)
        @games.each do |game|
            season = game.season
            season_counts[season] += 1

        end
        season_counts
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
        season_game_ids = @games.filter_map {|game| game.game_id if game.season == season_id}
        total_season_games = season_game_ids.size

        season_game_teams =  @game_teams.select {|game_team| season_game_ids.include?(game_team.game_id)}
        head_coaches_season_stats = season_game_teams.group_by {|game_team| game_team.head_coach}
        head_coach_games_won = head_coaches_season_stats.transform_values {|game_teams| game_teams.count{|game_team| game_team.result == "WIN"}}
        head_coach_win_percentages = head_coach_games_won.transform_values {|games_won| (games_won.to_f / total_season_games.to_f * 100).round(2)}

        head_coach_win_percentages.max_by {|coach, win_percent| win_percent}.first
    end

    def worst_coach(season_id)
        season_game_ids = @games.filter_map {|game| game.game_id if game.season == season_id}
        total_season_games = season_game_ids.size

        season_game_teams =  @game_teams.select {|game_team| season_game_ids.include?(game_team.game_id)}
        head_coaches_season_stats = season_game_teams.group_by {|game_team| game_team.head_coach}
        head_coach_games_won = head_coaches_season_stats.transform_values {|game_teams| game_teams.count{|game_team| game_team.result == "WIN"}}
        head_coach_win_percentages = head_coach_games_won.transform_values {|games_won| (games_won.to_f / total_season_games.to_f * 100).round(2)}

        head_coach_win_percentages.min_by {|coach, win_percent| win_percent}.first
    end

    def name_team_list
        @teams.each_with_object(Hash.new) {|team, team_list| team_list[team.team_id] = team.team_name}
    end

    def most_accurate_team(season_id)
        all_season_game_id = @games.map do |game|
            game.game_id if game.season == season_id
        end.compact
        team_id_goals_shots = @game_teams.each_with_object(Hash.new([0,0])) do |game, hash|
            if all_season_game_id.include?(game.game_id)
              hash[game.team_id] = [game.goals + hash[game.team_id][0], game.shots + hash[game.team_id][1]]
            end
        end
        avg_goals_made = team_id_goals_shots.transform_values do |value|
            (value[0] / value[1].to_f).round(3)
        end
        team_name = avg_goals_made.key(avg_goals_made.values.max)
        name_team_list[team_name]
    end

    def least_accurate_team(season_id)
        all_season_game_id = @games.map do |game|
            game.game_id if game.season == season_id
        end.compact
        team_id_goals_shots = @game_teams.each_with_object(Hash.new([0,0])) do |game, hash|
            if all_season_game_id.include?(game.game_id)
              hash[game.team_id] = [game.goals + hash[game.team_id][0], game.shots + hash[game.team_id][1]]
            end
        end
        avg_goals_made = team_id_goals_shots.transform_values do |value|
            (value[0] / value[1].to_f).round(3)
        end
        team_name = avg_goals_made.key(avg_goals_made.values.min)
        name_team_list[team_name]
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


    def best_offense
        # Get sorted goals
        teams = sort_goal_stats

        best_offense_id = get_id_with_average(teams, :average, true)

        best_team = @teams.find { |team| team.team_id == best_offense_id }
        best_team.team_name
    end

    def worst_offense
        # Get sorted goals
        teams = sort_goal_stats

        worst_offense_id = get_id_with_average(teams, :average, false)

        worst_team = @teams.find { |team| team.team_id == worst_offense_id }
        worst_team.team_name
    end

    # Gets id of team with min/max average from array sorted by sort_goal_stats
    def get_id_with_average(array, key, max)
        team = max ? array.max_by { |item| item[key] } : array.min_by { |item| item[key] }
        team[:id]
    end

    def sort_goal_stats
        teams = []

        # Sort the data => {:id=>"3", :goals=>8, :number_of_games=>5, :average=>1.6}

        @game_teams.each do |game_team|
            team_id = game_team.team_id
            goals = game_team.goals.to_i

            if (team_id == nil)
                next
            end

            # Find team with same ID if exists otherwise default object shape
            current_team = teams.find { |team| team[:id] == team_id } || { id: team_id, goals: 0, number_of_games: 0 }

            current_team[:goals] += goals
            current_team[:number_of_games] += 1

            # Find index of current_team in teams
            current_team_index = teams.index { |team| team[:id] == team_id }

            # Update existing team or append new team
            current_team_index ? teams[current_team_index] = current_team : teams << current_team

        end
        # binding.pry

        # Get the averages of each team
        teams = teams.map do |team|
            team[:average] = team[:goals].to_f / team[:number_of_games].to_f
            team
        end

        # Return data
        teams
    end

end
