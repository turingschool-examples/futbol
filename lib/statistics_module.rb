module Statistacable

  def find_relevant_game_teams_by_teamid(team_id)
    @game_teams.find_all {|game_team| game_team.team_id == team_id }
  end 

  # sort array based on value
  def sort_based_on_value(array)
    array.to_h.sort_by {|key, value| value}
  end

  def determine_team_name_based_on_team_id(result_id)
    selected = teams.select { |team| team.team_id == result_id }
    selected.first.team_name
  end 

  # Input a game as an argument, and then the array of game_teams you are checking against 
  def determine_game_outcome(game, relevant_game_teams) 
    relevant_game_teams.each do |game_team|
      if game_team.game_id == game.game_id
        return game_team.result 
      end
    end
  end

end

