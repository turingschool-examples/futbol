class LeagueStatistics
  attr_reader :stat_tracker

  def initialize(stat_tracker)
    @stat_tracker = stat_tracker
  end

    #Data_Sets
  def game_teams_data_set
    @stat_tracker[:game_teams]['team_id'].zip(@stat_tracker[:game_teams]['goals'], @stat_tracker[:game_teams]['HoA'], @stat_tracker[:game_teams]['result'])
  end

  def team_data_set
    @stat_tracker[:teams]['team_id'].zip(@stat_tracker[:teams]['teamName'])
  end

  def game_data_set
    @stat_tracker[:games]['away_team_id'].zip(@stat_tracker[:games]['home_team_id'], @stat_tracker[:games]['away_goals'], @stat_tracker[:games]['home_goals'])
  end

  #League_Statistics_Methods
  def count_of_teams
    @stat_tracker[:teams]['team_id'].count
  end

  def best_offense
    team_data_set.find do |team_id|
       team_id[0] == find_highest_goal_team_id
    end[1]
  end

  def worst_offense
    team_data_set.find do |team_id|
       team_id[0] == find_lowest_goal_team_id
     end[1]
  end

  def highest_scoring_visitor
    team_data_set.find do |team_id|
      team_id[0] == highest_average_team_id_visitor
    end[1]
  end

  def highest_scoring_home_team
    team_data_set.find do |team_id|
      team_id[0] == highest_average_team_id_home
    end[1]
  end

  def lowest_scoring_visitor
    team_data_set.find do |team_id|
      team_id[0] == lowest_average_team_id_visitor
    end[1]
  end

  def lowest_scoring_home_team
    team_data_set.find do |team_id|
      team_id[0] == lowest_average_team_id_home
    end[1]
  end

  #Helper_Methods
  def find_highest_goal_team_id
    game_teams_data_set.max_by {|goal| goal[1]}[0]
  end

  def find_lowest_goal
    game_teams_data_set.min_by do |goal|
        goal[1]
      end
  end

  def find_lowest_goal_team_id
    find_lowest_goal[0]
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

  def highest_average_team_id_visitor
    highest_visitor = Hash.new {|hash_obj, key| hash_obj[key] = []}
    total_goals_per_team_id_away.each do |team_id, num_goals|
      total_games_per_team_id_away.each do |id, num_games|
        if team_id == id
          highest_visitor[team_id] << (num_goals / num_games).round(2)
        end
      end
    end
     highest_visitor.max_by {|team_id, avg| avg}[0]
   end

   def highest_average_team_id_home
     highest_home = Hash.new {|hash_obj, key| hash_obj[key] = []}
     total_goals_per_team_id_home.each do |team_id, num_goals|
       total_games_per_team_id_home.each do |id, num_games|
         if team_id == id
           highest_home[team_id] << (num_goals / num_games).round(2)
         end
       end
     end
     highest_home.max_by {|team_id, avg| avg}[0]
   end

   def lowest_average_team_id_visitor
   lowest_visitor = Hash.new {|hash_obj, key| hash_obj[key] = []}
   total_goals_per_team_id_away.each do |team_id, num_goals|
     total_games_per_team_id_away.each do |id, num_games|
       if team_id == id
         lowest_visitor[team_id] << (num_goals / num_games).round(2)
       end
     end
   end
   lowest_visitor.min_by {|team_id, avg| avg}[0]
   end

   def lowest_average_team_id_home
   lowest_home = Hash.new {|hash_obj, key| hash_obj[key] = []}
   total_goals_per_team_id_home.each do |team_id, num_goals|
     total_games_per_team_id_home.each do |id, num_games|
       if team_id == id
         lowest_home[team_id] << (num_goals / num_games).round(2)
       end
     end
   end
   lowest_home.min_by {|team_id, avg| avg}[0]
   end
end
