require_relative 'csv_reader'
require_relative 'team'


class LeagueStats < CSVReader

    def initialize(locations)
        super(locations)
    end

    def count_of_teams
        @teams.count
    end

    def hashburger_helper(type)
      if type == 'home'
        team_hash = @games.group_by {|game| game.home_team_id}.
        transform_values {|games| games.map{ |game| game.home_goals}.sum }
        length_hash = @games.group_by {|game| game.home_team_id}.
        transform_values {|games| games.length }
      elsif type == 'away'
        team_hash = @games.group_by {|game| game.away_team_id}.
        transform_values {|games| games.map{ |game| game.away_goals}.sum }
        length_hash = @games.group_by {|game| game.away_team_id}.
        transform_values {|games| games.length }
      else
        team_hash = @game_teams.group_by {|game| game.team_id}.
        transform_values {|games| games.map{ |game| game.goals}.sum }
        length_hash = @game_teams.group_by {|game| game.team_id}.
        transform_values {|games| games.length }
      end
      [team_hash, length_hash]
    end

    def high_league_avg_helper(team_hash, length_hash)
      return_hash = {}
      team_hash.map { |team_id, game|  return_hash[team_id] =
        (team_hash[team_id] / length_hash[team_id].to_f).round(2)}
      return_hash = return_hash.sort_by {
        |team_id, avg_goals| avg_goals}.reverse.to_h
        highest_avg = return_hash.values[0]
        return_hash.map do |team, avg_goals|
            return_hash.delete(team) if avg_goals < highest_avg
        end
        return_hash
    end

    def low_league_avg_helper(team_hash, length_hash)
      return_hash = {}
      team_hash.map { |team_id, game|  return_hash[team_id] =
        (team_hash[team_id] / length_hash[team_id].to_f).round(2)}
      return_hash = return_hash.sort_by {
        |team_id, avg_goals| avg_goals}.to_h
        lowest_avg = return_hash.values[0]
        return_hash.map do |team, avg_goals|
            return_hash.delete(team) if avg_goals > lowest_avg
        end
        return_hash
    end

    def best_offense
        team_hash = hashburger_helper('')[0]
        length_hash = hashburger_helper('')[1]
        return_hash = high_league_avg_helper(team_hash, length_hash)
        tie_bundler_helper(return_hash)
    end

    def worst_offense
      team_hash = hashburger_helper('')[0]
      length_hash = hashburger_helper('')[1]
      return_hash = low_league_avg_helper(team_hash, length_hash)
      tie_bundler_helper(return_hash)
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

        tie_bundler_helper(team_hash)
    end

    def highest_scoring_visitor
      team_hash = hashburger_helper('away')[0]
      length_hash = hashburger_helper('away')[1]
      return_hash = high_league_avg_helper(team_hash, length_hash)
      tie_bundler_helper(return_hash)
    end

    def highest_scoring_home_team
      team_hash = hashburger_helper('home')[0]
      length_hash = hashburger_helper('home')[1]
      return_hash = high_league_avg_helper(team_hash, length_hash)
      tie_bundler_helper(return_hash)
    end

    def lowest_scoring_home_team
      team_hash = hashburger_helper('home')[0]
      length_hash = hashburger_helper('home')[1]
      return_hash = low_league_avg_helper(team_hash, length_hash)
      tie_bundler_helper(return_hash)
    end

    def tie_bundler_helper(return_hash)
      if return_hash.length > 1
      team_names = []
      return_hash.keys.each do |team_id|
          team_names << team_name_helper(team_id)
      end
          return team_names.pop
      else
          return team_name_helper(return_hash.keys[0])
      end
      return team_name_helper(return_hash.keys[0])
    end

    def team_name_helper(team_id)
        @teams.each do |team|
            if team.team_id == team_id
                return team.team_name
            end
        end
    end
end
