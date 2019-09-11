module LeagueableHelper

  def total_games_helper(team_id = "0")
    teams_total_games = Hash.new(0)
    if team_id == "0" #all teams in hash
      self.games.each_value do |game|
        teams_total_games[game.away_team_id] += 1
        teams_total_games[game.home_team_id] += 1
      end
    else  #for only one team (away or home)
      self.games.each_value do |game|
        teams_total_games[team_id] += 1 if game.away_team_id == team_id
        teams_total_games[team_id] += 1 if game.home_team_id == team_id
      end
    end
    teams_total_games
  end

  def total_away_games_helper(team_id = "0")
    teams_total_away_games = Hash.new(0)
    if team_id == "0" #all teams in hash
      self.games.each_value do |game|
        teams_total_away_games[game.away_team_id] += 1
      end
    else  #for only one away team
      self.games.each_value do |game|
        teams_total_away_games[team_id] += 1 if game.away_team_id == team_id
      end
    end
    teams_total_away_games
  end

  def total_home_games_helper(team_id = "0")
    teams_total_home_games = Hash.new(0)
    if team_id == "0" #all teams in hash
      self.games.each_value do |game|
        teams_total_home_games[game.away_team_id] += 1
      end
    else  #for only one home team
      self.games.each_value do |game|
        teams_total_home_games[team_id] += 1 if game.home_team_id == team_id
      end
    end
    teams_total_home_games
  end

  def total_away_wins_helper(team_id = "0")
    teams_total_away_wins = Hash.new(0)
    if team_id == "0" #all teams in hash
      self.games.each_value do |game|
        if game.away_goals > game.home_goals
          teams_total_away_wins[game.away_team_id] += 1
        end
      end
    else  #for only one team (away or home)
      self.games.each_value do |game|
        if game.away_team_id == team_id
          teams_total_away_wins[team_id] += 1 if game.away_goals > game.home_goals
        end
      end
    end
    teams_total_away_wins
  end

  def total_home_wins_helper(team_id = "0")
    teams_total_home_wins = Hash.new(0)
    if team_id == "0" #all teams in hash
      self.games.each_value do |game|
        if game.home_goals > game.away_goals
          teams_total_home_wins[game.home_team_id] += 1
        end
      end
    else  #for only one team (away or home)
       self.games.each_value do |game|
         if game.home_team_id == team_id
           teams_total_home_wins[team_id] += 1 if game.home_goals > game.away_goals
         end
       end
    end
    teams_total_home_wins
  end

  def total_wins_helper(team_id = "0")
    teams_total_wins = Hash.new(0)
    if team_id == "0" #all teams in hash
      self.games.each_value do |game|
        if game.home_goals > game.away_goals
          teams_total_wins[game.home_team_id] += 1
        elsif game.away_goals > game.home_goals
          teams_total_wins[game.away_team_id] += 1
        end
      end
    else  #for only one team (away or home)
      self.games.each_value do |game|
        if game.away_team_id == team_id
          teams_total_wins[team_id] += 1 if game.away_goals > game.home_goals
        elsif game.home_team_id == team_id
          teams_total_wins[team_id] += 1 if game.home_goals > game.away_goals
        end
      end
    end
    teams_total_wins
  end

  def team_name_finder_helper(team_id)
    team_name = nil
    self.teams.each_value do |team_obj|
      if team_obj.team_id == team_id
      team_name = team_obj.team_name
      end
    end
    team_name
  end

  def unique_home_teams_array_helper
    unique_home_teams = []
    self.games.each_value do |game|
      unique_home_teams << game.home_team_id
    end
    unique_home_teams.uniq
  end

  def unique_away_teams_array_helper
    unique_away_teams = []
    self.games.each_value do |game|
      unique_away_teams << game.away_team_id
    end
    unique_away_teams.uniq
  end

end
