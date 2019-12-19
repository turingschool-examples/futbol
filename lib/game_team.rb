require 'csv'
require './lib/team'

class GameTeam
  @@all_game_teams

  def self.all_game_teams
    @@all_game_teams
  end

  def self.from_csv(file_path)
    csv = CSV.read("#{file_path}", headers: true, header_converters: :symbol)
    @@all_game_teams = csv.map do |row|
                    GameTeam.new(row)
                  end
  end

  attr_reader :game_id, :team_id, :hoa, :result, :settled_in, :head_coach, :goals, :shots, :tackles

  def initialize(game_team_info)
    @game_id = game_team_info[:game_id]
    @team_id = game_team_info[:team_id]
    @hoa = game_team_info[:hoa]
    @result = game_team_info[:result]
    @settled_in = game_team_info[:settled_in]
    @head_coach = game_team_info[:head_coach]
    @goals = game_team_info[:goals]
    @shots = game_team_info[:shots]
    @tackles = game_team_info[:tackles]
  end

  def self.percent_home_wins
    count_game = 0
    count_win = 0
    @@all_game_teams.each do |game_team|
      if game_team.result == "WIN" && game_team.hoa == "home"
        count_game += 1
        count_win += 1
      elsif game_team.result == "LOSS" && game_team.hoa == "home"
        count_game += 1
      end
    end
    (count_win/count_game.to_f).round(2)
  end

  def self.percent_visitor_wins
    count_game = 0
    count_win = 0
    @@all_game_teams.each do |game_team|
      if game_team.result == "WIN" && game_team.hoa == "away"
        count_game += 1
        count_win += 1
      elsif game_team.result == "LOSS" && game_team.hoa == "away"
        count_game += 1
      end
    end
    (count_win/count_game.to_f).round(2)
  end

  def self.percent_ties
    total_games = @@all_game_teams.map {|game_team| game_team.game_id}.uniq.length
    count_tie = 0
    @@all_game_teams.each {|game_team| count_tie += 1 if game_team.result == "TIE" && game_team.hoa == "home"}
    (count_tie/total_games.to_f).round(2)
  end

  def self.highest_scoring_visitor
    goals_team = {}
    games_team = {}
    goal_count = 0
    game_count = 0
    visitors = @@all_game_teams.find_all {|game_team| game_team.hoa == "away"}
    visitors_sorted = visitors.sort_by(&:team_id)

    visitors_sorted.each do |visitor|
      if goals_team.keys.include?(visitor.team_id) == false
        goals = 0
        goals_team[visitor.team_id] = (goals += visitor.goals.to_i)
        game_count = 0
        games_team[visitor.team_id] = (game_count += 1)
      else
        goals_team[visitor.team_id] = (goals_team[visitor.team_id] += visitor.goals.to_i)
        games_team[visitor.team_id] = (game_count += 1)
      end
    end

    avg_goal_team = {}
    games_team.keys.each do |key|
      avg_goal_per_game = goals_team[key]/games_team[key]
      avg_goal_team[key] = avg_goal_per_game
    end
    max_team = avg_goal_team.max_by do |goal|
      goal[-1]
    end
    max_team.first
    team_name = ""
    Team.all_teams.each do |team_param|
      team_name = team_param.team_name if max_team.first == team_param.team_id
    end
    team_name
    #make module for finding team name from team id using hash
  end

  def self.lowest_scoring_visitor
    goals_team = {}
    games_team = {}
    goal_count = 0
    game_count = 0
    visitors = @@all_game_teams.find_all {|game_team| game_team.hoa == "away"}
    visitors_sorted = visitors.sort_by(&:team_id)

    visitors_sorted.each do |visitor|
      if goals_team.keys.include?(visitor.team_id) == false
        goals = 0
        goals_team[visitor.team_id] = (goals += visitor.goals.to_i)
        game_count = 0
        games_team[visitor.team_id] = (game_count += 1)
      else
        goals_team[visitor.team_id] = (goals_team[visitor.team_id] += visitor.goals.to_i)
        games_team[visitor.team_id] = (game_count += 1)
      end
    end

    avg_goal_team = {}
    games_team.keys.each do |key|
      avg_goal_per_game = goals_team[key]/games_team[key]
      avg_goal_team[key] = avg_goal_per_game
    end
    min_team = avg_goal_team.min_by do |goal|
      goal[-1]
    end
    min_team.first
    team_name = ""
    Team.all_teams.each do |team_param|
      team_name = team_param.team_name if min_team.first == team_param.team_id
    end
    team_name
    #make module for finding team name from team id using hash
  end

  def self.lowest_scoring_home
    goals_team = {}
    games_team = {}
    goal_count = 0
    game_count = 0
    homes = @@all_game_teams.find_all {|game_team| game_team.hoa == "home"}
    homes_sorted = homes.sort_by(&:team_id)

    homes_sorted.each do |home|
      if goals_team.keys.include?(home.team_id) == false
        goals = 0
        goals_team[home.team_id] = (goals += home.goals.to_i)
        game_count = 0
        games_team[home.team_id] = (game_count += 1)
      else
        goals_team[home.team_id] = (goals_team[home.team_id] += home.goals.to_i)
        games_team[home.team_id] = (game_count += 1)
      end
    end

    avg_goal_team = {}
    games_team.keys.each do |key|
      avg_goal_per_game = goals_team[key]/games_team[key]
      avg_goal_team[key] = avg_goal_per_game
    end
    min_team = avg_goal_team.min_by do |goal|
      goal[-1]
    end
    min_team.first
    team_name = ""
    Team.all_teams.each do |team_param|
      team_name = team_param.team_name if min_team.first == team_param.team_id
    end
    team_name
    #make module for finding team name from team id using hash
  end

  def self.highest_scoring_home
    goals_team = {}
    games_team = {}
    goal_count = 0
    game_count = 0
    homes = @@all_game_teams.find_all {|game_team| game_team.hoa == "home"}
    homes_sorted = homes.sort_by(&:team_id)

    homes_sorted.each do |home|
      if goals_team.keys.include?(home.team_id) == false
        goals = 0
        goals_team[home.team_id] = (goals += home.goals.to_i)
        game_count = 0
        games_team[home.team_id] = (game_count += 1)
      else
        goals_team[home.team_id] = (goals_team[home.team_id] += home.goals.to_i)
        games_team[home.team_id] = (game_count += 1)
      end
    end

    avg_goal_team = {}
    games_team.keys.each do |key|
      avg_goal_per_game = goals_team[key]/games_team[key]
      avg_goal_team[key] = avg_goal_per_game
    end
    max_team = avg_goal_team.max_by do |goal|
      goal[-1]
    end
    max_team.first
    team_name = ""
    Team.all_teams.each do |team_param|
      team_name = team_param.team_name if max_team.first == team_param.team_id
    end
    team_name
    #make module for finding team name from team id using hash
  end
end
