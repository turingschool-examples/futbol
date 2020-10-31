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

  # LeagueStatistics Methods
  def count_of_teams
    @stat_tracker.count_of_teams
  end

  # def best_offense
  #   team_data_set.find do |team_id|
  #      team_id[0] == find_highest_goal_team_id
  #   end[1]
  # end
  #
  # def worst_offense
  #   team_data_set.find do |team_id|
  #      team_id[0] == find_lowest_goal_team_id
  #    end[1]
  # end
  #
  # def highest_scoring_visitor
  #   team_data_set.find do |team_id|
  #     team_id[0] == highest_average_team_id_visitor
  #   end[1]
  # end
  #
  # def highest_scoring_home_team
  #   team_data_set.find do |team_id|
  #     team_id[0] == highest_average_team_id_home
  #   end[1]
  # end
  #
  # def lowest_scoring_visitor
  #   team_data_set.find do |team_id|
  #     team_id[0] == lowest_average_team_id_visitor
  #   end[1]
  # end
  #
  # def lowest_scoring_home_team
  #   team_data_set.find do |team_id|
  #     team_id[0] == lowest_average_team_id_home
  #   end[1]
  # end
  #
  # #Helper_Methods
  # def find_highest_goal_team_id
  #   game_teams_data_set.max_by {|goal| goal[1]}[0]
  # end
  #
  # def find_lowest_goal_team_id
  #   game_teams_data_set.min_by {|goal| goal[1]}[0]
  # end
  #
  # def total_games_per_team_id_away
  #   stat_tracker[:games]['away_team_id'].each_with_object({}) do |num, num_goals_away|
  #   num_goals_away[num] = stat_tracker[:games]['away_team_id'].count do |id|
  #     num == id
  #     end
  #   end
  # end
  #
  # def total_games_per_team_id_home
  #   stat_tracker[:games]['home_team_id'].each_with_object({}) do |num, num_goals_home|
  #   num_goals_home[num] = stat_tracker[:games]['home_team_id'].count do |id|
  #     num == id
  #     end
  #   end
  # end
  #
  # def total_goals_per_team_id_away
  #   sum_goals_away = Hash.new(0)
  #    game_data_set.each do |set|
  #        if sum_goals_away[set[0]].nil?
  #          sum_goals_away[set[0]] = set[2].to_f
  #        else
  #          sum_goals_away[set[0]] += set[2].to_f
  #        end
  #      end
  #    sum_goals_away
  # end
  #
  # def total_goals_per_team_id_home
  #   sum_goals_home = Hash.new(0)
  #    game_data_set.each do |set|
  #        if sum_goals_home[set[1]].nil?
  #          sum_goals_home[set[1]] = set[3].to_f
  #        else
  #          sum_goals_home[set[1]] += set[3].to_f
  #        end
  #      end
  #    sum_goals_home
  # end
  #
  # def highest_average_team_id_visitor
  #   highest_visitor = Hash.new {|hash_obj, key| hash_obj[key] = []}
  #   total_goals_per_team_id_away.each do |team_id, num_goals|
  #     total_games_per_team_id_away.each do |id, num_games|
  #       if team_id == id
  #         highest_visitor[team_id] << (num_goals / num_games).round(2)
  #       end
  #     end
  #   end
  #    highest_visitor.max_by {|team_id, avg| avg}[0]
  #  end
  #
  #  def highest_average_team_id_home
  #    highest_home = Hash.new {|hash_obj, key| hash_obj[key] = []}
  #    total_goals_per_team_id_home.each do |team_id, num_goals|
  #      total_games_per_team_id_home.each do |id, num_games|
  #        if team_id == id
  #          highest_home[team_id] << (num_goals / num_games).round(2)
  #        end
  #      end
  #    end
  #    highest_home.max_by {|team_id, avg| avg}[0]
  #  end
  #
  #  def lowest_average_team_id_visitor
  #  lowest_visitor = Hash.new {|hash_obj, key| hash_obj[key] = []}
  #  total_goals_per_team_id_away.each do |team_id, num_goals|
  #    total_games_per_team_id_away.each do |id, num_games|
  #      if team_id == id
  #        lowest_visitor[team_id] << (num_goals / num_games).round(2)
  #      end
  #    end
  #  end
  #  lowest_visitor.min_by {|team_id, avg| avg}[0]
  #  end
  #
  #  def lowest_average_team_id_home
  #  lowest_home = Hash.new {|hash_obj, key| hash_obj[key] = []}
  #  total_goals_per_team_id_home.each do |team_id, num_goals|
  #    total_games_per_team_id_home.each do |id, num_games|
  #      if team_id == id
  #        lowest_home[team_id] << (num_goals / num_games).round(2)
  #      end
  #    end
  #  end
  #  lowest_home.min_by {|team_id, avg| avg}[0]
  #  end
end
