require 'csv'

class StatTracker
  attr_reader :games,
              :teams,
              :game_teams

  def initialize(games, teams, game_teams, locations)
    @games = games
    @teams = teams
    @game_teams = game_teams
    @game_manager = GameManager.new(locations[:games], self)
    @game_team_manager = GameTeamManager.new(locations[:game_teams], self)
    @team_manager = TeamManager.new(locations[:teams], self)
  end

  def self.from_csv(locations)
    games = CSV.read(locations[:games], headers:true)
    teams = CSV.read(locations[:teams], headers:true)
    game_teams = CSV.read(locations[:game_teams], headers:true)

    new(games, teams, game_teams, locations)
  end

  def highest_total_score # runs through game_manager.rb
    highest_score = @games.max_by do |game|
      game["away_goals"].to_i + game["home_goals"].to_i
    end
    highest_score["away_goals"].to_i + highest_score["home_goals"].to_i
  end

  def lowest_total_score # game_manager.rb
    lowest_score = @games.min_by do |game|
      game["away_goals"].to_i + game["home_goals"].to_i
    end
    lowest_score["away_goals"].to_i + lowest_score["home_goals"].to_i
  end

  def percentage_home_wins # game_manager.rb
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
    games_by_season = Hash.new(0)
    @games.each do |game|
      games_by_season[game["season"]] += 1
    end
    games_by_season
  end

  def average_goals_per_game
    average_goals = @games.sum do |game|
      game["home_goals"].to_i + game["away_goals"].to_i
    end
    (average_goals.to_f / games.length).round(2)
  end

  def average_goals_by_season # game_manager.rb
    average_goals_season = Hash.new(0)
    games_by_season = count_of_games_by_season
    @games.each do |game|
      average_goals_season[game["season"]] += (game["home_goals"].to_i + game["away_goals"].to_i)
    end
    average_goals_season.map do |season, goals|
      [season, (goals.to_f / games_by_season[season].to_f).round(2)]
    end.to_h
  end

  def count_of_teams # team_manager.rb
    @team_manager.count_of_teams
  end

  def best_offense # Theres so much we can do to refactor this
    team_ids = Hash.new(0)
    team_game_count = Hash.new(0)
    @game_teams.each do |game_team| # game_teams_manager.rb
      team_ids[game_team["team_id"]] += game_team["goals"].to_i
      team_game_count[game_team["team_id"]] += 1
    end
    highest_scoring_team = team_ids.max_by do |team, score|
      score.to_f / team_game_count[team]
    end
    best_offense = @teams.find do |team| # Create find_team_name method? # team_manager.rb
      team["team_id"] == highest_scoring_team[0] # Would accept this as argument
    end
    best_offense["teamName"]
  end

  def worst_offense # Theres so much we can do to refactor this
    team_ids = Hash.new(0)
    team_game_count = Hash.new(0)
    @game_teams.each do |game_team| # Refector this into a helper method # game_team_manager.rb
      team_ids[game_team["team_id"]] += game_team["goals"].to_i
      team_game_count[game_team["team_id"]] += 1
    end
    lowest_scoring_team = team_ids.min_by do |team, score|
      score.to_f / team_game_count[team]
    end
    worst_offense = @teams.find do |team| # team_manager.rb
      team["team_id"] == lowest_scoring_team[0]
    end
    worst_offense["teamName"]
  end

  def highest_scoring_visitor
    team_game_count = Hash.new(0)
    away_points = Hash.new(0)
    @games.each do |game|
      away_points[game["away_team_id"]] += game["away_goals"].to_i
      team_game_count[game["away_team_id"]] += 1
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
    team_game_count = Hash.new(0)
    home_points = Hash.new(0)
    @games.each do |game|
      home_points[game["home_team_id"]] += game["home_goals"].to_i
      team_game_count[game["home_team_id"]] += 1
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
    team_game_count = Hash.new(0)
    away_points = Hash.new(0)
    @games.each do |game|
      away_points[game["away_team_id"]] += game["away_goals"].to_i
      team_game_count[game["away_team_id"]] += 1
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
    team_game_count = Hash.new(0)
    home_points = Hash.new(0)
    @games.each do |game|
      home_points[game["home_team_id"]] += game["home_goals"].to_i
      team_game_count[game["home_team_id"]] += 1
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
    coach_wins.max_by do |coach, win| # Perhaps a get_max_of(coach_wins)
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
    @team_manager.team_info(team_id)
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

  def average_win_percentage(team_id)
    team_game_count = Hash.new(0)
    team_wins = Hash.new(0)
    @game_teams.each do |game|
      if game["team_id"] == team_id
        team_game_count[game["team_id"]] += 1
        if game["result"] == "WIN"
          team_wins[game["team_id"]] += 1
        end
      end
    end
    (team_wins[team_id].to_f / team_game_count[team_id]).round(2)
  end

  def most_goals_scored(team_id)
    max_goals = @game_teams.find_all do |game|
      game["team_id"] == team_id
    end
    high_goals = max_goals.max_by do |game|
      game["goals"]
    end
    high_goals["goals"].to_i
  end

  def fewest_goals_scored(team_id)
    min_goals = @game_teams.find_all do |game|
      game["team_id"] == team_id
    end
    low_goals = min_goals.min_by do |game|
      game["goals"]
    end
    low_goals["goals"].to_i
  end

  def favorite_opponent(team_id)
    games = @game_teams.find_all do |game|
      game["team_id"] == team_id
    end
    game_ids = games.map do |game|
      game["game_id"]
    end
    total_games = Hash.new(0)
    loser_loses = Hash.new(0)
    @game_teams.each do |game|
      if game_ids.include?(game["game_id"]) && game["team_id"] != team_id
        total_games[game["team_id"]]  += 1
        if game["result"] == "LOSS"
          loser_loses[game["team_id"]] += 1
        end
      end
    end
    biggest_loser = loser_loses.max_by do |loser, losses|
      losses.to_f / total_games[loser]
    end
    biggest_loser_name = @teams.find do |team|
      biggest_loser[0] == team["team_id"]
    end
    biggest_loser_name["teamName"]
  end

  def rival(team_id)
    games = @game_teams.find_all do |game|
      game["team_id"] == team_id
    end
    game_ids = games.map do |game|
      game["game_id"]
    end
    total_games = Hash.new(0)
    winner_wins = Hash.new(0)
    @game_teams.each do |game|
      if game_ids.include?(game["game_id"]) && game["team_id"] != team_id
        total_games[game["team_id"]]  += 1
        if game["result"] == "WIN"
          winner_wins[game["team_id"]] += 1
        end
      end
    end
    biggest_winner = winner_wins.max_by do |winner, wins|
      wins.to_f / total_games[winner]
    end
    biggest_winner_name = @teams.find do |team|
      biggest_winner[0] == team["team_id"]
    end
    biggest_winner_name["teamName"]
  end
end
