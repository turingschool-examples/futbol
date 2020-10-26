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
    sum_goals_away = {}
    stat_tracker[:games]['away_team_id'].each do |id|
      sum_goals_away[id] = stat_tracker[:games]['away_goals'].sum do |goals|
        require "pry"; binding.pry
        if total_games_per_team_id_away[id] == id.to_i
          goals.to_i
        end
      end
    end
    require "pry"; binding.pry
    sum_goals_away
  end

  def highest_scoring_visitor
      wins = Hash.new([])
require "pry"; binding.pry
  end

end
