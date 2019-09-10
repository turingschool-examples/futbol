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
    coach_array = coach_array_helper
    coach_win_game_hash = Hash.new(0)
    coach_win_per
    until coach_array == []
      coach_win_game_hash[coach_array.shift]
    end
    self.game_teams.each do |game_obj|
      coach_win_game_hash.each_key do |coach|
        if coach == game_obj.head_coach
          if game_obj.result == "WIN"
            [coach][:win] += 1
            [coach][:games] += 1
          elsif game_obj.result == "LOSS"
            [coach][:games] += 1
          end
        end
      end
    end
    coach_win_game_hash.each do |coach, win_games|

    end
  end

  def coach_array_helper #All uniq coaches in an array
    coach_array = []
    self.game_teams.each do |game_obj|
      coach_array << game_obj.head_coach
    end
    coach_array.uniq!.sort!
  end

  def shots_helper(season) #ALL Teams. Hash. Key = Team_id, Value = shots
  end

  def goals_helper(season) #ALL Teams. Hash. Key = Team_id, Value = goals
  end

  def tackles_helper(season) #ALL Teams. Hash. Key = Team_id, Value = tackles
  end

end
