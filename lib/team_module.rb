require 'pry'
module TeamModule
  def team_info(team)
    team_obj = teams.select {|team_obj| team_obj.teamname == team}[0]
    team_info = {
      Name: team_obj.teamname,
      Team_id: team_obj.team_id,
      Franchise_id: team_obj.franchiseid,
      Abbreviation: team_obj.abbreviation,
      Link: team_obj.link
    }
    team_info
  end

  def best_season

  end

  def worst_season

  end

  def average_win_percentage

  end


end
