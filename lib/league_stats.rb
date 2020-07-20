require 'pry'
class LeagueStats < Stats

  def count_of_teams
    @teams.count
  end

  def game_teams_by_team_id
    @game_teams.group_by {|game| game.team_id}
  end

  def best_offense
    best_offense = game_teams_by_team_id.max_by do |team_id, game_teams|
      game_teams.sum{|game_team| game_team.goals} / game_teams.count.to_f
    end.first

    @teams.find{|team| team.team_id == best_offense}.team_name
  end

  def worst_offense
    worst_offense = game_teams_by_team_id.min_by do |team_id, game_teams|
      game_teams.sum{|game_team| game_team.goals} / game_teams.count.to_f
    end.first

    @teams.find{|team| team.team_id == worst_offense}.team_name
  end

  def find_all_away_teams
    @game_teams.find_all {|game| game.hoa == "away"}
  end

  def away_games_by_team_id
    find_all_away_teams.group_by {|game| game.team_id}
  end

  def highest_scoring_visitor
    best_away_team = away_games_by_team_id.max_by do |team_id, game_teams|
      game_teams.sum{|game_team| game_team.goals} / game_teams.count.to_f
    end.first

    @teams.find{|team| team.team_id == best_away_team}.team_name
  end
  def lowest_scoring_visitor
    worst_away_team = away_games_by_team_id.min_by do |team_id, game_teams|
      game_teams.sum{|game_team| game_team.goals} / game_teams.count.to_f
    end.first

    @teams.find{|team| team.team_id == worst_away_team}.team_name
  end

  def find_all_home_teams
    @game_teams.find_all {|game| game.hoa == "home"}
  end

  def home_games_by_team_id
    find_all_home_teams.group_by {|game| game.team_id}
  end

  def highest_scoring_home_team
    best_home_team = home_games_by_team_id.max_by do |team_id, game_teams|
      game_teams.sum{|game_team| game_team.goals} / game_teams.count.to_f
    end.first

    @teams.find{|team| team.team_id == best_home_team}.team_name
  end

  def lowest_scoring_home_team
    worst_home_team = home_games_by_team_id.min_by do |team_id, game_teams|
      game_teams.sum{|game_team| game_team.goals} / game_teams.count.to_f
    end.first

    @teams.find{|team| team.team_id == worst_home_team}.team_name
  end

end
