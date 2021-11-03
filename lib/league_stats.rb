require 'csv'
require 'simplecov'

SimpleCov.start

class LeagueStats
  attr_reader :league_data
  def initialize(league_data)
    #@league_data = CSV.read("./data/sample_game_teams.csv")
    @league_data = CSV.parse(File.read("./data/sample_game_teams.csv"), headers: true)
    @teams_games_goals_avg = {}
    @teams_games_goals_avg_away = {}
    build_teams_games_goals_avg_hash
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

  def build_teams_games_goals_avg_hash(home = true)
    if home == false
      team_away
    else
      team_home
    end
      @teams_games_goals_avg.each do |key, value|
        value[2] = (value[1].to_f / value[0].to_f).round(2)
      end
    end

  def team_home
    @league_data.each do |league|
        if league["HoA"] == "home"
          if @teams_games_goals_avg.keys.include? (league["team_id"])
          else
            @teams_games_goals_avg[league["team_id"]] = [0,0]
          end
          current_goals = league["goals"].to_i
          first = (@teams_games_goals_avg[league["team_id"]][0] += 1)
          second = (@teams_games_goals_avg[league["team_id"]][1] += current_goals)
          @teams_games_goals_avg[league["team_id"]] = [first, second]
        end
      end
    end

  def team_away
    @league_data.each do |league|
        if league["HoA"] == "away"
          if @teams_games_goals_avg_away.keys.include? (league["team_id"])
          else
            @teams_games_goals_avg_away[league["team_id"]] = [0,0]
          end
          current_goals = league["goals"].to_i
          first = (@teams_games_goals_avg_away[league["team_id"]][0] += 1)
          second = (@teams_games_goals_avg_away[league["team_id"]][1] += current_goals)
          @teams_games_goals_avg_away[league["team_id"]] = [first, second]
        end
      end
    end

  def best_offense
    best_offense_team_average = 0
    best_offense_team = nil
    @teams_games_goals_avg.each do |key, value|
      if value[2] > best_offense_team_average
        best_offense_team_average = value[2]
        best_offense_team = key
      end
    end
    best_offense_team
  end

  def worst_offense
    worst_offense_team_average = 100
    worst_offense_team = nil
    @teams_games_goals_avg.each do |key, value|
      if value[2] < worst_offense_team_average
        worst_offense_team_average = value[2]
        worst_offense_team = key
      end
    end
    worst_offense_team
  end

  def highest_scoring_visitor
    build_teams_games_goals_avg_hash(home = false)
    best_offense_team_average = 0
    best_offense_team = nil
    @teams_games_goals_avg_away.each do |key, value|
      value[2] = (value[1].to_f / value[0].to_f).round(2)
      if value[2] > best_offense_team_average
        best_offense_team_average = value[2]
        best_offense_team = key
      end
    end
    best_offense_team
  end

  def highest_scoring_home_team
    best_offense
  end

  def lowest_scoring_visitor
    build_teams_games_goals_avg_hash(home = false)
    worst_offense_away_team_average = 100 #any high number will do
    worst_offense_away_team = nil
    teams_games_goals_avg.each do |key, value|
      value[2] = (value[1].to_f / value[0].to_f).round(2)
      if value[2] < worst_offense_away_team_average
        worst_offense_away_team_average = value[2]
        worst_offense_away_team = key
      end
    end
    worst_offense_away_team
  end

  def lowest_scoring_home_team
    worst_offense
  end

end
