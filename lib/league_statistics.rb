class LeagueStatistics
  attr_reader :stat_tracker

  def initialize(stat_tracker)
    @stat_tracker = stat_tracker
  end

  def count_of_teams
    @stat_tracker[:teams]['team_id'].count
  end

  def game_teams_data_set
    @stat_tracker[:game_teams]['team_id'].zip(@stat_tracker[:game_teams]['goals'], @stat_tracker[:game_teams]['HoA'], @stat_tracker[:game_teams]['result'])
  end

  def team_data_set
    @stat_tracker[:teams]['team_id'].zip(@stat_tracker[:teams]['teamName'])
  end

  def game_data_set
    @stat_tracker[:games]['away_team_id'].zip(@stat_tracker[:games]['home_team_id'], @stat_tracker[:games]['away_goals'], @stat_tracker[:games]['home_goals'])
  end

  def find_highest_goal
    game_teams_data_set.max_by do |goal|
        goal[1]
      end
  end

  def find_highest_goal_team_id
    find_highest_goal[0]
  end

  def best_offense
    name = []
    team_data_set.each do |pair|
      if pair[0] == find_highest_goal_team_id
        name << pair[1]
      end
    end
    name[0]
  end

  def find_lowest_goal
    game_teams_data_set.min_by do |goal|
        goal[1]
      end
  end

  def find_lowest_goal_team_id
    find_lowest_goal[0]
  end

  def worst_offense
    name = []
    team_data_set.each do |pair|
      if pair[0] == find_lowest_goal_team_id
        name << pair[1]
      end
    end
    name[0]
  end

  def all_teams_away_and_won
    game_teams_data_set.select do |game|
      game[2] == "away" && game[3] == "WIN"
    end
  end

  def total_games_per_team_id_away
    num_goals_away = {}
    stat_tracker[:games]['away_team_id'].each do |num|
    num_goals_away[num] = stat_tracker[:games]['away_team_id'].count do |id|
      num == id
      end
    end
    num_goals_away
  end

  def total_games_per_team_id_home
    num_goals_home = {}
    stat_tracker[:games]['home_team_id'].each do |num|
    num_goals_home[num] = stat_tracker[:games]['home_team_id'].count do |id|
      num == id
      end
    end
    num_goals_home
  end

  def total_goals_per_team_id_away
    sum_goals_away = Hash.new(0)
     game_data_set.each do |set|
         if sum_goals_away[set[0]].nil?
           sum_goals_away[set[0]] = set[2].to_f
         else
           sum_goals_away[set[0]] += set[2].to_f
         end
       end
     sum_goals_away
  end

  def total_goals_per_team_id_home
    sum_goals_home = Hash.new(0)
     game_data_set.each do |set|
         if sum_goals_home[set[1]].nil?
           sum_goals_home[set[1]] = set[3].to_f
         else
           sum_goals_home[set[1]] += set[3].to_f
         end
       end
     sum_goals_home
  end

  def highest_scoring_visitor
    something = Hash.new {|hash_obj, key| hash_obj[key] = []}
    total_goals_per_team_id_away.each do |team_id, num_goals|
      total_games_per_team_id_away.each do |id, num_games|
        if team_id == id
          something[team_id] << (num_goals / num_games).round(2)
        end
      end
    end
    team_id1 = something.max_by do |team_id, avg|
      avg
    end[0]
    team_data_set.find do |pair|
      pair[0] == team_id1
    end[1]
  end

  def highest_scoring_home_team
    something = Hash.new {|hash_obj, key| hash_obj[key] = []}
    total_goals_per_team_id_home.each do |team_id, num_goals|
      total_games_per_team_id_home.each do |id, num_games|
        if team_id == id
          something[team_id] << (num_goals / num_games).round(2)
        end
      end
    end
    # require "pry"; binding.pry
    team_id1 = something.max_by do |team_id, avg|
      avg
    end[0]
    team_data_set.find do |pair|
      pair[0] == team_id1
    end[1]
  end

  def lowest_scoring_visitor
    something = Hash.new {|hash_obj, key| hash_obj[key] = []}
    total_goals_per_team_id_away.each do |team_id, num_goals|
      total_games_per_team_id_away.each do |id, num_games|
        if team_id == id
          something[team_id] << (num_goals / num_games).round(2)
        end
      end
    end
    team_id1 = something.min_by do |team_id, avg|
      avg
    end[0]
    team_data_set.find do |pair|
      pair[0] == team_id1
    end[1]
  end

  def lowest_scoring_home_team
    something = Hash.new {|hash_obj, key| hash_obj[key] = []}
    total_goals_per_team_id_home.each do |team_id, num_goals|
      total_games_per_team_id_home.each do |id, num_games|
        if team_id == id
          something[team_id] << (num_goals / num_games).round(2)
        end
      end
    end
    team_id1 = something.min_by do |team_id, avg|
      avg
    end[0]
    team_data_set.find do |pair|
      pair[0] == team_id1
    end[1]
  end
end
