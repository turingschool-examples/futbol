
class LeagueStatistics
  attr_reader :stat_tracker, :game_manager

  # def initialize(data, game_manager)
  #   @game_manager = game_manager
  def initialize(stat_tracker)
    @stat_tracker = stat_tracker
  end

  def count_of_teams
    stat_tracker[:teams]["team_id"].count
  end

  def team_id_team_name_data_set
    stat_tracker[:teams]["team_id"].zip(stat_tracker[:teams]["teamName"])
  end

  def find_best_offense
    offense_list.max_by do |team_id, avg_goals_per_game|
      avg_goals_per_game
    end.to_a
  end

  def find_worst_offense
    percentages = offense_list.select do |team_id, avg_goals_per_game|
      avg_goals_per_game != 0.0
    end.to_a.min
  end

  def worst_offense
    name = team_id_team_name_data_set.find do |set|
      if set[0] == find_worst_offense[0] && (games_per_team[set[0]] >= 0)
        team_id_team_name_data_set
      end
    end
    name[1]
  end

  def best_offense
    name = team_id_team_name_data_set.find do |set|
      if set[0] == find_best_offense[0]
        team_id_team_name_data_set
      end
    end
    name[1]
  end

  def offense_list
    offense_list = {}
    games_per_team.each do |team_id, number_games|
      offense_list[team_id] = total_points_by_team[team_id].to_f / number_games
    end
    offense_list
    # returns a hash with team_id as the key and average goals a game
  end

  def games_per_team #team_id => total_games_in_a_season
    count_teams = {}
    stat_tracker[:teams]["team_id"].each do |team_number|
      count_teams[team_number] = count_of_teams do |team_id|
        team_id == team_number
      end
    end
    count_teams
  end

  def team_goals_data_set
    stat_tracker[:game_teams]["team_id"].zip(stat_tracker[:game_teams]["goals"])
  end

  def total_points_by_team
    grouping = {}
    team_goals_data_set.each do |total_goals|
      if grouping[total_goals[0]].nil?
        grouping[total_goals[0]] = total_goals[1].to_i
      else
        grouping[total_goals[0]] += total_goals[1].to_i
      end
    end
    grouping
    # returns a hash with team_id as key and total_goals
  end

  def visitor_team_goals_data_set
    stat_tracker[:games]["away_team_id"].zip(stat_tracker[:games]["away_goals"])
  end

  def home_team_goals_data_set
    stat_tracker[:games]["home_team_id"].zip(stat_tracker[:games]["home_goals"])
  end
  def find_visitor_goals
    groupings = {}
    visitor_team_goals_data_set.each do |set|
      if groupings[set[0]].nil?
        groupings[set[0]] = set[1].to_f
      else
        groupings[set[0]] += set[1].to_f
      end
    end
    groupings
  end

  def count_visitor_games_played
    count_games = {}
    stat_tracker[:games]["away_team_id"].each do |game_number|
      count_games[game_number] = stat_tracker[:games]["away_team_id"].count do |game_id|
        game_id == game_number
      end
    end
    count_games
  end

  def average_visitor_goals
    average_goals_per_team = {}
    find_visitor_goals.each do |team_id, number_goals|
      # require 'pry';binding.pry
      average_goals_per_team[team_id] = (number_goals.to_f / count_visitor_games_played[team_id]).round(2)
    end
    average_goals_per_team
  end

  def find_highest_scoring_visitor
    average_visitor_goals.max_by do |team_id, average_visitor_goals|
      average_visitor_goals
    end.to_a
  end

  def highest_scoring_visitor
    save = nil
    find_highest_scoring_visitor.find do |team_id|
      team_id_team_name_data_set.find do |pair|
        if team_id == pair[0]
          save = pair[1]
        end
      end
    end
    save
  end

  def find_lowest_scoring_visitor
    average_visitor_goals.min_by do |team_id, average_visitor_goals|
      average_visitor_goals
    end.to_a
  end

  def lowest_scoring_visitor
    save = nil
    find_lowest_scoring_visitor.find do |team_id|
      team_id_team_name_data_set.find do |pair|
        if team_id == pair[0]
          save = pair[1]
        end
      end
    end
    save
  end

  def highest_scoring_home_team
    save = nil
    find_highest_scoring_home.find do |team_id|
      team_id_team_name_data_set.find do |pair|
        if team_id == pair[0]
          save = pair[1]
        end
      end
    end
    save
  end

  def find_home_goals
    groupings = {}
    home_team_goals_data_set.each do |set|
      if groupings[set[0]].nil?
        groupings[set[0]] = set[1].to_f
      else
        groupings[set[0]] += set[1].to_f
      end
    end
    groupings
    # a hash with team_id as key and total_goals as the value
  end

  def count_home_games_played
    count_games = {}
    stat_tracker[:games]["home_team_id"].each do |game_number|
      count_games[game_number] = stat_tracker[:games]["home_team_id"].count do |game_id|
        game_id == game_number
      end
    end
    count_games
  end

  def find_highest_scoring_home
    average_home_goals.max_by do |team_id, average_home_goals|
      average_home_goals
    end.to_a
  end

  def average_home_goals
    average_goals_per_team = {}
    find_home_goals.each do |team_id, number_goals|
      average_goals_per_team[team_id] = (number_goals / count_home_games_played[team_id]).round(2)
    end
    average_goals_per_team
  end

  def find_lowest_scoring_home
    average_home_goals.min_by do |team_id, average_home_goals|
      average_home_goals
    end.to_a
  end

  def lowest_scoring_home_team
    save = nil
    find_lowest_scoring_home.find do |team_id|
      team_id_team_name_data_set.find do |pair|
        if team_id == pair[0]
          save = pair[1]
        end
      end
    end
    save
  end
end
