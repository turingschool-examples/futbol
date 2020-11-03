require_relative './game_team'
require_relative './game_team_collection'
require_relative "./divisable"

class GameTeamLeague < GameTeamCollection
  include Divisable
  def best_offense
    @stat_tracker.find_team_name(find_highest_goal_team_id)
  end

  def worst_offense
    @stat_tracker.find_team_name(find_lowest_goal_team_id)
  end

  def highest_scoring_visitor
    @stat_tracker.find_team_name(highest_average_team_id_visitor)
  end

  def highest_scoring_home_team
    @stat_tracker.find_team_name(highest_average_team_id_home)
  end

  def lowest_scoring_visitor
    @stat_tracker.find_team_name(lowest_average_team_id_visitor)
  end

  def lowest_scoring_home_team
    @stat_tracker.find_team_name(lowest_average_team_id_home)
  end

  def find_highest_goal_team_id
    @game_teams.max_by {|goal| goal.goals}.team_id
  end

  def find_lowest_goal_team_id
    @game_teams.min_by {|goal| goal.goals}.team_id
  end

  def highest_average_team_id_visitor
    highest_visitor = Hash.new {|hash_obj, key| hash_obj[key] = []}
    @stat_tracker.total_goals_per_team_id_away.each do |team_id, num_goals|
      @stat_tracker.total_games_per_team_id_away.each do |id, num_games|
        highest_visitor[team_id] << average(num_goals, num_games) if team_id == id
      end
    end
     highest_visitor.max_by {|team_id, avg| avg}[0]
   end

   def highest_average_team_id_home
     highest_home = Hash.new {|hash_obj, key| hash_obj[key] = []}
     @stat_tracker.total_goals_per_team_id_home.each do |team_id, num_goals|
       @stat_tracker.total_games_per_team_id_home.each do |id, num_games|
         highest_home[team_id] << average(num_goals, num_games) if team_id == id
       end
     end
     highest_home.max_by {|team_id, avg| avg}[0]
   end

  def lowest_average_team_id_visitor
    lowest_visitor = Hash.new {|hash_obj, key| hash_obj[key] = []}
    @stat_tracker.total_goals_per_team_id_away.each do |team_id, num_goals|
      @stat_tracker.total_games_per_team_id_away.each do |id, num_games|
        lowest_visitor[team_id] << average(num_goals, num_games) if team_id == id
        end
    end
     lowest_visitor.min_by {|team_id, avg| avg}[0]
   end

   def lowest_average_team_id_home
    lowest_home = Hash.new {|hash_obj, key| hash_obj[key] = []}
    @stat_tracker.total_goals_per_team_id_home.each do |team_id, num_goals|
      @stat_tracker.total_games_per_team_id_home.each do |id, num_games|
       lowest_home[team_id] << average(num_goals, num_games) if team_id == id
     end
    end
    lowest_home.min_by {|team_id, avg| avg}[0]
  end

end
