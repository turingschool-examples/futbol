require_relative "./helper"

require "csv"
require_relative "./game_collection"
require_relative "./team_collection"
require_relative "./game_team_collection"
require_relative "./team"

class StatTracker

  def initialize(location)
    @games = GameCollection.new(location[:games])
    @teams = TeamCollection.new(location[:teams])
    @game_teams = GameTeamCollection.new(location[:game_teams])
  end
  def self.from_csv(location)
    StatTracker.new(location)
  end

  def games
    @g ||= @games.all
  end

  def teams
    @t ||= @teams.all
  end

  def game_teams
    @g_t ||= @game_teams.all
  end

  def all_games_per_season(season_id)
    games.select do |game|
      game.season.eql?(season_id)
    end
  end

  def all_game_teams_per_season(season_id)
    game_ids_per_season = all_games_per_season(season_id).group_by {|game| game.game_id}.keys
    game_teams.select do |game_team|
      game_ids_per_season.include?(game_team.game_id)
    end
  end

  def games_by_head_coach(season_id)
    all_game_teams_per_season(season_id).group_by do |game_team|
      game_team.head_coach
    end
  end

  def coach_per_total_win(season_id)
    games_by_head_coach(season_id).transform_values do |games|
      winning_games = games.select{|game| game.result == "WIN"}
      winning_games.size
    end
  end

  def winningest_coach(season_id)
    highest_coach = coach_per_total_win(season_id).max_by do |coach, total_winning_games|
      total_winning_games
    end
    highest_coach.first
  end

  def worst_coach(season_id)
    lowest_coach = coach_per_total_win(season_id).min_by do |coach, total_winning_games|
      total_winning_games
    end
    lowest_coach.first
  end

  def team_id_group(season_id)
    all_game_teams_per_season(season_id).group_by do |game_team|
      game_team.team_id
    end
  end

  def ratio_of_shots(season_id)
    team_id_group(season_id).transform_values do |games|
      total_shots = games.sum{|game| game.shots.to_f}
      total_goals = games.sum{|game| game.goals.to_f}
       (total_goals/total_shots *100).round(2)
    end
  end

  def best_accurate_team_id(season_id)
    max = ratio_of_shots(season_id).max_by{|team_id, ratio| ratio}
    max.first
  end

  def least_accurate_team_id(season_id)
    min = ratio_of_shots(season_id).min_by{|team_id, ratio| ratio}
    min.first
  end

  def highest_total_score
    games.max_by do |game|
      game.total_goals
    end.total_goals
  end

  def lowest_total_score
    games.min_by do |game|
      game.total_goals
    end.total_goals
  end

  def percentage_home_wins
    home_win_total = games.count do |game|
      game.home_goals > game.away_goals
    end.to_f
    (home_win_total / games.count).round(2)
  end

  def percentage_visitor_wins
    away_win_total = games.count do |game|
       game.away_goals > game.home_goals
    end.to_f
    (away_win_total / games.count).round(2)
  end

  def percentage_ties
    tie_total = games.count do |game|
      game.home_goals == game.away_goals
    end.to_f
    (tie_total / games.count).round(2)
  end

  def count_of_games_by_season
    games.reduce(Hash.new(0)) do |hash, game|
      hash[game.season] += 1
      hash
    end
  end

  def average_goals_per_game
    all_goals = 0.00
    games.each do |game|
      all_goals += game.home_goals
      all_goals += game.away_goals
    end
    (all_goals / games.count).round(2)
  end

  def average_goals_by_season
    goals = games.reduce(Hash.new(0)) do |hash, game|
      hash[game.season] += game.total_goals
      hash
    end
    goals.merge(count_of_games_by_season) do |season, goal_count, game_count|
      ((goal_count.to_f) / (game_count.to_f)).round(2)
    end
  end

  def most_accurate_team(season_id)
    team_f = find_team_by_id(best_accurate_team_id(season_id))
    team_f.team_name
  end

  def least_accurate_team(season_id)
    team_f = find_team_by_id(least_accurate_team_id(season_id))
    team_f.team_name
  end

  def total_tackles_team_per_season(season_id)
    team_id_group(season_id).transform_values do |games|
      games.sum{|game| game.tackles.to_i}
    end
  end

  def get_team_name_with_id(id)
    team_f = find_team_by_id(id)
    team_f.team_name
  end

  def most_tackles(season_id)
    max_id = total_tackles_team_per_season(season_id).max_by do |key, value|
       value
    end.first
    get_team_name_with_id(max_id)
  end

  def fewest_tackles(season_id)
    min_id = total_tackles_team_per_season(season_id).min_by do |key, value|
       value
    end.first
    get_team_name_with_id(min_id)
  end


  def count_of_teams
    teams.count
  end

  def scores_by_team
    game_teams.reduce({}) do |team_scores, game|
      if team_scores[game.team_id].nil?
        team_scores[game.team_id] = [game.goals.to_i]
      else
        team_scores[game.team_id] << game.goals.to_i
      end
      team_scores
    end
  end

  def average_scores_by_team
    average_scores_by_team = {}
    scores_by_team.each do |team, scores|
      average_scores_by_team[team] = (scores.sum / scores.count.to_f)
    end
    average_scores_by_team
  end

  def best_offense
    highest_average_score = average_scores_by_team.max_by do |team, average_score|
      average_score
    end
    find_team_by_id(highest_average_score.first).team_name
  end

  def worst_offense
    lowest_average_score = average_scores_by_team.min_by do |team, average_score|
      average_score
    end
    find_team_by_id(lowest_average_score.first).team_name
  end

  def scores_by_away_team
    games.reduce({}) do |team_scores, game|
      if team_scores[game.away_team_id].nil?
        team_scores[game.away_team_id] = [game.away_goals.to_i]
      else
        team_scores[game.away_team_id] << game.away_goals.to_i
      end
      team_scores
    end
  end

  def average_scores_by_away_team
    average_scores_by_away_team = {}
    scores_by_away_team.each do |team, scores|
      average_scores_by_away_team[team] = (scores.sum / scores.count.to_f)
    end
    average_scores_by_away_team
  end

  def highest_scoring_visitor
    highest_average_score = average_scores_by_away_team.max_by do |team, average_score|
      average_score
    end
    find_team_by_id(highest_average_score.first).team_name
  end

  def lowest_scoring_visitor
    lowest_average_score = average_scores_by_away_team.min_by do |team, average_score|
      average_score
    end
    find_team_by_id(lowest_average_score.first).team_name
  end

  def scores_by_home_team
    games.reduce({}) do |team_scores, game|
      if team_scores[game.home_team_id].nil?
        team_scores[game.home_team_id] = [game.home_goals.to_i]
      else
        team_scores[game.home_team_id] << game.home_goals.to_i
      end
      team_scores
    end
  end

  def average_scores_by_home_team
    average_scores_by_home_team = {}
    scores_by_home_team.each do |team, scores|
      average_scores_by_home_team[team] = (scores.sum / scores.count.to_f)
    end
    average_scores_by_home_team
  end

  def highest_scoring_home_team
    highest_average_score = average_scores_by_home_team.max_by do |team, average_score|
      average_score
    end
    find_team_by_id(highest_average_score.first).team_name
  end

  def lowest_scoring_home_team
    lowest_average_score = average_scores_by_home_team.min_by do |team, average_score|
      average_score
    end
    find_team_by_id(lowest_average_score.first).team_name
  end

  def team_info(team_id)
    return_hash = {}
    teams.each do |team|
      if team.team_id == team_id.to_s
        return_hash = team.to_hash
      end
    end
    return_hash
  end

  def game_teams_array(team_id)
    game_teams.select do |game_team|
      game_team.team_id == team_id.to_s
    end
  end

  def games_array(team_id)
    games.select do |game|
      game.home_team_id == team_id.to_s || game.away_team_id == team_id.to_s
    end
  end

  def combine_arrays(team_id)
    combined_array = []
    games_array(team_id).each do |game|
      game_teams_array(team_id).each do |game_team|
          combined_array << [game_team.game_id, game_team.result, game.season] if game_team.game_id == game.game_id
      end
    end
    combined_array
  end

  def find_seasons(team_id)
    win_hash = Hash.new(0)
    loss_hash = Hash.new(0)
    tie_hash = Hash.new(0)
    combine_arrays(team_id).each do |array|
      win_hash[array[2]] += 1 if array[1] == "WIN"
      loss_hash[array[2]] += 1 if array[1] == "LOSS"
      tie_hash[array[2]] += 1 if array[1] == "TIE"
    end
    win_hash = win_hash.sort.to_h
    loss_hash = loss_hash.sort.to_h
    tie_hash = tie_hash.sort.to_h
    win_hash_values = win_hash.values
    loss_hash_values = loss_hash.values
    tie_hash_values = tie_hash.values
    team_season = []
    win_hash.size.times do |x|
      team_season[x] = ((win_hash_values[x]).to_f / (win_hash_values[x] +
        loss_hash_values[x] + tie_hash_values[x]))
    end
    [win_hash, team_season]
  end

  def best_season(team_id)
    find_seasons(team_id)[0].to_a[find_seasons(team_id)[1].index(find_seasons(team_id)[1].max)][0]
  end

  def worst_season(team_id)
    find_seasons(team_id)[0].to_a[find_seasons(team_id)[1].index(find_seasons(team_id)[1].min)][0]
  end

  def average_win_percentage(team_id)
    total = find_seasons(team_id)[1].inject(:+)
    len = find_seasons(team_id)[1].length
    average = (total.to_f / len).round(2)
  end

  def most_goals_scored(team_id)
    game_teams_array(team_id).max_by do |game|
      game.goals
    end.goals.to_i
  end

  def fewest_goals_scored(team_id)
    game_teams_array(team_id).min_by do |game|
      game.goals
    end.goals.to_i
  end

  def find_team_by_id(team_id)
    teams.find {|team| team.team_id == team_id}
  end

  def games_played_by_team(team_id)
    game_teams.find_all {|game| game.team_id == team_id.to_s}
  end

  def games_by_opponent_team(team_id)
    x = games_played_by_team(team_id).group_by{|game| game.game_id}
    games = game_teams.select do |game|
       key = x.keys
       key.include?(game.game_id) && !x.values.flatten.include?(game)
    end
    games.group_by{|game| game.team_id}
  end

  def opponent_percentage_wins(team_id)
    games_by_opponent_team(team_id).transform_values do |games|
      wins = games.select{|game| game.result == "WIN"}.length
      (wins / games.size.to_f * 100).round(2)
    end
  end

  def favorite_opponent(team_id)
    id =opponent_percentage_wins(team_id).min_by{|k,v| v}.first
    find_team_by_id(id).team_name
  end

  def rival(team_id)
    id =opponent_percentage_wins(team_id).max_by{|k,v| v}.first
    find_team_by_id(id).team_name
  end

end
