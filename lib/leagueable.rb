require 'pry'

module Leagueable

  # Total number of teams in the data. Return: Int
  # BB
  def count_of_teams
    teams.length
  end

  # Name of the team with the highest average number of goals scored per game across all seasons. Return: String
  # JP
  def best_offense
    #create a new hash by iterating over the teams hash. Each team ID is a key and the value is an integer representing the number of total goals.
    teams_total_goals = Hash.new
    self.teams.each_key do |team_id|
      teams_total_goals[team_id] = 0
    end

    #create a second hash by iterating over the teams hash. Each Team ID is a key and the value is an integer representing number of games
    teams_total_games = Hash.new
    self.teams.each_key do |team_id|
      teams_total_games[team_id] = 0
    end

    #iterate through game_teams. Assign the correct team's goals to the respective key value pair, then add 1 to the second hash's key value pair for games played.
    self.game_teams.each do |game_team_obj|
      teams_total_goals.each_key do |team_id_key|
        if game_team_obj.team_id == team_id_key
          teams_total_goals[team_id_key] += game_team_obj.goals
        end
      end

      teams_total_games.each_key do |team_id_key|
        if game_team_obj.team_id == team_id_key
          teams_total_games[team_id_key] += 1
        end
      end
    end

    # team_goals_average = 0
    # best best_offense_team_id = 0
    # iterate over teams_total_games key/value pairs.
    # nest an iteration over teams_total_games key/value pairs.
    # if goals_key == games_key
    # this_teams_goals_average = goals_value / games_value
    #     if this_teams_goals_average > team_goals_average
    # =>      team_goals_average = this_teams_goals_average
    # =>        best_offense_team_id = games_key

    # Then iterate through the teams hash and return the team name that corresponds with the team id
    binding.pry
  end

  # Name of the team with the lowest average number of goals scored per game across all seasons. Return: String
  # JP
  def worst_offense
    # code goes here!
  end

  # Name of the team with the lowest average number of goals allowed per game across all seasons. Return: String
  # JP
  def best_defense
    # code goes here!
  end

  # Name of the team with the highest average number of goals allowed per game across all seasons. Return: String
  # JP
  def worst_defense
    # code goes here!
  end

  # Name of the team with the highest average score per game across all seasons when they are away. Return: String
  # AM
  def highest_scoring_visitor
    # code goes here!
  end

  # Name of the team with the highest average score per game across all seasons when they are home. Return: String
  # AM
  def highest_scoring_home_team
    # code goes here!
  end

  # Name of the team with the lowest average score per game across all seasons when they are a visitor. Return: String
  # AM
  def lowest_scoring_visitor
    # code goes here!
  end

  # Name of the team with the lowest average score per game across all seasons when they are at home. Return: String
  # AM
  def lowest_scoring_home_team
    # code goes here!
  end

  # Name of the team with the highest win percentage across all seasons. Return: String
  # BB
  def winningest_team
   # itrate through data and add team ids to a hash as keys
   # set values for each key to 0
   # iterate through data again and for every win/goal add x to that teams value
  end

  # Name of the team with biggest difference between home and away win percentages. Return: String
  # BB
  def best_fans
    # code goes here!
  end

  # List of names of all teams with better away records than home records. Return: Array
  # BB
  def worst_fans
    # code goes here!
  end

end
