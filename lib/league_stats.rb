require_relative 'csv_reader'
require_relative 'team'


class LeagueStats < CSVReader

    def initialize(locations)
        super(locations)
    end

    def count_of_teams
        @teams.count
    end

    def best_offense
        team_hash = {}
        @game_teams.each do |game_team|
            if team_hash[game_team.team_id].nil?
                team_hash[game_team.team_id] = [game_team.goals]
            else
                team_hash[game_team.team_id] << game_team.goals
            end
        end
        sum_goals = 0
        team_hash.map do |team, goals|
            goals.each do |goal|
                sum_goals += goal
            end
        avg_goals = sum_goals.to_f / goals.length.to_f
        team_hash[team] = avg_goals
        sum_goals = 0
        end
        team_hash = team_hash.sort_by {|team_id, avg_goals| avg_goals}.reverse.to_h

        highest_avg = team_hash.values[0]
        team_hash.map do |team, avg_goals|
            team_hash.delete(team) if avg_goals < highest_avg
        end

        if team_hash.length > 1
        team_names = []
        team_hash.keys.each do |team_id|
            team_names << team_name_helper(team_id)
        end
            return team_names
        else
            return team_name_helper(team_hash.keys[0])
        end
    end

    def worst_offense
    team_hash = {}
    @game_teams.each do |game_team|
        if team_hash[game_team.team_id].nil?
            team_hash[game_team.team_id] = [game_team.goals]
        else
            team_hash[game_team.team_id] << game_team.goals
        end
    end
    sum_goals = 0
        team_hash.map do |team, goals|
        goals.each do |goal|
            sum_goals += goal
        end
        avg_goals = sum_goals.to_f / goals.length.to_f
        team_hash[team] = avg_goals
        sum_goals = 0
        end
        team_hash = team_hash.sort_by {|team_id, avg_goals| avg_goals}.to_h

        lowest_avg = team_hash.values[0]
        team_hash.map do |team, avg_goals|
            team_hash.delete(team) if avg_goals > lowest_avg
        end

        if team_hash.length > 1
        team_names = []
        team_hash.keys.each do |team_id|
            team_names << team_name_helper(team_id)
        end
            return team_names
        else
            return team_name_helper(team_hash.keys[0])
        end
    end

    def lowest_scoring_visitor
    team_hash = {}
    @games.each do |game|
        if team_hash[game.away_team_id].nil?
            team_hash[game.away_team_id] = [game.away_goals]
        else
            team_hash[game.away_team_id] << game.away_goals
        end
    end
    sum_goals = 0
        team_hash.map do |team, goals|
            goals.each do |goal|
            sum_goals += goal
            end
        avg_goals = sum_goals.to_f / goals.length.to_f
        team_hash[team] = avg_goals
        sum_goals = 0
        end
        team_hash = team_hash.sort_by {|away_team_id, avg_goals| avg_goals}.to_h

        lowest_avg = team_hash.values[0]
        team_hash.map do |team, avg_goals|
        team_hash.delete(team) if avg_goals > lowest_avg
        end

        if team_hash.length > 1
        team_names = []
        team_hash.keys.each do |away_team_id|
            team_names << team_name_helper(away_team_id)
        end
        return team_names
        else
        return team_name_helper(team_hash.keys[0])
        end
    end

    def highest_scoring_visitor
    team_hash = {}
    @games.each do |game|
        if team_hash[game.away_team_id].nil?
        team_hash[game.away_team_id] = [game.away_goals]
        else
        team_hash[game.away_team_id] << game.away_goals
        end
    end
    sum_goals = 0
        team_hash.map do |team, goals|
        goals.each do |goal|
            sum_goals += goal
        end
        avg_goals = sum_goals.to_f / goals.length.to_f
        team_hash[team] = avg_goals
        sum_goals = 0
        end
        team_hash = team_hash.sort_by {|away_team_id, avg_goals| avg_goals}.reverse.to_h

        highest_avg = team_hash.values[0]
        team_hash.map do |team, avg_goals|
        team_hash.delete(team) if avg_goals < highest_avg
        end

        if team_hash.length > 1
        team_names = []
        team_hash.keys.each do |away_team_id|
            team_names << team_name_helper(away_team_id)
        end
        return team_names
        else
        return team_name_helper(team_hash.keys[0])
        end
    end

    def highest_scoring_home_team
    team_hash = {}
    @games.each do |game|
        if team_hash[game.home_team_id].nil?
        team_hash[game.home_team_id] = [game.home_goals]
        else
        team_hash[game.home_team_id] << game.home_goals
        end
    end
    sum_goals = 0
        team_hash.map do |team, goals|
        goals.each do |goal|
            sum_goals += goal
        end
        avg_goals = sum_goals.to_f / goals.length.to_f
        team_hash[team] = avg_goals
        sum_goals = 0
        end
        team_hash = team_hash.sort_by {|away_team_id, avg_goals| avg_goals}.reverse.to_h

        highest_avg = team_hash.values[0]
        team_hash.map do |team, avg_goals|
        team_hash.delete(team) if avg_goals < highest_avg
        end

        if team_hash.length > 1
        team_names = []
        team_hash.keys.each do |away_team_id|
            team_names << team_name_helper(away_team_id)
        end
        return team_names
        else
        return team_name_helper(team_hash.keys[0])
        end
    end

    def lowest_scoring_home_team
        team_hash = {}
        @games.each do |game|
            if team_hash[game.home_team_id].nil?
            team_hash[game.home_team_id] = [game.home_goals]
            else
            team_hash[game.home_team_id] << game.home_goals
            end
        end
        sum_goals = 0
            team_hash.map do |team, goals|
                goals.each do |goal|
                    sum_goals += goal
            end
            avg_goals = sum_goals.to_f / goals.length.to_f
            team_hash[team] = avg_goals
            sum_goals = 0
            end
            team_hash = team_hash.sort_by {|away_team_id, avg_goals| avg_goals}.to_h

            lowest_avg = team_hash.values[0]
            team_hash.map do |team, avg_goals|
            team_hash.delete(team) if avg_goals > lowest_avg
            end

            if team_hash.length > 1
                team_names = []
                team_hash.keys.each do |away_team_id|
                    team_names << team_name_helper(away_team_id)
                end
                return team_names
            else
                return team_name_helper(team_hash.keys[0])
            end
    end

    def team_name_helper(team_id)
        @teams.each do |team|
            if team.team_id == team_id
                return team.team_name
            end
        end
    end
end
