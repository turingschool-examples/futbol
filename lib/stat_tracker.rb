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

  def find_team_by(id)
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
    find_team_by(highest_avg_score.first).team_name
  end

  def worst_offense
    lowest_avg_score = average_scores_by_team.min_by do |_team, avg_score|
      avg_score
    end
    find_team_by(lowest_avg_score.first).team_name
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

  # SEASON STATISTICS
  def games_by_season(season)
    games.find_all { |game| game.season == season }
  end

  def winningest_coach(season)
    #season_games_by_id returns an array of just season game ids
    season_game_ids = games_by_season(season).map do |game|
      game.game_id
    end

    #then find all games in game_teams from the above season
    season_games = game_teams.find_all do |game|
    season_game_ids.include?(game.game_id)
    end

    # filter season games by wins
    wins = season_games.find_all do |game|
    game.result == "WIN"
    end

    # returns an array of coach name for each win
    coach_wins = wins.map do |game|
    game.head_coach
    end

    # creates a hash of number of season games won by coach
    wins_by_coach = coach_wins.inject(Hash.new(0)) do |wins_by_coach, coach|
       wins_by_coach[coach] += 1; wins_by_coach
     end

    #return the winningest head_coach name as a string
    coach_wins.max_by { |coach| wins_by_coach[coach] }
  end

  # worst_coach

  # most_accurate_team

  # least_accurate_team

  # most_tackles

  # fewest_tackles

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
    season = games_won_by_season(team_id).max_by do |season, games|
      games.count
    end
    season[0]
  end

  def worst_season(team_id)
    season = games_lost_by_season(team_id).max_by do |season, games|
      games.count
    end
    season[0]
  end

  # Helper Methods----------------------

  def game_ids_by(team_id, result)
    from_game_teams = @game_teams.find_all do |game_team|
      game_team.team_id == team_id && game_team.result == result
    end
    from_game_teams.map do |game_team|
      game_team.game_id
    end
  end

  def games_by(game_ids_array)
    @games.find_all do |game|
      game_ids_array.include?(game.game_id)
    end
  end

  def games_won_by(team_id)
    game_ids = game_ids_by(team_id, "WIN")
    games_by(game_ids)
  end

  def games_lost_by(team_id)
    game_ids = game_ids_by(team_id, "LOSS")
    games_by(game_ids)
  end

  def games_won_by_season(team_id)
    games_won_by(team_id).group_by do |game|
      game.season
    end
  end

  def games_lost_by_season(team_id)
    games_lost_by(team_id).group_by do |game|
      game.season
    end
  end

end
