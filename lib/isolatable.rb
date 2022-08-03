module Isolatable
  def team_isolator(team_id) #game_teams helper, returns all of a team's games
    @game_teams.find_all { |game| team_id == game.team_id }
  end

  def win_isolator(team_id) #game_teams helper, returns all of a team's wins in an array
    @game_teams.find_all { |game| team_id == game.team_id && game.result == "WIN" }
  end
end