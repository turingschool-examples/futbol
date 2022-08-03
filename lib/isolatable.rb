module Isolatable
  def team_isolator(team_id) #game_teams helper, returns all of a team's games
    @game_teams.find_all { |game| team_id == game.team_id }
  end

  def win_isolator(team_id) #game_teams helper, returns all of a team's wins in an array
    @game_teams.find_all { |game| team_id == game.team_id && game.result == "WIN" }
  end

  def isolate_coach_wins(game_id_list)
    coaches = Hash.new(0)
    @game_teams.each do |game_team|
      coach = game_team.head_coach
      if game_id_list.include?(game_team.game_id) && game_team.result == "WIN"
        coaches[coach] += 1
      end
    end
    coaches
  end

  def isolate_coach_loss(game_id_list)
    coaches = Hash.new(0)
    @game_teams.each do |game_team|
      coach = game_team.head_coach
      if game_id_list.include?(game_team.game_id) && game_team.result == "LOSS"
        coaches[coach] += 1
      end
    end
    coaches
  end
end
