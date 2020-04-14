require 'csv'
require_relative 'collection'
require_relative 'team_collection'
require_relative 'game_stats'

class GameStatsCollection < Collection
  attr_reader :game_stats

  def initialize(file_path)
    @game_stats = create_objects(file_path, GameStats)
  end

  def goals_by_team_id(games)
    goals_by_id = {}
    @game_stats.each do |row|
      if games == "all" && goals_by_id[row.team_id].nil?
        goals_by_id[row.team_id] = [row.goals]
      elsif games != "all" && goals_by_id[row.team_id].nil? && row.home_away == games
        goals_by_id[row.team_id] = [row.goals]
      elsif games == "all"
        goals_by_id[row.team_id] << row.goals
      elsif games != "all" && row.home_away == games
        goals_by_id[row.team_id] << row.goals
      end
    end
    goals_by_id
  end

  def average_goals_by_team_id(games)
    total_goals = {}
    goals_by_team_id(games).each { |id, goals| total_goals[id] = goals.sum}
    average_goals = {}
    total_goals.each do |id, goals|
      average_goals[id] = (total_goals[id].to_f / goals_by_team_id(games)[id].length).round(2)
    end
    average_goals
  end

  def find_team_id(games, type)
    if type == "max"
      (average_goals_by_team_id(games).max_by {|team_id, average_goals| average_goals})[0]
    elsif type == "min"
      (average_goals_by_team_id(games).min_by {|team_id, average_goals| average_goals})[0]
    end
  end

  def find_team_name_by_team_id(team_id)
    team_collection = TeamCollection.new('./data/teams.csv')
    (team_collection.teams.find { |team| team.team_id == team_id}).teamname
  end

  def best_offense
    find_team_name_by_team_id(find_team_id("all", "max"))
  end

  def worst_offense
    find_team_name_by_team_id(find_team_id("all", "min"))
  end

  def highest_scoring_visitor
    find_team_name_by_team_id(find_team_id("away", "max"))
  end

  def lowest_scoring_visitor
    find_team_name_by_team_id(find_team_id("away", "min"))
  end

  def highest_scoring_home_team
    find_team_name_by_team_id(find_team_id("home", "max"))
  end

  def lowest_scoring_home_team
    find_team_name_by_team_id(find_team_id("home", "min"))
  end

  def all_games_for(id)
    number_id = id.to_i
    @game_stats.find_all {|game_stat| game_stat.team_id == number_id}
  end

  def most_goals_scored(team_id)
    all_games_for(team_id).max_by {|game_stat| game_stat.goals}.goals
  end

  def fewest_goals_scored(team_id)
    all_games_for(team_id).min_by {|game_stat| game_stat.goals}.goals
  end

  def average_win_percentage(team_id)
    total_games = all_games_for(team_id)
    games_won = total_games.find_all {|game|game.result == "WIN"}
    average_percentage = (games_won.length.to_f/total_games.length)
    average_percentage.round(2)
  end
end
