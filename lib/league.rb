require './lib/sortable'

class League
  include Sortable
  attr_reader :all_games, :all_teams, :all_game_teams

  def initialize(all_games, all_teams, all_game_teams)
    @all_games = all_games
    @all_teams = all_teams
    @all_game_teams = all_game_teams
  end

  def total_goals
    @all_games.map do |game|
      game.home_goals.to_i + game.away_goals.to_i
    end
  end

  def games_by_season
    games_by_season = Hash.new(0)
    sort_games_by_season(@all_games).each do |season, games|
      games_by_season[season] = games.count
    end
    games_by_season
  end

  def team_names
    @all_teams.map do |team|
      team.team_name
    end.uniq
  end

  def goals_by_team_id
    goals_by_team_id = Hash.new {|h,k| h[k]=[]}
    @all_game_teams.each do |game|
      goals_by_team_id[game.team_id] << game.goals.to_i
    end
    goals_by_team_id
  end

  def avg_goals_by_team_id
    avg_goals_by_team_id = Hash.new(0)
    goals_by_team_id.each do |team_id, goals|
      avg_goals_by_team_id[team_id] = (goals.sum(0.0) / goals.length).round(2)
    end
    avg_goals_by_team_id
  end

  def team_id_to_team_name(team_id)
    @all_teams.find do |team|
      team.team_id == team_id
    end.team_name
  end

  def coaches_by_win_percentage(season)
    games_team_sorted = game_team_group_by_season(season)
    data_set_by_head_coach = games_team_sorted.group_by(&:head_coach)
    coaches_by_win_pct = Hash.new{|h,k| h[k] = 0}
    data_set_by_head_coach.each do |coach, games|
      wins = games.count { |game| game.result == "WIN"}
      total_games = games.count.to_f
      coaches_by_win_pct[coach] = ((wins / total_games)*100).round(2)
    end
    coaches_by_win_pct
  end

  def teams_by_accuracy(season)
    games_team_sorted = game_team_group_by_season(season)
    data_set_by_teams = games_team_sorted.group_by(&:team_id)
    teams_by_accuracy = Hash.new{|h,k| h[k] = 0}
    data_set_by_teams.each do |team, games|
      shots = games.reduce(0) { |total, game| total + game.shots.to_i}
      goals = games.reduce(0) { |total, game| total + game.goals.to_i}
      teams_by_accuracy[team] = (goals.to_f / shots).round(5)
    end
    teams_by_accuracy
  end

  def teams_by_tackles(season)
    games_team_sorted = game_team_group_by_season(season)
    data_set_by_teams = games_team_sorted.group_by(&:team_id)
    teams_by_tackles = Hash.new{|h,k| h[k] = 0}
    data_set_by_teams.each do |team, games|
      tackles = games.reduce(0) { |total, game| total + game.tackles.to_i}
      teams_by_tackles[team] = tackles
    end
    teams_by_tackles
  end

  def find_team(given_team_id)
    selected_team = @all_teams.select do |team|
      team.team_id == given_team_id
    end[0]
  end

  def display_team_info(selected_team)
    team_info = {
      "team_id" => selected_team.team_id,
      "franchise_id" => selected_team.franchise_id,
      "team_name" => selected_team.team_name,
      "abbreviation" => selected_team.abbreviation,
      "link" => selected_team.link
    }
  end

  def seasons_by_wins(given_team_id)
    teams_games = game_team_grouped_by_team(given_team_id)
    team_games_by_season = data_sorted_by_season(teams_games)
    seasons_by_win_percentage = Hash.new{|h,k| h[k] = 0}
    team_games_by_season.each do |season, games|
      full_season = games.first.game_id[0..3] + (games.first.game_id[0..3].to_i + 1).to_s
      wins = games.count { |game| game.result == "WIN"}
      total_games = games.count.to_f
      seasons_by_win_percentage[full_season] = (wins.to_f / total_games).round(5)
    end
    seasons_by_win_percentage
  end

  def team_wins(given_team_id)
    teams_games = game_team_grouped_by_team(given_team_id)
    wins = teams_games.count { |game| game.result == "WIN"}
  end

  def team_total_games(given_team_id)
    teams_games = game_team_grouped_by_team(given_team_id)
    total_games = teams_games.count.to_f
  end

  def goals_scored_in_game(given_team_id)
    teams_games = game_team_grouped_by_team(given_team_id)
    teams_games.map do |game|
      game.goals.to_i
    end
  end

  def games_by_opponent(team_id)
    games_by_team = @all_games.select do |game|
      game.home_team_id == team_id || game.away_team_id == team_id
    end
    games_by_team.group_by do |game|
      game.opponent_id(team_id)
    end
  end

  def win_percentage_by_opponent(team_id)
    win_percentage_by_opponent = Hash.new { |h, k| h[k] = 0 }
    games_by_opponent(team_id).each do |opponent, games|
      wins = games.count { |game| game.did_team_win?(team_id) }
      total_games = games.count
      win_percentage_by_opponent[opponent] = (wins.to_f / total_games * 100).round(2)
    end
    win_percentage_by_opponent
  end

  def home_wins_counter
    @all_games.count do |game|
      game.home_win?
    end
  end

  def visitor_wins_counter
    @all_games.count do |game|
      game.visitor_win?
    end
  end

  def tie_counter
    @all_games.count do |game|
      game.tie?
    end
  end

  def avg_goals_by_season
    avg_goals_by_season = Hash.new(0)
    goals_by_season.each do |season, goals|
      avg_goals_by_season[season] = (goals.sum(0.0) / goals.length).round(2)
    end
    avg_goals_by_season
  end

  def avg_away_team_by_goals
    avg_away_team_by_goals = Hash.new(0)
    away_team_by_goals.each do |team_id, goals|
      avg_away_team_by_goals[team_id] = (goals.sum(0.0) / goals.length).round(2)
    end
    avg_away_team_by_goals
  end

  def avg_home_team_by_goals
    avg_home_team_by_goals = Hash.new(0)
    home_team_by_goals.each do |team_id, goals|
      avg_home_team_by_goals[team_id] = (goals.sum(0.0) / goals.length).round(2)
    end
    avg_home_team_by_goals
  end
end
