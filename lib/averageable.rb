module Averageable
  def minimum(average)
    average.min { |avg_1, avg_2| avg_1[1] <=> avg_2[1] }
  end

  def maximum(average)
    average.max { |avg_1, avg_2| avg_1[1] <=> avg_2[1] }
  end

  def average_goals_to_shots_by_season(season_id, game_id_list)
    goals = Hash.new(0)
    shots = Hash.new(0)
    ratio = Hash.new(0)
    @game_teams_stats.game_teams.each do |game_team|
      game_id = game_team.game_id
      current_team_id = game_team.team_id
      if game_id_list.include?(game_id)
        goals[current_team_id] += game_team.goals.to_f
        shots[current_team_id] += game_team.shots.to_f
        ratio[current_team_id] = goals[current_team_id] / shots[current_team_id]
      end
    end
    return ratio
  end
end