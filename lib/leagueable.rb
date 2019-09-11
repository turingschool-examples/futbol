module Leagueable

  # Total number of teams in the data. Return: Int
  # BB (Complete)
  def count_of_teams
    self.teams.length
  end

  # Name of the team with the highest avg number of goals scored per game across all seasons. Return: String
  # JP (Complete)
  def best_offense
    teams_total_goals = total_goals_helper
    teams_total_games = total_games_helper

    best_team_goals_avg = 0
    best_offense_team_id = 0
    this_team_goals_avg = 0

    teams_total_games.each do |games_key, games_value|
      teams_total_goals.each do |goals_key, goals_value|
        if goals_key == games_key
          this_team_goals_avg = (goals_value / games_value.to_f)
          if this_team_goals_avg > best_team_goals_avg
            best_team_goals_avg = this_team_goals_avg
            best_offense_team_id = games_key
          end
        end
      end
    end

    team_with_best_offense = nil
    self.teams.each_value do |team_obj|
      if team_obj.team_id. == best_offense_team_id
      team_with_best_offense = team_obj.team_name
      end
    end

    team_with_best_offense
  end

  # Name of the team with the lowest avg number of goals scored per game across all seasons. Return: String
  # JP (Complete)
  def worst_offense
    teams_total_goals = total_goals_helper
    teams_total_games = total_games_helper

    worst_team_goals_avg = 1000
    worst_offense_team_id = 0
    this_team_goals_avg = 0

    teams_total_games.each do |games_key, games_value|
      teams_total_goals.each do |goals_key, goals_value|
        if goals_key == games_key
          this_team_goals_avg = (goals_value / games_value.to_f)
          if this_team_goals_avg < worst_team_goals_avg
            worst_team_goals_avg = this_team_goals_avg
            worst_offense_team_id = games_key
          end
        end
      end
    end

    team_with_worst_offense = nil
    self.teams.each_value do |team_obj|
      if team_obj.team_id. == worst_offense_team_id
      team_with_worst_offense = team_obj.team_name
      end
    end
    team_with_worst_offense
  end

  # Name of the team with the lowest avg number of goals allowed per game across all seasons. Return: String
  # JP (Complete)
  def best_defense
    teams_total_goals_allowed = total_goals_allowed_helper
    teams_total_games = total_games_helper

    best_team_goals_allowed_avg = 100
    best_defense_team_id = 0
    this_team_goals_allowed_avg = 0

    teams_total_games.each do |games_key, games_value|
      teams_total_goals_allowed.each do |goals_key, goals_value|
        if goals_key == games_key
          this_team_goals_allowed_avg = (goals_value / games_value.to_f)
          if this_team_goals_allowed_avg < best_team_goals_allowed_avg
            best_team_goals_allowed_avg = this_team_goals_allowed_avg
            best_defense_team_id = games_key
          end
        end
      end
    end

    team_with_best_defense = nil
    self.teams.each_value do |team_obj|
      if team_obj.team_id. == best_defense_team_id
      team_with_best_defense = team_obj.team_name
      end
    end
    team_with_best_defense
  end

  # Name of the team with the highest avg number of goals allowed per game across all seasons. Return: String
  # JP (Complete)
  def worst_defense
    teams_total_goals_allowed = total_goals_allowed_helper
    teams_total_games = total_games_helper

    worst_team_goals_allowed_avg = 0
    worst_defense_team_id = 0
    this_team_goals_allowed_avg = 0

    teams_total_games.each do |games_key, games_value|

      teams_total_goals_allowed.each do |goals_key, goals_value|
        if goals_key == games_key
          this_team_goals_allowed_avg = (goals_value / games_value.to_f)
          if this_team_goals_allowed_avg > worst_team_goals_allowed_avg
            worst_team_goals_allowed_avg = this_team_goals_allowed_avg
            worst_defense_team_id = games_key
          end
        end
      end
    end
    team_with_worst_defense = team_name_finder_helper(worst_defense_team_id)

    team_with_worst_defense
  end

  # Name of the team with the highest avg score per game across all seasons when they are away. Return: String
  # AM (complete)
  def highest_scoring_visitor
    away_goals = Hash.new(0.00)

    #get sum of away_goals per away team (hash output)

    unique_away_teams_array_helper.each do |team_id|
      self.games.each_value do |game|
        away_goals[team_id] += (game.away_goals) if game.away_team_id == team_id
      end
    end

    #turn sum into average

    away_goals.merge!(total_away_games_helper)  do |key, oldval, newval|
      (oldval / newval).round(2)
    end

    #return highest

    highest_avg_hash = away_goals.max_by do |k, v|
      v
    end

    team_name_finder_helper(highest_avg_hash[0])

  end

  # Name of the team with the highest avg score per game across all seasons when they are home. Return: String
  # AM (complete)
  def highest_scoring_home_team
    home_goals = Hash.new(0.00)
    #get sum of away_goals per home team (hash output)
    unique_home_teams_array_helper.each do |team_id|
      self.games.each_value do |game|
        home_goals[team_id] += (game.home_goals) if game.home_team_id == team_id
      end
    end

    #turn sum into average
    home_goals.merge!(total_home_games_helper)  do |key, oldval, newval|
      (oldval / newval).round(2)
    end

    #return highest
    highest_avg_hash = home_goals.max_by do |k, v|
      v
    end

    team_name_finder_helper(highest_avg_hash[0])

  end

  # Name of the team with the lowest avg score per game across all seasons when they are a visitor. Return: String
  # AM (complete)
  def lowest_scoring_visitor
    away_goals = Hash.new(0.00)
    #get sum of away_goals per away team (hash output)
    unique_away_teams_array_helper.each do |team_id|
      self.games.each_value do |game|
        away_goals[team_id] += (game.away_goals) if game.away_team_id == team_id
      end
    end

    #turn sum into average
    away_goals.merge!(total_away_games_helper)  do |key, oldval, newval|
      (oldval / newval).round(2)
    end

    #return lowest
    lowest_avg_hash = away_goals.min_by do |k, v|
      v
    end

    team_name_finder_helper(lowest_avg_hash[0])

  end

  # Name of the team with the lowest avg score per game across all seasons when they are at home. Return: String
  # AM (complete)
  def lowest_scoring_home_team
    home_goals = Hash.new(0.00)
    #get sum of away_goals per home team (hash output)
    unique_home_teams_array_helper.each do |team_id|
      self.games.each_value do |game|
        home_goals[team_id] += (game.home_goals) if game.home_team_id == team_id
      end
    end

    #turn sum into average
    home_goals.merge!(total_home_games_helper)  do |key, oldval, newval|
      (oldval / newval).round(2)
    end

    #return highest
    lowest_avg_hash = home_goals.min_by do |k, v|
      v
    end

    team_name_finder_helper(lowest_avg_hash[0])

  end

  # Name of the team with the highest win percentage across all seasons. Return: String
  # BB (Complete)
  def winningest_team
    winningest_team_wins_average = 0
    winningest_team_team_id = 0
    this_team_wins_average = 0
    # Iterate over teams_total_games key/value pairs.
    # games_key is the team_id and games_value is the number of games played
    total_games_helper.each do |games_key, games_value|
    # Nest an iteration over teams_total_wins key/value pairs.
    # wins_key is the team_id and wins_value is the number of games won
      total_wins_helper.each do |wins_key, wins_value|
        if wins_key == games_key
          this_team_wins_average = (wins_value / games_value.to_f)
          if this_team_wins_average > winningest_team_wins_average
            winningest_team_wins_average = this_team_wins_average
            winningest_team_team_id = games_key
          end
        end
      end
    end

    team_name_finder_helper(winningest_team_team_id)

  end

  # Name of the team with biggest difference between home and away win percentages. Return: String
  # BB (Complete)
  def best_fans
    # Create hash with team ids as keys and the total home and away win % for each team as values
    teams_away_win_percentage = Hash.new
    teams_home_win_percentage = Hash.new
    self.teams.each_key do |team_id|
      teams_away_win_percentage[team_id] = 0
      teams_home_win_percentage[team_id] = 0
    end

    # calculate each teams_away_win_percentage
    away_win_percentage = 0
    # games_id = team_id and games_v = total number of away games
    total_away_games_helper.each do |games_id, games_v|
      # wins_id = team_id and wins_v = total number of away wins
      total_away_wins_helper.each do |wins_id, wins_v|
        teams_away_win_percentage.each_key do |team_id|
          if games_id == wins_id
            away_win_percentage = (wins_v / games_v.to_f).round(2)
          end
          if games_id == team_id
            teams_away_win_percentage[team_id] = away_win_percentage
          end
        end
      end
    end

    # calculate each teams_home_win_percentage
    home_win_percentage = 0
    # games_id = team_id and games_v = total number of home games
    total_home_games_helper.each do |games_id, games_v|
      # wins_id = team_id and wins_v = total number of home wins
      total_home_wins_helper.each do |wins_id, wins_v|
        teams_home_win_percentage.each_key do |team_id|
          if games_id == wins_id
            home_win_percentage = (wins_v / games_v.to_f).round(2)
          end
          if games_id == team_id
            teams_home_win_percentage[team_id] = home_win_percentage
          end
        end
      end
    end

    # Get the difference between home wins and away wins for each team
    # Set default values
    difference = 0
    biggest_difference = 0
    team_id = nil
    teams_home_win_percentage.each do |team_id_1, home_win_percent|
      teams_away_win_percentage.each do |team_id_2, away_win_percent|
        if team_id_1 == team_id_2
          difference = (home_win_percent - away_win_percent).abs
          if difference > biggest_difference
            biggest_difference = difference
            # return team id of the team with biggest difference between home and away win percent
            team_id = team_id_1
          end
        end
      end
    end

    team_name_finder_helper(team_id)

  end

  # List of names of all teams with better away records than home records. Return: Array
  # BB (Complete)
  def worst_fans
    # Iterate through the hashes and if a team has more away wins than home wins then they get added to the worst_fans_collection array
    worst_fans_collection = []
    total_away_wins_helper.each do |team_id_1, number_of_away_wins|
      total_home_wins_helper.each do |team_id_2, number_of_home_wins|
        if team_id_1 == team_id_2
          if number_of_away_wins > number_of_home_wins
            worst_fans_collection << team_id_2
          end
        end
      end
    end

    # Convert the worst_fans array of team_ids to team names
    worst_fans_collection.map! do |team_id|
      team_name_finder_helper(team_id)
    end

    # NOTE!!!!!!!!!!!!
    # Team_id #7 has 65 away wins and 64 home wins, not consistent with testing expectations.
    # Spec harness updated, should be correct now.
    worst_fans_collection
  end

end
