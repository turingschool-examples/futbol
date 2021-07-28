require 'csv'
require './lib/game'
require './lib/team'
require './lib/game_team'

class StatTracker
  attr_reader :games, :teams, :game_teams
  def initialize(stats)
    @games = stats[:games]
    @teams = stats[:teams]
    @game_teams = stats[:game_teams]
  end

  def self.from_csv(locations)
    stats = {}
    stats[:games] = create_game_csv(locations)
    stats[:teams] = create_teams_csv(locations)
    stats[:game_teams] = create_game_teams_csv(locations)

    StatTracker.new(stats)

  end

  def self.create_game_csv(locations)
    games = []
    game_csv = CSV.foreach(locations[:games], headers: true) do |row|
      game = Game.new(row)
      games << game
    end
    games
  end

  def self.create_teams_csv(locations)
    teams = []
    team_csv = CSV.foreach(locations[:teams], headers: true) do |row|
      team = Team.new(row)
      teams << team
    end
    teams
  end

  def self.create_game_teams_csv(locations)
    game_teams = []
    game_team_csv = CSV.foreach(locations[:game_teams], headers: true) do |row|
      game_team = GameTeam.new(row)
      game_teams << game_team
    end
    game_teams
  end
# GAME STATISTICS
  def highest_total_score
    game_sums = @games.map do |game|
      game.home_goals + game.away_goals
    end
    game_sums.max
  end

  def lowest_total_score
    game_sums = @games.map do |game|
      game.home_goals + game.away_goals
    end
    game_sums.min
  end

   def percentage_home_wins
    home_wins = @games.find_all do |game|
      game.home_goals > game.away_goals
    end.length
    (home_wins.to_f / (games.length)).round(2)
  end

  def percentage_visitor_wins
    vistor_wins = @games.find_all do |game|
      game.away_goals > game.home_goals
    end.length
    (vistor_wins.to_f / (games.length)).round(2)
  end

  def percentage_ties
    ties = @games.find_all do |game|
      game.away_goals == game.home_goals
    end.length
    (ties.to_f / (games.length)).round(2)
  end

  def count_of_games_by_season
    count = {}
    @games.each do |game|
      if count[game.season.to_s].nil?
        count[game.season.to_s] = 1
      else
        count[game.season.to_s] += 1
      end
    end
    count
  end

  def average_goals_per_game
    total_goals = @games.sum do |game|
      game.away_goals + game.home_goals
    end
    (total_goals.to_f / (@games.length)).round(2)
  end

  def average_goals_by_season
    hash = {}
    @games.each do |game|
      if hash[game.season].nil?
        hash[game.season] = [1, game.home_goals + game.away_goals]
      else
        hash[game.season][0] += 1
        hash[game.season][1] += game.home_goals + game.away_goals
      end
    end
    results = {}
    hash.each do |season, stats|
      results[season.to_s] = (stats[1].to_f / stats[0]).round(2)
    end
    results
  end

