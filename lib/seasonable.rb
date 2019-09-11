require 'pry'
module Seasonable

  # Name of the team with the biggest decrease between regular season and postseason win percentage.	Return: String
  # BB
  def biggest_bust(season)
    # code goes here!
  end

  # Name of the team with the biggest increase between regular season and postseason win percentage.	Return: String
  # BB
  def biggest_surprise(season)
    # code goes here!
  end

  # Name of the Coach with the best win percentage for the season. Return:	String
  # JP (complete)
  def winningest_coach(season)
    coach_win_percentage_hash = coach_win_percentage_helper(season)
    best_win_percentage = 0.0
    best_coach = ""

    coach_win_percentage_hash.each do |coach, win_percentage|
      if win_percentage > best_win_percentage
        best_win_percentage = win_percentage
        best_coach = coach
      end
    end
    best_coach
  end

  # Name of the Coach with the worst win percentage for the season. Return:	String
  # JP (complete)
  def worst_coach(season)
    coach_win_percentage_hash = coach_win_percentage_helper(season)
    worst_win_percentage = 2.0
    worst_coach = ""

    coach_win_percentage_hash.each do |coach, win_percentage|
      if win_percentage < worst_win_percentage
        worst_win_percentage = win_percentage
        worst_coach = coach
      end
    end
    worst_coach
  end

  # Name of the Team with the best ratio of shots to goals for the season. Return:	String
  # AM
  def most_accurate_team(season)
    # code goes here!
  end

  # Name of the Team with the worst ratio of shots to goals for the season. Return:	String
  # AM
  def least_accurate_team(season)
    # code goes here!
  end

  # Name of the Team with the most tackles in the season. Return:	String
  # JP
  def most_tackles(season)
    total_tackles = tackles_helper(season)
    most_tackles = 0
    best_team = 0
    total_tackles.each do |team, tackles|
      if tackles > most_tackles
        most_tackles = tackles
        best_team = team
      end

    end
    team_name_finder_helper(best_team.to_s)
  end

  # Name of the Team with the fewest tackles in the season. Return:	String
  # JP
  def fewest_tackles(season)
    total_tackles = tackles_helper(season)
    least_tackles = 10000
    worst_team = 0
    total_tackles.each do |team, tackles|
      if tackles < least_tackles
        least_tackles = tackles
        worst_team = team
      end
    end
    team_name_finder_helper(worst_team.to_s)
  end

end
