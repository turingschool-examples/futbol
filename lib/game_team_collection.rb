require "csv"
require './lib/game_team'

class GameTeamCollection
  attr_reader :game_team_path, :stat_tracker

  def initialize(game_team_path, stat_tracker)
    @game_team_path = game_team_path
    @stat_tracker   = stat_tracker
    @game_teams     = []
    create_game_teams(game_team_path)
  end

  def create_game_teams(game_team_path)
    data = CSV.parse(File.read(game_team_path), headers: true)
    @game_teams = data.map {|data| GameTeam.new(data, self)}
  end

  #FROM THE GAMES STATS SECTION
  def compare_hoa_to_result(hoa, result)
    @game_teams.count do |game|
      game.HoA == hoa && game.result == result
    end.to_f
  end

  def total_games
    @game_teams.count / 2
  end

  def percentage_home_wins
    (compare_hoa_to_result("home", "WIN") / total_games * 100).round(2)
  end

  def percentage_visitor_wins
    (compare_hoa_to_result("away", "WIN") / total_games * 100).round(2)
  end

  def percentage_ties
    (compare_hoa_to_result("away", "TIE") / total_games  * 100).round(2)
  end

  # League Statistics Methods
  def best_offense
    @stat_tracker.find_team_name(find_highest_goal_team_id)
  end

  def worst_offense
    @stat_tracker.find_team_name(find_lowest_goal_team_id)
  end

  def highest_scoring_visitor
    @stat_tracker.find_team_name(highest_average_team_id_visitor)
  end

  # League Statistics Helper Methods
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
        highest_visitor[team_id] << (num_goals / num_games).round(2) if team_id == id
      end
    end
     highest_visitor.max_by {|team_id, avg| avg}[0]
   end

   def highest_average_team_id_home
     highest_home = Hash.new {|hash_obj, key| hash_obj[key] = []}
     @stat_tracker.total_goals_per_team_id_home.each do |team_id, num_goals|
       @stat_tracker.total_games_per_team_id_home.each do |id, num_games|
         highest_home[team_id] << (num_goals / num_games).round(2) if team_id == id
       end
     end
     highest_home.max_by {|team_id, avg| avg}[0]
   end

  def highest_scoring_home_team
    @stat_tracker.find_team_name(highest_average_team_id_home)
  end

  def lowest_average_team_id_visitor
    lowest_visitor = Hash.new {|hash_obj, key| hash_obj[key] = []}
    @stat_tracker.total_goals_per_team_id_away.each do |team_id, num_goals|
      @stat_tracker.total_games_per_team_id_away.each do |id, num_games|
        if team_id == id
          lowest_visitor[team_id] << (num_goals / num_games).round(2)
        end
      end
    end
     lowest_visitor.min_by {|team_id, avg| avg}[0]
   end

  def lowest_scoring_visitor
    @stat_tracker.find_team_name(lowest_average_team_id_visitor)
  end

   def lowest_average_team_id_home
    lowest_home = Hash.new {|hash_obj, key| hash_obj[key] = []}
    @stat_tracker.total_goals_per_team_id_home.each do |team_id, num_goals|
     @stat_tracker.total_games_per_team_id_home.each do |id, num_games|
       lowest_home[team_id] << (num_goals / num_games).round(2) if team_id == id
     end
    end
    lowest_home.min_by {|team_id, avg| avg}[0]
  end

  def lowest_scoring_home_team
    @stat_tracker.find_team_name(lowest_average_team_id_home)
  end
end
