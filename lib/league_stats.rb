require 'csv'

class LeagueStats
    attr_reader :game_teams_data, :team_data
    def initialize(game_teams_data, team_data)
        @game_teams_data = game_teams_data
        @team_data = team_data
    end

    #total num of teams in the data
    def count_of_teams
        @game_teams_data.map {|game| game.team_id}.uniq.count
    end

    #best offense. Team with highest average number of goals scored per game across all seasons.
    def best_offense
        team_goals = @game_teams_data.group_by {|game| game.team_id}
        offense = team_goals.transform_values do |games|
            goals = games.sum {|game| game.goals.to_f}
            goals / games.count
        end
        offense = offense.max_by {|k, v| v}
        team = @team_data.find {|team| team.team_id == offense[0]}.team_name
        team
    end
end