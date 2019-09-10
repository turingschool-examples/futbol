module Seasonable

  # Name of the team with the biggest decrease between regular season and postseason win percentage.	Return: String
  # BB
  def biggest_bust
    # code goes here!
  end

  # Name of the team with the biggest increase between regular season and postseason win percentage.	Return: String
  # BB
  def biggest_surprise
    # code goes here!
  end

  # Name of the Coach with the best win percentage for the season. Return:	String
  # JP
  def winningest_coach
    # code goes here!
  end

  # Name of the Coach with the worst win percentage for the season. Return:	String
  # JP
  def worst_coach
    # code goes here!
  end

  # Name of the Team with the best ratio of shots to goals for the season. Return:	String
  # AM
  def most_accurate_team
    # code goes here!
  end

  # Name of the Team with the worst ratio of shots to goals for the season. Return:	String
  # AM
  def least_accurate_team
    # code goes here!
  end

  # Name of the Team with the most tackles in the season. Return:	String
  # AM
  def most_tackles
    # code goes here!
  end

  # Name of the Team with the fewest tackles in the season. Return:	String
  # AM
  def fewest_tackles
    # code goes here!
  end

  ### Helper Methods ###

  def regular_season_win_percentage_helper(season) #ALL Teams. Hash. Key = Team_id, Value = win percentage
  end

  def postseason_win_percentage_helper(season) #ALL Teams. Hash. Key = Team_id, Value = win percentage
  end

  def coach_win_percentage_helper(season) #ALL Coaches. Hash. Key = coach name, Value = win percentage
  end

  def shots_helper(season) #ALL Teams. Hash. Key = Team_id, Value = shots
  end

  def goals_helper(season) #ALL Teams. Hash. Key = Team_id, Value = goals
  end

  def tackles_helper(season) #ALL Teams. Hash. Key = Team_id, Value = tackles
  end
  
end
