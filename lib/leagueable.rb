require 'pry'

module Leagueable

    ## HELPER METHODS ##

  def team_total_goals_helper
    # Create a hash by iterating over the csv-teams hash.
    # teams_total_goals hash:
    # Key = team_id
    # Value = total goals scored by that team for ALL seasons
    teams_total_goals = Hash.new
    self.teams.each_key do |team_id|
      teams_total_goals[team_id] = 0
    end

    #iterate through game_teams. Assign the correct team's goals to the respective key value pair, then add 1 to the second hash's key value pair for games played.
    self.game_teams.each do |game_team_obj|
      teams_total_goals.each_key do |team_id_key|
        if game_team_obj.team_id == team_id_key
          teams_total_goals[team_id_key] += game_team_obj.goals
        end
      end
    end
    #Hash
    teams_total_goals
  end

  def team_total_games_helper
    # Create a hash by iterating over the csv-teams hash.
    # teams_total_games hash:
    # Key = team_id
    # Value = total games played by that team for ALL seasons
    teams_total_games = Hash.new
    self.teams.each_key do |team_id|
      teams_total_games[team_id] = 0
    end

    self.game_teams.each do |game_team_obj|
      teams_total_games.each_key do |team_id_key|
        if game_team_obj.team_id == team_id_key
          teams_total_games[team_id_key] += 1
        end
      end
    end
    #Hash
    teams_total_games
  end

  ### Interaction Pattern Methods ###

  # Total number of teams in the data. Return: Int
  # BB
  def count_of_teams
    self.teams.length
  end

  # Name of the team with the highest average number of goals scored per game across all seasons. Return: String
  # JP
  def best_offense
    teams_total_goals = team_total_goals_helper
    teams_total_games = team_total_games_helper

    best_team_goals_average = 0
    best_offense_team_id = 0
    this_team_goals_average = 0
    # iterate over teams_total_games key/value pairs.
    teams_total_games.each do |games_key, games_value|
    # nest an iteration over teams_total_goals key/value pairs.
      teams_total_goals.each do |goals_key, goals_value|
        if goals_key == games_key
          this_team_goals_average = (goals_value / games_value.to_f)
          if this_team_goals_average > best_team_goals_average
            best_team_goals_average = this_team_goals_average
            best_offense_team_id = games_key
          end
        end
      end
    end
    # Then iterate through the teams hash and return the team name that corresponds with the best_offense_team_id
    team_with_best_offense = nil
    self.teams.each_value do |team_obj|
      if team_obj.team_id. == best_offense_team_id
      team_with_best_offense = team_obj.teamName
      end
    end
    team_with_best_offense
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
