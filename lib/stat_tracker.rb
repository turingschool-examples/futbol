require 'csv'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = CSV.read(locations[:games], headers:true)
    teams = CSV.read(locations[:teams], headers:true)
    game_teams = CSV.read(locations[:game_teams], headers:true)

    new(games, teams, game_teams)
  end

  def highest_total_score
    highest_score = @games.max_by do |game|
      game["away_goals"].to_i + game["home_goals"].to_i
    end
    highest_score["away_goals"].to_i + highest_score["home_goals"].to_i
  end

  def lowest_total_score
    lowest_score = @games.min_by do |game|
      game["away_goals"].to_i + game["home_goals"].to_i
    end
    lowest_score["away_goals"].to_i + lowest_score["home_goals"].to_i
  end

  def percentage_home_wins
    home_wins = @games.count do |game|
      game["home_goals"].to_i > game["away_goals"].to_i
    end
    (home_wins.to_f / games.length).round(2)
  end

  def percentage_visitor_wins
    visitor_wins = @games.count do |game|
      game["away_goals"].to_i > game["home_goals"].to_i
    end
    (visitor_wins.to_f / games.length).round(2)
  end

  def percentage_ties
    tie_games = @games.count do |game|
      game["away_goals"].to_i == game["home_goals"].to_i
    end
    (tie_games.to_f / games.length).round(2)
  end

  def count_of_games_by_season # look into group_by
    games_by_season = {}
    @games.each do |game|
      if games_by_season.keys.include?(game["season"])
        games_by_season[game["season"]] += 1
      else
        games_by_season[game["season"]] = 1
      end
    end
    games_by_season
  end

  def average_goals_per_game
    average_goals = @games.sum do |game|
      game["home_goals"].to_i + game["away_goals"].to_i
    end
    (average_goals.to_f / games.length).round(2)
  end

  def average_goals_by_season
    average_goals_season = {}
    games_by_season = count_of_games_by_season
    @games.each do |game|
      if average_goals_season.keys.include?(game["season"])
        average_goals_season[game["season"]] += (game["home_goals"].to_i + game["away_goals"].to_i)
      else
        average_goals_season[game["season"]] = (game["home_goals"].to_i + game["away_goals"].to_i)
      end
    end
    average_goals_season.map do |season, goals|
      [season, (goals.to_f / games_by_season[season].to_f).round(2)]
    end.to_h
  end

  def count_of_teams
    @teams.count
  end

  def best_offense # Theres so much we can do to refactor this
    team_ids = {}
    team_game_count = {}
    @game_teams.each do |game_team|
      if team_ids.keys.include?(game_team["team_id"])
        team_ids[game_team["team_id"]] += game_team["goals"].to_i
        team_game_count[game_team["team_id"]] += 1
      else
        team_ids[game_team["team_id"]] =  game_team["goals"].to_i
        team_game_count[game_team["team_id"]] = 1
      end
    end
    highest_scoring_team = team_ids.max_by do |team, score|
      score.to_f / team_game_count[team]
    end
    best_offense = @teams.find do |team|
      team["team_id"] == highest_scoring_team[0]
    end
    best_offense["teamName"]
  end

  def worst_offense # Theres so much we can do to refactor this
    team_ids = {}
    team_game_count = {}
    @game_teams.each do |game_team| # Refector this into a helper method
      if team_ids.keys.include?(game_team["team_id"])
        team_ids[game_team["team_id"]] += game_team["goals"].to_i
        team_game_count[game_team["team_id"]] += 1
      else
        team_ids[game_team["team_id"]] =  game_team["goals"].to_i
        team_game_count[game_team["team_id"]] = 1
      end
    end
    lowest_scoring_team = team_ids.min_by do |team, score|
      score.to_f / team_game_count[team]
    end
    worst_offense = @teams.find do |team|
      team["team_id"] == lowest_scoring_team[0]
    end
    worst_offense["teamName"]
  end

  def highest_scoring_visitor
    team_game_count = {}
    away_points = {}
    @games.each do |game|
      if away_points.key?(game["away_team_id"])
        away_points[game["away_team_id"]] += game["away_goals"].to_i
        team_game_count[game["away_team_id"]] += 1
      else
        away_points[game["away_team_id"]] = game["away_goals"].to_i
        team_game_count[game["away_team_id"]] = 1
      end
    end
    highest_scoring_visitor = away_points.max_by do |team, score|
      score.to_f / team_game_count[team]
    end
    best_away_scorer = @teams.find do |team|
      team["team_id"] == highest_scoring_visitor[0]
    end
    best_away_scorer["teamName"]
  end

  def highest_scoring_home_team
    team_game_count = {}
    home_points = {}
    @games.each do |game|
      if home_points.key?(game["home_team_id"])
        home_points[game["home_team_id"]] += game["home_goals"].to_i
        team_game_count[game["home_team_id"]] += 1
      else
        home_points[game["home_team_id"]] = game["home_goals"].to_i
        team_game_count[game["home_team_id"]] = 1
      end
    end
    highest_scoring_home_team = home_points.max_by do |team, score|
        score.to_f / team_game_count[team]
    end
    best_home_scorer = @teams.find do |team|
      team["team_id"] == highest_scoring_home_team[0]
    end
    best_home_scorer["teamName"]
  end

  def lowest_scoring_visitor
    team_game_count = {}
    away_points = {}
    @games.each do |game|
      if away_points.key?(game["away_team_id"])
        away_points[game["away_team_id"]] += game["away_goals"].to_i
        team_game_count[game["away_team_id"]] += 1
      else
        away_points[game["away_team_id"]] = game["away_goals"].to_i
        team_game_count[game["away_team_id"]] = 1
      end
    end
    lowest_scoring_visitor = away_points.min_by do |team, score|
        score.to_f / team_game_count[team]
    end
    worst_away_scorer = @teams.find do |team|
      team["team_id"] == lowest_scoring_visitor[0]
    end
    worst_away_scorer["teamName"]
  end

  def lowest_scoring_home_team
    team_game_count = {}
    home_points = {}
    @games.each do |game|
      if home_points.key?(game["home_team_id"])
        home_points[game["home_team_id"]] += game["home_goals"].to_i
        team_game_count[game["home_team_id"]] += 1
      else
        home_points[game["home_team_id"]] = game["home_goals"].to_i
        team_game_count[game["home_team_id"]] = 1
      end
    end
    lowest_scoring_home_team = home_points.min_by do |team, score|
        score.to_f / team_game_count[team]
    end
    worst_home_scorer = @teams.find do |team|
      team["team_id"] == lowest_scoring_home_team[0]
    end
    worst_home_scorer["teamName"]
  end

  def winningest_coach(season)
    coach_game_count = Hash.new(0)
    coach_wins = Hash.new(0.0)
    games_in_season = @games.select do |game|
      game["season"] == season
    end
    game_ids = games_in_season.map do |game|
      game["game_id"]
    end
    @game_teams.each do |game|
      if game_ids.include?(game["game_id"])
        coach_game_count[game["head_coach"]] += 1
        if game["result"] == "WIN"
          coach_wins[game["head_coach"]] += 1
        end
      end
    end
    coach_wins.max_by do |coach, win|
      win / coach_game_count[coach]
    end[0]
  end

  def worst_coach(season)
    coach_game_count = Hash.new(0)
    coach_losses = Hash.new(0.0)
    games_in_season = @games.select do |game|
      game["season"] == season
    end
    game_ids = games_in_season.map do |game|
      game["game_id"]
    end
    @game_teams.each do |game|
      if game_ids.include?(game["game_id"])
        coach_game_count[game["head_coach"]] += 1
        if game["result"] == "LOSS" || game["result"] == "TIE"
          coach_losses[game["head_coach"]] += 1
        end
      end
    end
    coach_losses.max_by do |coach, loss|
      loss / coach_game_count[coach]
    end[0]
  end

  def most_accurate_team(season)
    total_shots_by_team = Hash.new(0.0)
    total_goals_by_team = Hash.new(0.0)
    games_in_season = @games.select do |game|
      game["season"] == season
    end
    game_ids = games_in_season.map do |game|
      game["game_id"]
    end
    @game_teams.each do |game|
      if game_ids.include?(game["game_id"])
        total_shots_by_team[game["team_id"]] += game["shots"].to_f
        total_goals_by_team[game["team_id"]] += game["goals"].to_f
      end
    end
    most_accurate_team = total_goals_by_team.max_by do |team, goal|
      goal / total_shots_by_team[team]
    end[0]
    most_accurate_team_name = @teams.find do |team|
      team["team_id"] == most_accurate_team
    end
    most_accurate_team_name["teamName"]
  end

  def least_accurate_team(season)
    total_shots_by_team = Hash.new(0.0)
    total_goals_by_team = Hash.new(0.0)
    games_in_season = @games.select do |game|
      game["season"] == season
    end
    game_ids = games_in_season.map do |game|
      game["game_id"]
    end
    @game_teams.each do |game|
      if game_ids.include?(game["game_id"])
        total_shots_by_team[game["team_id"]] += game["shots"].to_f
        total_goals_by_team[game["team_id"]] += game["goals"].to_f
      end
    end
    least_accurate_team = total_goals_by_team.min_by do |team, goal|
      goal / total_shots_by_team[team]
    end[0]
    least_accurate_team_name = @teams.find do |team|
      team["team_id"] == least_accurate_team
    end
    least_accurate_team_name["teamName"]
  end

  def most_tackles(season)
    team_tackles = Hash.new(0)
    games_in_season = @games.select do |game|
      game["season"] == season
    end
    game_ids = games_in_season.map do |game|
      game["game_id"]
    end
    @game_teams.each do |game|
      if game_ids.include?(game["game_id"])
        team_tackles[game["team_id"]] += game["tackles"].to_i
      end
    end
    most_tackles_team = team_tackles.max_by do |team, tackles|
      tackles
    end[0]
    most_tackles_team_name = @teams.find do |team|
      team["team_id"] == most_tackles_team
    end
    most_tackles_team_name["teamName"]
  end

  def fewest_tackles(season)
    team_tackles = Hash.new(0)
    games_in_season = @games.select do |game|
      game["season"] == season
    end
    game_ids = games_in_season.map do |game|
      game["game_id"]
    end
    @game_teams.each do |game|
      if game_ids.include?(game["game_id"])
        team_tackles[game["team_id"]] += game["tackles"].to_i
      end
    end
    fewest_tackles_team = team_tackles.min_by do |team, tackles|
      tackles
    end[0]
    fewest_tackles_team_name = @teams.find do |team|
      team["team_id"] == fewest_tackles_team
    end
    fewest_tackles_team_name["teamName"]
  end
  
  def team_info(team_id)
    team_table = @teams.find do |team|
      team_id == team["team_id"]
    end
    info_hash = team_table.to_h.slice("team_id", "franchiseId", "teamName", "abbreviation", "link")
    info_hash["franchise_id"] = info_hash.delete("franchiseId")
    info_hash["team_name"] = info_hash.delete("teamName")
    info_hash
  end

  def best_season(team_id)
    wins_by_season = Hash.new(0.0)
    games_by_season = Hash.new { |hash, key| hash[key] = [] }
    @games.each do |game|
      if game["home_team_id"] == team_id || game["away_team_id"] == team_id
        games_by_season[game["season"]] << game
      end
    end
    games_by_season.each do |season, games|
      games.each do |game|
        if game["home_team_id"] == team_id && game["home_goals"].to_i > game["away_goals"].to_i
          wins_by_season[season] += 1
        elsif game["away_team_id"] == team_id && game["away_goals"].to_i > game["home_goals"].to_i
          wins_by_season[season] += 1
        end
      end
    end
    games_by_season.max_by do |season, games|
      wins_by_season[season] / games.length
    end[0]
  end

  def worst_season(team_id)
    wins_by_season = Hash.new(0.0)
    games_by_season = Hash.new { |hash, key| hash[key] = [] }
    @games.each do |game|
      if game["home_team_id"] == team_id || game["away_team_id"] == team_id
        games_by_season[game["season"]] << game
      end
    end
    games_by_season.each do |season, games|
      games.each do |game|
        if game["home_team_id"] == team_id && game["home_goals"].to_i > game["away_goals"].to_i
          wins_by_season[season] += 1
        elsif game["away_team_id"] == team_id && game["away_goals"].to_i > game["home_goals"].to_i
          wins_by_season[season] += 1
        end
      end
    end
    games_by_season.min_by do |season, games|
      wins_by_season[season] / games.length
    end[0]
  end
end
