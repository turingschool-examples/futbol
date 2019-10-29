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
    self.generate_win_percentage_season(team).max_by{|season, pct| pct}[0]
  end

  def worst_season(team)
    self.generate_win_percentage_season(team).min_by{|season, pct| pct}[0]
  end

  def average_win_percentage(team)
    values = self.generate_win_percentage_season(team).values
    values.reduce {|sum, num| sum + num}.to_f / values.length  
  end

  ##Helper Methods##
  def generate_win_percentage_season(team)
     team_obj = self.convert_team_name_to_obj(team)
     games_by_team = game_teams.group_by {|game| game.team_id}
     by_season = games_by_team[team_obj.team_id].group_by do |game|
       season = find_season_game_id(game.game_id)
     end
     win_percent_season = by_season.transform_values do |val|
       (val.map {|game| game.result == 'WIN' ? 1 : 0}.reduce {|sum, num| sum + num}.to_f / val.length).round(2)
     end
     win_percent_season
  end

  def convert_team_name_to_obj(team_name)
    team_obj = teams.select {|team| team.teamname == team_name}[0]
  end

  def find_season_game_id(gameid)
    game = games.find {|game| game.game_id == gameid}
    game.season
  end




end
