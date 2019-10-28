require 'pry'
module TeamModule
  def team_info(team)
    team_obj = self.convert_team_name_to_obj(team)
    team_info = {
      Name: team_obj.teamname,
      Team_id: team_obj.team_id,
      Franchise_id: team_obj.franchiseid,
      Abbreviation: team_obj.abbreviation,
      Link: team_obj.link
    }
    team_info
  end

  def best_season(team)
    self.generate_win_percentage_season(team)

  end

  def worst_season

  end

  def average_win_percentage

  end

  ##Helper Methods
  def generate_win_percentage_season(team)
     team_obj = self.convert_team_name_to_obj(team)
     seasons = self.generate_seasons_hash(games)
     games_by_team = game_teams.group_by do |game|
       game.team_id
     end
     binding.pry
  end

  def convert_team_name_to_obj(team)
    team_obj = teams.select {|team_obj| team_obj.teamname == team}[0]
  end

end
