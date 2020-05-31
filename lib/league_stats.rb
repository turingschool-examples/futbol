class LeagueStats
  attr_reader :games_collection,
              :teams_collection,
              :game_teams_collection

  def initialize(file_path)
    @games_collection = file_path[:games_collection]
    @teams_collection = file_path[:teams_collection]
    @game_teams_collection = file_path[:game_teams_collection]
  end

  def count_of_teams
    @teams_collection.teams.count
  end

  def unique_team_ids
    ids = @game_teams_collection.game_teams.each do |game_team|
      game_team.team_id
    end
    ids.map do |game_team|
      game_team.team_id.to_i
    end.uniq
  end

  def games_sorted_by_team_id(team_id)
    @game_teams_collection.game_teams.find_all do |game_team|
      game_team.team_id.to_i == team_id
    end
  end

  def total_goals_by_team_id(team_id)
    games_sorted_by_team_id(team_id).sum do |game_team|
      game_team.goals.to_i
    end
  end

  def average_goals_by_team_id(team_id)
      (total_goals_by_team_id(team_id).to_f / games_sorted_by_team_id(team_id).count).round(2)
  end

  def best_offense
    top_o = unique_team_ids.max_by do |team_id|
      average_goals_by_team_id(team_id)
    end
    @teams_collection.teams.find do |team|
      team.team_id == top_o.to_s
    end.teamname
  end

  def worst_offense
    bad_o = unique_team_ids.min_by do |team_id|
      average_goals_by_team_id(team_id)
    end
    @teams_collection.teams.find do |team|
      team.team_id == bad_o.to_s
    end.teamname
  end

  def highest_scoring_visitor
    away_teams = @game_teams_collection.game_teams.find_all do |team|
      team.hoa == "away"
    end
    by_team = away_teams.group_by do |team|
      team.team_id
    end
    average = by_team.transform_values do |games|
      sum_goals = games.sum do |game|
        game.goals.to_f
      end
      (sum_goals / games.length).round(2)
    end
    highest_average = average.max_by do |team_id, average|
      average
    end
    @teams_collection.teams.find do |team|
      team.team_id == highest_average.first
    end.teamname
  end

  def highest_scoring_home_team
    home_teams = @game_teams_collection.game_teams.find_all do |team|
      team.hoa == "home"
    end
    by_team = home_teams.group_by do |team|
      team.team_id
    end
    average = by_team.transform_values do |games|
      sum_goals = games.sum do |game|
        game.goals.to_f
      end
      (sum_goals / games.length).round(2)
    end
    highest_average = average.max_by do |team_id, average|
      average
    end
    @teams_collection.teams.find do |team|
      team.team_id == highest_average.first
    end.teamname
  end

  def lowest_scoring_visitor
    away_teams = @game_teams_collection.game_teams.find_all do |team|
      team.hoa == "away"
    end
    by_teams = away_teams.group_by do |team|
      team.team_id
    end
    by_teams.each do |team_id, games|
      by_teams[team_id] = (games.sum { |game| game.goals.to_i } / games.count.to_f )
    end
    lowest_scoring = by_teams.select { |_, v| v == by_teams.values.min}
    @teams_collection.teams.find do |team|
      team.team_id == lowest_scoring.keys.first
    end.teamname
  end

  def lowest_scoring_home_team
    home_teams = @game_teams_collection.game_teams.find_all do |team|
      team.hoa == "home"
    end
    by_teams = home_teams.group_by do |team|
      team.team_id
    end
    by_teams.each do |team_id, games|
      by_teams[team_id] = (games.sum { |game| game.goals.to_i } / games.count.to_f )
    end
    lowest_scoring = by_teams.select { |_, value| value == by_teams.values.min}
    @teams_collection.teams.find do |team|
      team.team_id == lowest_scoring.keys.first
    end.teamname
  end
end
