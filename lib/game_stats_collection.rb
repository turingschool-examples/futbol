require 'csv'
require_relative 'team_collection'

class GameStatsCollection
  attr_reader :game_stats

  def initialize(file_path)
    @game_stats = create_game_stats(file_path)
  end

  def create_game_stats(file_path)
    game_stats_csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)
    game_stats_csv.map { |row| GameStats.new(row)}
  end

  def goals_by_team_id
    team_id_goals = {}
    @game_stats.each do |row|
      if team_id_goals[row.team_id] == nil
        team_id_goals[row.team_id] = [row.goals]
      else
        team_id_goals[row.team_id] << row.goals
      end
    end
    team_id_goals
  end

  def away_goals_by_team_id
    away_goals = {}
    @game_stats.each do |row|
      if away_goals[row.team_id] == nil && row.home_away == "away"
        away_goals[row.team_id] = [row.goals]
      elsif row.home_away == "away"
        away_goals[row.team_id] << row.goals
      end
    end
    away_goals
  end

  def home_goals_by_team_id
    home_goals = {}
    @game_stats.each do |row|
      if home_goals[row.team_id] == nil && row.home_away == "home"
        home_goals[row.team_id] = [row.goals]
      elsif row.home_away == "home"
        home_goals[row.team_id] << row.goals
      end
    end
    home_goals
  end

  def average_goals_by_team_id
    total_goals = {}
    goals_by_team_id.each { |id, goals| total_goals[id] = goals.sum}
    average_goals = {}
    total_goals.each do |id, goals|
      average_goals[id] = (total_goals[id].to_f / goals_by_team_id[id].length).round(2)
    end
    average_goals
  end

  def average_away_goals_by_team_id
    total_away_goals = {}
    away_goals_by_team_id.each { |id, goals| total_away_goals[id] = goals.sum}
    average_away_goals = {}
    total_away_goals.each do |id, goals|
      average_away_goals[id] = (total_away_goals[id].to_f / away_goals_by_team_id[id].length).round(2)
    end
    average_away_goals
  end

  def average_home_goals_by_team_id
    total_home_goals = {}
    home_goals_by_team_id.each { |id, goals| total_home_goals[id] = goals.sum}
    average_home_goals = {}
    total_home_goals.each do |id, goals|
      average_home_goals[id] = (total_home_goals[id].to_f / home_goals_by_team_id[id].length).round(2)
    end
    average_home_goals
  end

  def best_offense_id
    (average_goals_by_team_id.max_by {|team_id, average_goals| average_goals})[0]
  end

  def worst_offense_id
    (average_goals_by_team_id.min_by {|team_id, average_goals| average_goals})[0]
  end

  def highest_scoring_visitor_id
    (average_away_goals_by_team_id.max_by {|team_id, average_goals| average_goals})[0]
  end

  def lowest_scoring_visitor_id
    (average_away_goals_by_team_id.min_by {|team_id, average_goals| average_goals})[0]
  end

  def highest_scoring_home_team_id
    (average_home_goals_by_team_id.max_by {|team_id, average_goals| average_goals})[0]
  end

  def lowest_scoring_home_team_id
    (average_home_goals_by_team_id.min_by {|team_id, average_goals| average_goals})[0]
  end

  def find_team_name_by_team_id(team_id)
    team_collection = TeamCollection.new('./data/teams.csv')
    (team_collection.teams.find { |team| team.team_id == team_id}).teamname
  end

  def best_offense
    find_team_name_by_team_id(best_offense_id)
  end

  def worst_offense
    find_team_name_by_team_id(worst_offense_id)
  end

  def highest_scoring_visitor
    find_team_name_by_team_id(highest_scoring_visitor_id)
  end

  def lowest_scoring_visitor
    find_team_name_by_team_id(lowest_scoring_visitor_id)
  end

  def highest_scoring_home_team
    find_team_name_by_team_id(highest_scoring_home_team_id)
  end
end
