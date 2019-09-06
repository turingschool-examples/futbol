module Leagueable

  # Total number of teams in the data. Return: Int
  # BB
  def count_of_teams
    teams.length
  end

  # Name of the team with the highest average number of goals scored per game across all seasons. Return: String
  # JP
  def best_offense
    # code goes here!
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
