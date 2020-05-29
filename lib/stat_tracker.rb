require_relative './readable'
require_relative './game'
require_relative './team'
require_relative './game_team'

class StatTracker
  include Readable

  attr_reader :games, :teams, :game_teams

  def initialize(stat_tracker_params)
    games_path = stat_tracker_params[:games]
    teams_path = stat_tracker_params[:teams]
    game_teams_path = stat_tracker_params[:game_teams]

    @games = from_csv(games_path, Game)
    @teams = from_csv(teams_path, Team)
    @game_teams = from_csv(game_teams_path, GameTeam)
  end

  def self.from_csv(stat_tracker_params)
    StatTracker.new(stat_tracker_params)
  end

  # GAME STATISTICS

  def highest_total_score
    games.max_by { |game| game.total_goals }.total_goals
  end

  def lowest_total_score
    games.min_by { |game| game.total_goals }.total_goals
  end

  def find_home_wins
    game_teams.find_all do |game_team|
      game_team.hoa == "home" && game_team.result == "WIN"
    end
  end

  def percentage_home_wins
    percentage = find_home_wins.count.fdiv(game_teams.count / 2) * 100
    percentage.round(2)
  end

  def find_visitor_wins
    game_teams.find_all do |game_team|
      game_team.hoa == "away" && game_team.result == "WIN"
    end
  end

  def percentage_visitor_wins
    percentage = find_visitor_wins.count.fdiv(game_teams.count / 2) * 100
    percentage.round(2)
  end

  # LEAGUE STATISTICS
  def count_of_teams
    teams.count
  end

  def find_team_by_id(id)
    @teams.find do |team|
      team.team_id == id
    end
  end

  def scores_by_team
    game_teams.reduce({}) do |team_scores, game|
      if team_scores[game.team_id].nil?
        team_scores[game.team_id] = [game.goals]
      else
        team_scores[game.team_id] << game.goals
      end
      team_scores
    end
  end

  def average_scores_by_team
    avgs_by_team = {}
    scores_by_team.each do |team, scores_array|
      avgs_by_team[team] = (scores_array.sum / scores_array.count.to_f)
    end
    avgs_by_team
  end

  def best_offense
    highest_avg_score = average_scores_by_team.max_by do |_team, avg_score|
      avg_score
    end
    find_team_by_id(highest_avg_score.first).team_name
  end

  def worst_offense
    lowest_avg_score = average_scores_by_team.min_by do |_team, avg_score|
      avg_score
    end
    find_team_by_id(lowest_avg_score.first).team_name
  end

  def highest_scoring_visitor # reconsider local variable names in this method
    # and how to better set up average_scores_by_team method to be able to be
    # resued by multiple methods and take an argument of varying subsets of teams
    away_teams = @game_teams.find_all do |game_team|
      game_team.hoa == "away"
    end

    sorted_away_teams = away_teams.reduce({}) do |team_scores, game|
      if team_scores[game.team_id].nil?
        team_scores[game.team_id] = [game.goals]
      else
        team_scores[game.team_id] << game.goals
      end
      team_scores
    end

    avgs_by_team = {}
    sorted_away_teams.each do |visiting_team_id, scores_array|
      avgs_by_team[visiting_team_id] = (scores_array.sum / scores_array.count.to_f)
    end

    highest_scoring_visitor_id = avgs_by_team.max_by do |_visiting_team_id, avg_score|
      avg_score
    end.first

    find_team_by_id(highest_scoring_visitor_id).team_name
  end

  def highest_scoring_home_team
    home_teams = @game_teams.find_all do |game_team|
      game_team.hoa == "home"
    end

    sorted_home_teams = home_teams.reduce({}) do |team_scores, game|
      if team_scores[game.team_id].nil?
        team_scores[game.team_id] = [game.goals]
      else
        team_scores[game.team_id] << game.goals
      end
      team_scores
    end

    avgs_by_team = {}
    sorted_home_teams.each do |home_team_id, scores_array|
      avgs_by_team[home_team_id] = (scores_array.sum / scores_array.count.to_f)
    end

    highest_scoring_home_id = avgs_by_team.max_by do |_visiting_team_id, avg_score|
      avg_score
    end.first

    find_team_by_id(highest_scoring_home_id).team_name
  end

  def lowest_scoring_visitor
    away_teams = @game_teams.find_all do |game_team|
      game_team.hoa == "away"
    end

    sorted_away_teams = away_teams.reduce({}) do |team_scores, game|
      if team_scores[game.team_id].nil?
        team_scores[game.team_id] = [game.goals]
      else
        team_scores[game.team_id] << game.goals
      end
      team_scores
    end

    avgs_by_team = {}
    sorted_away_teams.each do |visiting_team_id, scores_array|
      avgs_by_team[visiting_team_id] = (scores_array.sum / scores_array.count.to_f)
    end

    lowest_scoring_visitor_id = avgs_by_team.min_by do |_visiting_team_id, avg_score|
      avg_score
    end.first

    find_team_by_id(lowest_scoring_visitor_id).team_name
  end

  def lowest_scoring_home_team
    home_teams = @game_teams.find_all do |game_team|
      game_team.hoa == "home"
    end

    sorted_home_teams = home_teams.reduce({}) do |team_scores, game|
      if team_scores[game.team_id].nil?
        team_scores[game.team_id] = [game.goals]
      else
        team_scores[game.team_id] << game.goals
      end
      team_scores
    end

    avgs_by_team = {}
    sorted_home_teams.each do |home_team_id, scores_array|
      avgs_by_team[home_team_id] = (scores_array.sum / scores_array.count.to_f)
    end

    lowest_scoring_home_id = avgs_by_team.min_by do |_visiting_team_id, avg_score|
      avg_score
    end.first

    find_team_by_id(lowest_scoring_home_id).team_name
  end

  # SEASON STATISTIC

  # TEAM STATISTICS

  def team_info(id)
    teams.find do |team|
      team.team_id == id
    end.info
  end

  def most_goals_scored(team_id)
    game_teams.reduce([]) do |scores, game_team|
      scores << game_team.goals if game_team.team_id == team_id
      scores
    end.max
  end

  def fewest_goals_scored(team_id)
    game_teams.reduce([]) do |scores, game_team|
      scores << game_team.goals if game_team.team_id == team_id
      scores
    end.min
  end

  def best_season(team_id)
    # Create array of game_team objects with matching team_id and WINs
    # (this could be a GameTeamCollection find_by method!!
    # maybe split up the matching by team_id and matching by result)
    game_teams_won = game_teams.find_all do |game_team|
      game_team.team_id == team_id && game_team.result == "WIN"
    end

    # Cross-reference game_teams with games:
    games_won = []
    game_teams_won.each do |game_team|
      games.each do |game|
        games_won << game if game_team.game_id == game.game_id
      end
    end

    # Using cross-referenced game list, create hash with season as keys,
    # and won [Game objects array] as values
    season_hash = games_won.group_by do |game|
      game.season
    end

    # Count up the number of games for each season (remember these are "wins")
    # For some reason, calling max_by on a hash returns an array.
    season_with_most_wins = season_hash.max_by do |season, games|
      games.count
    end

    # so then I called the would-be key by using index 0 in the array
    season_with_most_wins[0].to_s
  end

end
