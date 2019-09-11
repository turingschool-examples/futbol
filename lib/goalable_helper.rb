module GoalableHelper
### From Leagueable_Helper ###

  def total_goals_helper(team_id = "0")
    teams_total_goals = Hash.new(0)
    if team_id == "0" #all teams in hash
      self.games.each_value do |game|
        teams_total_goals[game.away_team_id] += game.away_goals
        teams_total_goals[game.home_team_id] += game.home_goals
      end
    else  #for only one team (away or home)
      self.games.each_value do |game|
        teams_total_goals[team_id] += game.away_goals if game.away_team_id == team_id
        teams_total_goals[team_id] += game.home_goals if game.home_team_id == team_id
      end
    end
    teams_total_goals
  end

  def total_goals_allowed_helper(team_id = "0")
    teams_total_goals_allowed = Hash.new(0)
    if team_id == "0" #all teams in hash
      self.games.each_value do |game|
        teams_total_goals_allowed[game.away_team_id] += game.home_goals
        teams_total_goals_allowed[game.home_team_id] += game.away_goals
      end
    else  #for only one team (away or home)
      self.games.each_value do |game|
        teams_total_goals_allowed[team_id] += game.home_goals if game.away_team_id == team_id
        teams_total_goals_allowed[team_id] += game.away_goals if game.home_team_id == team_id
      end
    end
    teams_total_goals_allowed
  end

  def total_goals_at_home_helper(team_id = "0")
    teams_total_goals_at_home = Hash.new(0)
    if team_id == "0" #all teams in hash
      self.games.each_value do |game|
        teams_total_goals_at_home[game.home_team_id] += game.home_goals
      end
    else  #for only one team (away or home)
      self.games.each_value do |game|
        teams_total_goals_at_home[team_id] += game.home_goals if game.home_team_id == team_id
      end
    end
    teams_total_goals_at_home
  end

  def total_goals_visitor_helper(team_id = "0")
    teams_total_goals_visitor = Hash.new(0)
    if team_id == "0" #all teams in hash
      self.games.each_value do |game|
        teams_total_goals_visitor[game.away_team_id] += game.away_goals
      end
    else  #for only one team (away or home)
      self.games.each_value do |game|
        teams_total_goals_visitor[team_id] += game.away_goals if game.away_team_id == team_id
      end
    end
    teams_total_goals_visitor
  end

end
