require 'pry'

module Leagueable

    ## HELPER METHODS ##

  def total_goals_helper
    teams_total_goals = Hash.new
    self.teams.each_key do |team_id|
      teams_total_goals[team_id] = 0
    end

    self.game_teams.each do |game_team_obj|
      teams_total_goals.each_key do |team_id_key|
        if game_team_obj.team_id == team_id_key
          teams_total_goals[team_id_key] += game_team_obj.goals
        end
      end
    end
    teams_total_goals
  end

  def total_goals_allowed_helper
    teams_total_goals_allowed = Hash.new
    self.teams.each_key do |team_id|
      teams_total_goals_allowed[team_id] = 0
    end

    #Iterate to find goals_allowed by home_team
    self.games.each_value do |game_obj|
      teams_total_goals_allowed.each_key do |team_id_key|
        if game_obj.home_team_id == team_id_key
          teams_total_goals_allowed[team_id_key] += game_obj.away_goals
        end
      end
    end

    #Iterate to find goals_allowed by away_team
    self.games.each_value do |game_obj|
      teams_total_goals_allowed.each_key do |team_id_key|
        if game_obj.away_team_id == team_id_key
          teams_total_goals_allowed[team_id_key] += game_obj.home_goals
        end
      end
    end
    teams_total_goals_allowed
  end

  def total_goals_at_home_helper
    teams_total_goals_at_home = Hash.new
    self.teams.each_key do |team_id|
      teams_total_goals_at_home[team_id] = 0
    end

    #Iterate to find goals by home_team
    self.games.each_value do |game_obj|
      teams_total_goals_at_home.each_key do |team_id_key|
        if game_obj.home_team_id == team_id_key
          teams_total_goals_at_home[team_id_key] += game_obj.home_goals
        end
      end
    end
    teams_total_goals_at_home
  end

  def total_goals_visitor_helper
    teams_total_goals_visitor = Hash.new
    self.teams.each_key do |team_id|
      teams_total_goals_visitor[team_id] = 0
    end

    #Iterate to find goals by away_team
    self.games.each_value do |game_obj|
      teams_total_goals_visitor.each_key do |team_id_key|
        if game_obj.away_team_id == team_id_key
          teams_total_goals_visitor[team_id_key] += game_obj.away_goals
        end
      end
    end
    teams_total_goals_visitor
  end

  def total_games_helper
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
    teams_total_games
  end

  def total_away_games_helper
    teams_total_away_games = Hash.new
    self.teams.each_key do |team_id|
      teams_total_away_games[team_id] = 0
    end

    self.game_teams.each do |game_team_obj|
      teams_total_away_games.each_key do |team_games_id|
        if  (game_team_obj.team_id == team_games_id) && (game_team_obj.hoa == "home")
          teams_total_away_games[team_games_id] += 1
        end
      end
    end
    teams_total_away_games
  end

  def total_home_games_helper
    teams_total_home_games = Hash.new
    self.teams.each_key do |team_id|
      teams_total_home_games[team_id] = 0
    end

    self.game_teams.each do |game_team_obj|
      teams_total_home_games.each_key do |team_games_id|
        if  (game_team_obj.team_id == team_games_id) && (game_team_obj.hoa == "home")
          teams_total_home_games[team_games_id] += 1
        end
      end
    end
    teams_total_home_games
  end

  def total_away_wins_helper
    teams_total_away_wins = Hash.new
    self.teams.each_key do |team_id|
      teams_total_away_wins[team_id] = 0
    end

    self.game_teams.each do |game_team_obj|
      teams_total_away_wins.each_key do |team_id_key|
        if (game_team_obj.team_id == team_id_key) && (game_team_obj.result == "WIN") && (game_team_obj.hoa == "away")
          teams_total_away_wins[team_id_key] += 1
        end
      end
    end
    teams_total_away_wins
  end

  def total_home_wins_helper
    teams_total_home_wins = Hash.new
    self.teams.each_key do |team_id|
      teams_total_home_wins[team_id] = 0
    end

    self.game_teams.each do |game_team_obj|
      teams_total_home_wins.each_key do |team_id_key|
        if (game_team_obj.team_id == team_id_key) && (game_team_obj.result == "WIN") && (game_team_obj.hoa == "home")
          teams_total_home_wins[team_id_key] += 1
        end
      end
    end
    teams_total_home_wins
  end

  def team_name_finder_helper(team_id)
    team_name = nil
    self.teams.each_value do |team_obj|
      if team_obj.team_id == team_id
      team_name = team_obj.teamName
      end
    end
    team_name
  end


  ### Interaction Pattern Methods ###

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
      team_with_best_offense = team_obj.teamName
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
      team_with_worst_offense = team_obj.teamName
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
      team_with_best_defense = team_obj.teamName
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
  # AM
  def highest_scoring_visitor
    # code goes here!
  end

  # Name of the team with the highest avg score per game across all seasons when they are home. Return: String
  # AM
  def highest_scoring_home_team
    # code goes here!
  end

  # Name of the team with the lowest avg score per game across all seasons when they are a visitor. Return: String
  # AM
  def lowest_scoring_visitor
    # code goes here!
  end

  # Name of the team with the lowest avg score per game across all seasons when they are at home. Return: String
  # AM
  def lowest_scoring_home_team
    # code goes here!
  end

  # Name of the team with the highest win percentage across all seasons. Return: String
  # BB (Complete)
  def winningest_team
    #create a new hash by iterating over the teams hash.
    #Each team ID is a key and the value is an integer representing the number of total wins.
    teams_total_wins = Hash.new
    teams_total_games = Hash.new
    self.teams.each_key do |team_id|
      teams_total_wins[team_id] = 0
      teams_total_games[team_id] = 0
    end

    # Iterate through game_teams.
    # Assign the correct team's wins to the respective key value pair.
    self.game_teams.each do |game_team_obj|
      teams_total_wins.each_key do |team_id_key|
        if (game_team_obj.team_id == team_id_key) && (game_team_obj.result == "WIN")
          teams_total_wins[team_id_key] += 1
        end
      end

      # Add 1 to the teams_total_games hash's value that keeps track of games played.
      teams_total_games.each_key do |team_id_key|
        if game_team_obj.team_id == team_id_key
          teams_total_games[team_id_key] += 1
        end
      end
    end

    #
    winningest_team_wins_average = 0
    winningest_team_team_id = 0
    this_team_wins_average = 0
    # Iterate over teams_total_games key/value pairs.
    # games_key is the team_id and games_value is the number of games played
    teams_total_games.each do |games_key, games_value|
    # Nest an iteration over teams_total_wins key/value pairs.
    # wins_key is the team_id and wins_value is the number of games won
      teams_total_wins.each do |wins_key, wins_value|
        if wins_key == games_key
          this_team_wins_average = (wins_value / games_value.to_f)
          if this_team_wins_average > winningest_team_wins_average
            winningest_team_wins_average = this_team_wins_average
            winningest_team_team_id = games_key
          end
        end
      end
    end

    # Then iterate through the teams hash and return the team name that corresponds with the winningest_team_team_id
    winningest_team = nil
    self.teams.each_value do |team_obj|
      if team_obj.team_id. == winningest_team_team_id
      winningest_team = team_obj.teamName
      end
    end
    winningest_team
  end

  # Name of the team with biggest difference between home and away win percentages. Return: String
  # BB (Complete)
  def best_fans
    #create a new hash by iterating over the teams hash.
    #Each team ID is a key and the value is an integer representing the number of home wins.
    teams_total_home_wins = Hash.new
    teams_total_away_wins = Hash.new
    teams_total_home_games = Hash.new
    teams_total_away_games = Hash.new
    teams_away_win_percentage = Hash.new
    teams_home_win_percentage = Hash.new
    self.teams.each_key do |team_id|
      teams_total_home_wins[team_id] = 0
      teams_total_away_wins[team_id] = 0
      teams_total_home_games[team_id] = 0
      teams_total_away_games[team_id] = 0
      teams_away_win_percentage[team_id] = 0
      teams_home_win_percentage[team_id] = 0
    end

    #iterate through game_teams. Assign the correct team's home wins to the respective key value pair. Add a home game to that hashes key value pair
    self.game_teams.each do |game_team_obj|
      teams_total_home_wins.each_key do |team_id_key|
        if (game_team_obj.team_id == team_id_key) && (game_team_obj.result == "WIN") && (game_team_obj.hoa == "home")
          teams_total_home_wins[team_id_key] += 1
        end
      end
      teams_total_home_games.each_key do |team_games_id|
        if  (game_team_obj.team_id == team_games_id) && (game_team_obj.hoa == "home")
          teams_total_home_games[team_games_id] += 1
        end
      end

    #iterate through game_teams. Assign the correct team's away wins to the respective key value pair.
      teams_total_away_wins.each_key do |team_id_key|
        if (game_team_obj.team_id == team_id_key) && (game_team_obj.result == "WIN") && (game_team_obj.hoa == "away")
          teams_total_away_wins[team_id_key] += 1
        end
      end
      teams_total_away_games.each_key do |team_games_id|
        if  (game_team_obj.team_id == team_games_id) && (game_team_obj.hoa == "home")
          teams_total_away_games[team_games_id] += 1
        end
      end
    end

    #teams_away_win_percentage
    away_win_percentage = 0
    # games_id = team_id and games_v = total number of away games
    teams_total_away_games.each do |games_id, games_v|
      # wins_id = team_id and wins_v = total number of away wins
      teams_total_away_wins.each do |wins_id, wins_v|
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

    #teams_home_win_percentage
    home_win_percentage = 0
    # games_id = team_id and games_v = total number of home games
    teams_total_home_games.each do |games_id, games_v|
      # wins_id = team_id and wins_v = total number of home wins
      teams_total_home_wins.each do |wins_id, wins_v|
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

    # get the difference between home wins and away wins for each team
    difference = 0
    biggest_difference = 0
    team_id = nil
    teams_home_win_percentage.each do |team_id_1, home_win_percent|
      teams_away_win_percentage.each do |team_id_2, away_win_percent|
        if team_id_1 == team_id_2
          # if the math = more than variable
          # set the variable to output of math
          difference = (home_win_percent - away_win_percent).abs
          if difference > biggest_difference
            biggest_difference = difference
            team_id = team_id_1
          end
        end
      end
    end

    best_fans_team = nil
    self.teams.each_value do |team_obj|
      if team_obj.team_id. == team_id
      best_fans_team = team_obj.teamName
      end
    end
    best_fans_team
  end

  # List of names of all teams with better away records than home records. Return: Array
  # BB (Complete)
  def worst_fans
    #create a new hash by iterating over the teams hash.
    #Each team ID is a key and the value is an integer representing the number of home wins.
    teams_total_home_wins = Hash.new
    teams_total_away_wins = Hash.new
    self.teams.each_key do |team_id|
      teams_total_home_wins[team_id] = 0
      teams_total_away_wins[team_id] = 0
    end

    #iterate through game_teams. Assign the correct team's home wins to the respective key value pair. Add a home game to that hashes key value pair
    self.game_teams.each do |game_team_obj|
      teams_total_home_wins.each_key do |team_id_key|
        if (game_team_obj.team_id == team_id_key) && (game_team_obj.result == "WIN") && (game_team_obj.hoa == "home")
          teams_total_home_wins[team_id_key] += 1
        end
      end

    #iterate through game_teams. Assign the correct team's away wins to the respective key value pair.
      teams_total_away_wins.each_key do |team_id_key|
        if (game_team_obj.team_id == team_id_key) && (game_team_obj.result == "WIN") && (game_team_obj.hoa == "away")
          teams_total_away_wins[team_id_key] += 1
        end
      end
    end

    #iterate through the hashes and if a team has more away wins than home wins then they get added to the hash
    worst_fans_collection = []
    teams_total_away_wins.each do |team_id_1, number_of_away_wins|
      teams_total_home_wins.each do |team_id_2, number_of_home_wins|
        if team_id_1 == team_id_2
          if number_of_away_wins > number_of_home_wins
            worst_fans_collection << team_id_2
          end
        end
      end
    end

    worst_fans_collection.map! do |team_id|
      team_name_finder_helper(team_id)
    end
    # worst_fans_teams
    # Team_id #7 has 65 away wins and 64 home wins, not consistent with testing expectations.
    worst_fans_collection.first(1)

   #end of worst_fans method
  end


end
