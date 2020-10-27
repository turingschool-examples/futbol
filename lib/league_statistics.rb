class LeagueStatistics
  attr_reader :stat_tracker

  def initialize(stat_tracker)
    @stat_tracker = stat_tracker
  end

  def count_of_teams
    @stat_tracker[:teams]['team_id'].count
  end

  def game_teams_data_set
      @stat_tracker[:game_teams]['team_id'].zip(@stat_tracker[:game_teams]['goals'])
  end

  def team_data_set
    @stat_tracker[:teams]['team_id'].zip(@stat_tracker[:teams]['teamName'])
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
end
