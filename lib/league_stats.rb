require 'csv'
require 'simplecov'

SimpleCov.start

class LeagueStats
  attr_reader :league_data
  def initialize(league_data)
    #@league_data = CSV.read("./data/sample_game_teams.csv")
    @league_data = CSV.parse(File.read("./data/sample_game_teams.csv"), headers: true)
  end

  def count_of_teams
    team_ids = []
    @league_data.each do |league|
      if team_ids.include?(league["team_id"])
      else
        team_ids << league["team_id"]
      end
    end
    p team_ids.count
  end

  def best_offense
    teams_games_goals_avg = {}
    @league_data.each do |league|
        if league["HoA"] == "home"
          if teams_games_goals_avg.keys.include? (league["team_id"])
          else
            teams_games_goals_avg[league["team_id"]] = [0,0]
          end

          current_goals = league["goals"].to_i
          first = (teams_games_goals_avg[league["team_id"]][0] += 1)
          second = (teams_games_goals_avg[league["team_id"]][1] += current_goals)
          teams_games_goals_avg[league["team_id"]] = [first, second]
      end
    end
    best_offense_team_average = 0
    best_offense_team = nil
    teams_games_goals_avg.each do |key, value|
      value[2] = (value[1].to_f / value[0].to_f)
      if value[2] > best_offense_team_average
        best_offense_team_average = value[2]
        best_offense_team = key
      end
    end
    best_offense_team
  end

  def worst_offense
    teams_games_goals_avg = {}
    @league_data.each do |league|
        if league["HoA"] == "home"
          if teams_games_goals_avg.keys.include? (league["team_id"])
          else
            teams_games_goals_avg[league["team_id"]] = [0,0]
          end

          current_goals = league["goals"].to_i
          first = (teams_games_goals_avg[league["team_id"]][0] += 1)
          second = (teams_games_goals_avg[league["team_id"]][1] += current_goals)
          teams_games_goals_avg[league["team_id"]] = [first, second]
      end
    end
    worst_offense_team_average = 100
    worst_offense_team = nil
    teams_games_goals_avg.each do |key, value|
      value[2] = (value[1].to_f / value[0].to_f)
      if value[2] < worst_offense_team_average
        worst_offense_team_average = value[2]
        worst_offense_team = key
      end
    end
    worst_offense_team
  end

  def highest_scoring_visitor
    teams_games_goals_avg = {}
    @league_data.each do |league|
        if league["HoA"] == "away"
          if teams_games_goals_avg.keys.include? (league["team_id"])
          else
            teams_games_goals_avg[league["team_id"]] = [0,0]
          end

          current_goals = league["goals"].to_i
          first = (teams_games_goals_avg[league["team_id"]][0] += 1)
          second = (teams_games_goals_avg[league["team_id"]][1] += current_goals)
          teams_games_goals_avg[league["team_id"]] = [first, second]
      end
    end
    best_offense_team_average = 0
    best_offense_team = nil
    teams_games_goals_avg.each do |key, value|
      value[2] = (value[1].to_f / value[0].to_f)
      if value[2] > best_offense_team_average
        best_offense_team_average = value[2]
        best_offense_team = key
      end
    end
    best_offense_team
  end
end
