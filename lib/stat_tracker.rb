require "CSV"
require "./lib/games"
require "./lib/teams"
require "./lib/game_teams"

class StatTracker
  attr_reader :games, :game_teams, :teams

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def initialize(locations)
    @games ||= turn_games_csv_data_into_games_objects(locations[:games])
    @teams ||= turn_teams_csv_data_into_teams_objects(locations[:teams])
    @game_teams ||= turn_game_teams_csv_data_into_game_teams_objects(locations[:game_teams])
  end

  def turn_games_csv_data_into_games_objects(games_csv_data)
    games_objects_collection = []
    CSV.foreach(games_csv_data, headers: true, header_converters: :symbol, row_sep: :auto) do |row|
      games_objects_collection << Games.new(row)
    end
    games_objects_collection
  end

  def turn_teams_csv_data_into_teams_objects(teams_csv_data)
    teams_objects_collection = []
    CSV.foreach(teams_csv_data, headers: true, header_converters: :symbol, row_sep: :auto) do |row|
      teams_objects_collection << Teams.new(row)
    end
    teams_objects_collection
  end

  def turn_game_teams_csv_data_into_game_teams_objects(game_teams_csv_data)
    game_teams_objects_collection = []
    CSV.foreach(game_teams_csv_data, headers: true, header_converters: :symbol, row_sep: :auto) do |row|
      game_teams_objects_collection << GameTeams.new(row)
    end
    game_teams_objects_collection
  end

  def highest_total_score
    output = @games.max_by do |game|
      game.away_goals + game.home_goals
    end
    output.away_goals + output.home_goals
  end

  def lowest_total_score
    output = @games.min_by do |game|
      game.away_goals + game.home_goals
    end
    output.away_goals + output.home_goals
  end

  def average_goals_per_game
    games_count = @games.count.to_f
    sum_of_goals = (@games.map {|game| game.home_goals + game.away_goals}.to_a).sum
    sum_of_goals_divided_by_game_count = (sum_of_goals / games_count).round(2)
    sum_of_goals_divided_by_game_count
  end

  def average_goals_by_season
    games_by_season = @games.group_by {|game| game.season}
    goals_per_season = {}
    games_by_season.map do |season, games|
      goals_per_season[season] = games.sum do |game|
        game.away_goals + game.home_goals
      end
    end
    avg_goals_per_season = {}
    goals_per_season.each do |season, goals|
      division = (goals.to_f / count_of_games_by_season[season] ).round(2)
      avg_goals_per_season[season] = division
    end
    avg_goals_per_season
  end

  def percentage_home_wins
    home_games = @game_teams.select do |game|
      game.hoa == "home"
    end
    home_wins = @game_teams.select do |game|
      game.result == "WIN" && game.hoa == "home"
    end
    (home_wins.count / home_games.count.to_f).round(2)
  end

  def percentage_visitor_wins
    total_visitor_wins = @games.select do |game|
      game.away_goals > game.home_goals
    end
    (total_visitor_wins.length.to_f / @games.length).round(2)
  end

  def percentage_ties
    game_ties = @game_teams.select do |game|
        game.result == "TIE"
    end
    (game_ties.count / @game_teams.count.to_f).round(2)
  end

  def count_of_games_by_season
    games_by_season = @games.group_by {|game| game.season}
    game_count_per_season = {}
    games_by_season.map {|season, game| game_count_per_season[season] = game.count}
    game_count_per_season
  end

  def count_of_teams
    teams.count
  end

  def home_team
    home_team = @games.group_by do |game|
      game.home_team_id
    end
  end

  def goals
    goals = {}
    home_team.each do |team_id, games|
      goal_count = 0
      games.each do |game|
        goal_count += game.home_goals
      end
      average_goals = goal_count / games.count.to_f
      goals[team_id] = average_goals
    end
    goals
  end

  def highest_scoring_home_team
    goals #WE CAN DELETE THIS
    id = goals.max_by {|key, value| value}
      @teams.find {|team| team.team_id == id[0]}.teamname
  end

  def total_goals_by_away_team
    away_goals = Hash.new{0}
    @games.sum do |game|
      away_goals[game.away_team_id] += game.away_goals
    end
    away_goals
  end

  def away_teams_game_count_by_team_id
    games_by_team_id = @games.reduce(Hash.new { |h,k| h[k]=[] }) do |result, game|
      result[game.away_team_id] << game.game_id
      result
    end
    games_count_by_team_id = {}
    games_by_team_id.each do |team_id, games_array|
      games_count_by_team_id[team_id] = games_array.count
    end
    games_count_by_team_id
  end

  def highest_total_goals_by_away_team
    total_goals_by_away_team.max_by do |team_id, total_goals|
      total_goals
    end
  end

  def overall_average_scores_by_away_team
    team_id = total_goals_by_away_team.keys
    total_away_goals = total_goals_by_away_team.values
    total_away_games = away_teams_game_count_by_team_id.values
    teams_away_goals_and_total_games = team_id.zip(total_away_goals, total_away_games)
    over_all_average_by_team = {}
    teams_away_goals_and_total_games.each do |team_id, total_away_goals, total_away_games|
      over_all_average_by_team[team_id] = total_away_goals.to_f/total_away_games
    end
    over_all_average_by_team
  end

  def highest_total_goals_by_away_team
    total_goals_by_away_team.max_by do |team_id, total_goals|
      total_goals
    end
  end

  def team_by_id
    team_by_id = @game_teams.group_by do |team|
      team.team_id
    end
  end

  def total_games_by_id
    total_games_by_id = {}
    team_by_id.map { |id, games| total_games_by_id[id] = games.length}
    total_games_by_id
  end

  def total_goals_by_id
    total_goals_by_id = {}
    team_by_id.map { |id, games| total_goals_by_id[id] = games.sum {|game| game.goals}}
    total_goals_by_id
  end

  def average_goals_all_seasons_by_id
    average_goals_all_seasons_by_id = {}
    total_goals_by_id.each do |id, goals|
      average_goals_all_seasons_by_id[id] = (goals.to_f / total_games_by_id[id] ).round(2)
    end
    average_goals_all_seasons_by_id
  end

  def best_offense
    team_by_id
    total_games_by_id
    total_goals_by_id
    average_goals_all_seasons_by_id
    highest = average_goals_all_seasons_by_id.max_by {|id, avg| avg}
    best_offense = @teams.find {|team| team.teamname if team.team_id == highest[0]}.teamname
    best_offense
  end

  def worst_offense
    team_by_id
    total_games_by_id
    total_goals_by_id
    average_goals_all_seasons_by_id
    lowest = average_goals_all_seasons_by_id.min_by {|id, avg| avg}
    worst_offense = @teams.find {|team| team.teamname if team.team_id == lowest[0]}.teamname
    worst_offense
  end

  def scoped_season_games(season)
    @games.find_all {|game| game.season == season}
  end

  def games_teams_by_seasons_per_coach(season_id)
    scoped_season_games(season_id).map do |game|
      @game_teams.find_all do |game_team|
        game_team.game_id == game.game_id
      end
    end.flatten.group_by(&:head_coach)
  end

  def coach_name_and_results(season)
    output = {}
    games_teams_by_seasons_per_coach(season).map do |coach, game_teams|
      game_teams.map do |game_team|
        output[coach] ? output[coach] += [game_team.result] : output[coach] = [game_team.result]
      end
    end
    output
  end

  def coach_result_percentage(season, flag)
    coach_name_and_results(season).max_by do |coach, results|
      win_count = results.find_all { |result| result == flag}.size
      result_sum =  results.size
      (win_count * 100) / result_sum
    end.first
  end

  def winningest_coach(season)
    coach_result_percentage(season, "WIN")
  end

  def worst_coach(season)
    coach_result_percentage(season, "LOSS")
  end

  def team_info(team_id)
    team_info = {}
    team = @teams.find {|team| team.team_id == team_id}
    franchise_id = team.franchiseid
    team_name = team.teamname
    abbreviation = team.abbreviation
    link = team.link
    team_info["team_id"] = team.team_id
    team_info["franchise_id"] = team.franchiseid
    team_info["team_name"] = team.teamname
    team_info["abbreviation"] = team.abbreviation
    team_info["link"] = team.link
    team_info
  end

  def average_win_percentage(team_id)
    team_games = @game_teams.find_all {|team| team.team_id == team_id}
    team_games_count = team_games.count
    team_total_wins = team_games.find_all {|game| game.result == "WIN"}.count
    team_average_win_percentage = (team_total_wins / team_games_count.to_f).round(2)
    team_average_win_percentage
  end

  def games_per_season_per_team(seasonID)
    games_in_season = @games.select { |game| game.season == seasonID }
    game_ids_in_season = games_in_season.map do |game|
      game.game_id
    end
    game_teams_in_season = @game_teams.select do |game_team|
      game_ids_in_season.include?(game_team.game_id)
    end
    games_per_season_per_team = game_teams_in_season.group_by do |game|
      game.team_id
    end
  end

  def team_accuracy(seasonID)
    team_accuracy = Hash.new(0)
    games_per_season_per_team(seasonID).each do |team, games|
      shots = 0
      goals = 0
      games.each do |game|
        shots = games.sum {|game| game.shots}
        goals = games.sum {|game| game.goals}
      end
    team_accuracy[team] = (goals.to_f / shots)
    end
    team_accuracy
  end

  def most_accurate_team(seasonID)
    games_per_season_per_team(seasonID)
    team_accuracy(seasonID)
    best_team = team_accuracy(seasonID).max_by {|team_id, accuracy| accuracy}
    @teams.find {|team| team.team_id == best_team[0]}.teamname
  end

  def least_accurate_team(seasonID)
    games_per_season_per_team(seasonID)
    team_accuracy(seasonID)
    worst_team = team_accuracy(seasonID).min_by {|team_id, accuracy| accuracy}
    @teams.find {|team| team.team_id == worst_team[0]}.teamname
  end

  def games_by_team(team_id)
    games_by_team = @game_teams.select do |game_team|
      game_team.team_id == team_id
    end
    games_by_team
  end

  def team_goals(team_id)
    games_by_team(team_id)
    team_goals = games_by_team(team_id).group_by do |game_team|
      game_team.goals
    end
    team_goals
  end

  def most_goals_scored(team_id)
    games_by_team(team_id)
    team_goals(team_id)
    most_goals = team_goals(team_id).max_by {|goals, game_team| goals}
    most_goals[0]
  end

  def fewest_goals_scored(team_id)
    games_by_team(team_id)
    team_goals(team_id)
    fewest_goals = team_goals(team_id).min_by {|goals, game_team| goals}
    fewest_goals[0]
  end

  def games_by_season
    games_by_season = @games.group_by {|game| game.season}
  end

  def highest_scoring_visitor
    best_team = overall_average_scores_by_away_team.max_by do |team_id, average_goals|
        average_goals
    end
    @teams.find do |team|
      team.team_id == best_team[0]
    end.teamname
  end

  def lowest_scoring_visitor
    worst_team = overall_average_scores_by_away_team.min_by do |team_id, average_goals|
      average_goals
    end
    @teams.find do |team|
      team.team_id == worst_team[0]
    end.teamname
  end

  def lowest_scoring_home_team
    goals
    id = goals.min_by {|team, num_of_goals| num_of_goals}
    @teams.find {|team| team.team_id == id[0]}.teamname
  end

  def season_hash
    season_hash = @games.group_by {|games| games.season}
  end

  def game_ids_by_season
    game_ids_by_season = {}
    season_hash.map do |season, games|
      game_ids_by_season[season] = games.map {|game| game.game_id}
    end
    game_ids_by_season
  end

  def season_games
    season_games = games_by_season.map {|season, games| games}.flatten.compact
  end

 #========== Best & Worst season ==========
  def team_games_per_season(teamID)
    games_by_team = season_games.select {|team| team.team_id == teamID}
    team_games_per_season = games_by_team.group_by {|game| game.game_id[0..3]}
  end

  def win_hash(teamID)
    @win_count = Hash.new(0)
    team_games_per_season(teamID).each do |season, games|
      count = 0
      total = 0
      games.each do |game|
          if game.result == "WIN"
            count += 1
            total += 1
          else
            total += 1
          end
      @win_count[season] = [count, total]
      end
      @win_count
    end
  end

  def best_season(teamID)
    win_hash(teamID)
    best = @win_count.max_by do |season, games|
      @win_count[season].first / @win_count[season].last.to_f
    end
    math = best[0].to_i
    math += 1
    math.to_s
    answer = best.first + "#{math}"
  end#method

  def worst_season(teamID)
    win_hash(teamID)
    worst = @win_count.min_by do |season, games|
      @win_count[season].first / @win_count[season].last.to_f
    end
    math = worst[0].to_i
    math += 1
    math.to_s
    answer = worst.first + "#{math}"
  end#method


  def games_won_by_team(team_id)
    games_won_against_opp = Hash.new(0)
    @games.each do |game|
      games_won_against_opp[game.home_team_id] += 1 if ((game.away_team_id == team_id) && (game.away_goals > game.home_goals))
      games_won_against_opp[game.away_team_id] +=1 if ((game.home_team_id == team_id) && (game.home_goals > game.away_goals))
    end
    games_won_against_opp
  end

  def opponents_of(team_id)
    opponents = Hash.new(0)
    @games.each do |game|
      opponents[game.home_team_id] += 1 if game.away_team_id == team_id
      opponents[game.away_team_id] += 1 if game.home_team_id == team_id
    end
    opponents
  end

  def find_team_name(team_id)
    @teams.find do |team|
      team.team_id == team_id
    end.teamname
  end

  def average_win_percentage_by_opponents_of(team_id)
    average_win_percentage = {}
    games_won_by_team(team_id).each do |opp_team_id, games_won|
      opponents_of(team_id).each do |opp_team_id2, games_played|
        if opp_team_id == opp_team_id2
          average_win_percentage[opp_team_id] = games_won.to_f / games_played
        end
      end
    end
    average_win_percentage
  end

  def favorite_opponent(team_id)
  fav_opp = average_win_percentage_by_opponents_of(team_id).max_by do |opp_id, win_percent|
      win_percent
    end
    find_team_name(fav_opp[0])
  end

  def season_games
    season_games = games_by_season.map {|season, games| games}.flatten.compact
  end

  def team_tackles(seasonID)
    team_tackles = Hash.new(0)
    games_per_season_per_team(seasonID).each do |team, games|
      games.each do |game|
        team_tackles[game.team_id] += game.tackles
      end
    end
    team_tackles
  end

  def fewest_tackles(seasonID)
    games_per_season_per_team(seasonID)
    team_tackles(seasonID)
    fewest = team_tackles(seasonID).min_by {|k, v| v}
    @teams.find {|team| team.team_id == fewest.first}.teamname
  end#tackle method

  def most_tackles(seasonID)
    games_per_season_per_team(seasonID)
    team_tackles(seasonID)
    most = team_tackles(seasonID).max_by {|k, v| v}
    @teams.find {|team| team.team_id == most.first}.teamname
  end#tackle method

  def rival(team_id)
    not_fav_opp = average_win_percentage_by_opponents_of(team_id).min_by do |opp_id, win_percent|
      win_percent
    end
    find_team_name(not_fav_opp[0])
  end

end#class