# LEAGUE STATISTICS
  def count_of_teams
    @teams.count
  end

  def games_by_team_id
    teams = {}
    @game_teams.each do |team|
      if teams[team.team_id].nil?
        teams[team.team_id] = [team]
      elsif !teams[team.team_id].include?(team)
        teams[team.team_id] << team
      end
    end
    teams
  end

  def goals_per_team
    team_goals = {}
    @game_teams.each do |team|
      if team_goals[team.team_id].nil?
        team_goals[team.team_id] = [team.goals]
      else
        team_goals[team.team_id] << team.goals
      end
    end
    team_goals
  end

  def team_name_by_team_id(team_id)
    team = @teams.find do |team|
      team_id == team.team_id
    end
    team.team_name
  end

  def best_offense
    team_id = goals_per_team.max_by do |team, goals|
      goals.sum / goals.count.to_f
    end
    team_name_by_team_id(team_id.first)
  end

  def worst_offense
    team_id = goals_per_team.min_by do |team, goals|
      goals.sum / goals.count.to_f
    end
    team_name_by_team_id(team_id.first)
  end

  def games_by_hoa(hoa)
    hoa_by_team_id = {}
    games_by_team_id.each do |id, games|
      games.each do |game|
        if game.hoa == hoa
          if hoa_by_team_id[id].nil?
            hoa_by_team_id[id] = [1, game.goals]
          else
            hoa_by_team_id[id][0] += 1
            hoa_by_team_id[id][1] += game.goals
          end
        end
      end
    end
    hoa_by_team_id
  end

  def highest_scoring_visitor
    highest_visitor = games_by_hoa("away").max_by do |team, stats|
      stats[1] / stats[0].to_f
    end
    team_name_by_team_id(highest_visitor.first)
  end

  def highest_scoring_home_team
    highest_home_team = games_by_hoa("home").max_by do |team, stats|
      stats[1] / stats[0].to_f
    end
    team_name_by_team_id(highest_home_team.first)
  end

  def lowest_scoring_visitor
    lowest_away_team = games_by_hoa("away").min_by do |team, stats|
      stats[1] / stats[0].to_f
    end
    team_name_by_team_id(lowest_away_team.first)
  end

  def lowest_scoring_home_team
    lowest_home_team = games_by_hoa("home").min_by do |team, stats|
      stats[1] / stats[0].to_f
    end
    team_name_by_team_id(lowest_home_team.first)
  end

  # SEASON STATISTICS

  def game_ids_by_season(season)
    @games.map do |game|
      game.game_id if game.season.to_s == season
    end.compact
  end

  def game_teams_by_season(season)
    game_ids = game_ids_by_season(season)
    gts = @game_teams.find_all do |game_team|
      game_ids.include?(game_team.game_id)
    end
    gts
  end

  def coach_stats_by_season(season)
    coaches = {}
    game_teams_by_season(season).each do |game_team|
      if coaches[game_team.head_coach].nil?
        coaches[game_team.head_coach] = [0, 0]
      end
      coaches[game_team.head_coach][0] += 1
      coaches[game_team.head_coach][1] += 1 if game_team.result == "WIN"
    end
    coaches
  end

  def winningest_coach(season)
    best_coach = coach_stats_by_season(season).max_by do |coach, stats|
      stats[1].to_f / stats[0]
    end
    best_coach.first
  end

  def worst_coach(season)
    baddest_coach = coach_stats_by_season(season).min_by do |coach, stats|
      stats[1].to_f / stats[0]
    end
    baddest_coach.first
  end

  def team_shots_by_season(season)
    teams_shots = {}
    game_teams_by_season(season).each do |game_team|
      if teams_shots[game_team.team_id].nil?
        teams_shots[game_team.team_id]  = [0, 0]
      end
      teams_shots[game_team.team_id][0] += game_team.goals
      teams_shots[game_team.team_id][1] += game_team.shots
    end
    teams_shots
  end

  def most_accurate_team(season)
    most_accurate = team_shots_by_season(season).max_by do |team, stats|
      stats[0] / stats[1].to_f
    end
    team_name_by_team_id(most_accurate.first)
  end

  def least_accurate_team(season)
    least_accurate = team_shots_by_season(season).min_by do |team, stats|
      stats[0] / stats[1].to_f
    end
    team_name_by_team_id(least_accurate.first)
  end

  def tackles_by_season(season)
    tackles = {}
    game_teams_by_season(season).each do |game_team|
      if tackles[game_team.team_id].nil?
        tackles[game_team.team_id]  = 0
      end
      tackles[game_team.team_id] += game_team.tackles
    end
    tackles
  end

  def most_tackles(season)
    most_tackles = tackles_by_season(season).max_by do |team, tackles|
      tackles
    end
    team_name_by_team_id(most_tackles.first)
  end

  def fewest_tackles(season)
    fewest_tackles = tackles_by_season(season).min_by do |team, tackles|
      tackles
    end
    team_name_by_team_id(fewest_tackles.first)
  end

  def team_info(team_id)
    find_team = @teams.find do |team|
      team.team_id.to_s == team_id
    end
    team_info = {
      "team_id" => find_team.team_id.to_s,
      "franchise_id" => find_team.franchise_id.to_s,
      "team_name" => find_team.team_name,
      "abbreviation" => find_team.abbreviation,
      "link" => find_team.link
    }
  end
end
