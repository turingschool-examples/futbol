require 'pry'
class LeagueStats < Stats

  def count_of_teams
    @teams.count
  end

  def best_offense
    game_teams = @game_teams.group_by {|game| game.team_id}
    best_offense = game_teams.max_by do |team_id, game_teams|
      game_teams.sum{|game_team| game_team.goals} / game_teams.count.to_f
    end.first

    @teams.find{|team| team.team_id == best_offense}.team_name
  end

  def worst_offense
    game_teams = @game_teams.group_by {|game| game.team_id}
    worst_offense = game_teams.min_by do |team_id, game_teams|
      game_teams.sum{|game_team| game_team.goals} / game_teams.count.to_f
    end.first

    @teams.find{|team| team.team_id == worst_offense}.team_name
  end
end
