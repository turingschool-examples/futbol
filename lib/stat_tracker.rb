require 'csv'
require './lib/game'
require './lib/team'
require './lib/game_team'
require './lib/game_statistics'
require './lib/league_statistics'
require './lib/season_statistics'
require './lib/team_statistics'


class StatTracker
  include GameStatistics
  include LeagueStatistics
  include SeasonStatistics
  
  attr_reader :games, :teams, :game_teams
  def initialize(stats)
    @games = stats[:games]
    @teams = stats[:teams]
    @game_teams = stats[:game_teams]
  end

  def self.from_csv(locations)
    stats = {}
    stats[:games] = create_obj_csv(locations[:games], Game)
    stats[:teams] = create_obj_csv(locations[:teams], Team)
    stats[:game_teams] = create_obj_csv(locations[:game_teams], GameTeam)

    StatTracker.new(stats)
  end

  def self.create_obj_csv(locations, obj_type)
    objects = []
    CSV.foreach(locations, headers: true, header_converters: :symbol) do |row|
      object = obj_type.new(row)
      objects << object
    end
    objects
  end

  def game_ids_by_season(season)
    @games.map do |game|
      game.game_id if game.season == season
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
      team.team_id == team_id
    end
    team_info = {
      "team_id" => find_team.team_id,
      "franchise_id" => find_team.franchise_id,
      "team_name" => find_team.team_name,
      "abbreviation" => find_team.abbreviation,
      "link" => find_team.link
    }
  end

  def find_games_by_team_id(team_id)
    games_by_team = @games.find_all do |game|
      game.away_team_id == team_id || game.home_team_id == team_id
    end
    games_by_team
  end

  def find_win_count(team_id)
    season_wins = {}
    find_games_by_team_id(team_id).each do |game|
      if season_wins[game.season].nil?
        season_wins[game.season] = [0, 0]
        # total games, wins
      end
      season_wins[game.season][0] += 1
      if game.away_team_id == team_id && game.away_goals > game.home_goals
        season_wins[game.season][1] += 1
      elsif game.home_team_id == team_id && game.home_goals > game.away_goals
        season_wins[game.season][1] += 1
      end
    end
    season_wins
  end

  def best_season(team_id)
    best_season = find_win_count(team_id).max_by do |season, wins|
      wins[1] / wins[0].to_f
    end
    best_season.first
  end

  def worst_season(team_id)
    worst_season = find_win_count(team_id).min_by do |season, wins|
      wins[1] / wins[0].to_f
    end
    worst_season.first
  end

  def total_win_count(team_id)
    team_wins = @game_teams.count do |game|
      team_id == game.team_id && game.result == "WIN"
    end
    team_wins
  end

  def average_win_percentage(team_id)
    (total_win_count(team_id).to_f / find_games_by_team_id(team_id).count).round(2)
  end

  def game_teams_by_id(team_id)
    by_id = @game_teams.find_all do |game|
      game.team_id == team_id
    end
    by_id
  end

  def most_goals_scored(team_id)
    most_goals = game_teams_by_id(team_id).max_by do |game|
      game.goals
    end
    most_goals.goals
  end

  def fewest_goals_scored(team_id)
    fewest_goals = game_teams_by_id(team_id).min_by do |game|
      game.goals
    end
    fewest_goals.goals
  end

  def games_against_rivals(team_id)
    rival_games = {}
    find_games_by_team_id(team_id).each do |game|
      if game.away_team_id != team_id
        if rival_games[game.away_team_id].nil?
          rival_games[game.away_team_id] = [game]
        else
          rival_games[game.away_team_id] << game
        end
      else
        if rival_games[game.home_team_id].nil?
          rival_games[game.home_team_id] = [game]
        else
          rival_games[game.home_team_id] << game
        end
      end
    end
    rival_games
  end

  def wins_against_rivals(team_id)
    wins_against_rivals = {}
    games_against_rivals(team_id).each do |rival, games|
      if wins_against_rivals[rival].nil?
        wins_against_rivals[rival] = [0, 0]
        # total games, wins
      end
      games.each do |game|
        wins_against_rivals[rival][0] += 1
        if game.away_team_id == team_id && game.away_goals > game.home_goals
          wins_against_rivals[rival][1] += 1
        elsif game.home_team_id == team_id && game.home_goals > game.away_goals
          wins_against_rivals[rival][1] += 1
        end
      end
    end
    wins_against_rivals
  end

  def favorite_opponent(team_id)
    favorite = wins_against_rivals(team_id).max_by do |team, stats|
      stats[1].to_f / stats[0]
    end
    team_name_by_team_id(favorite.first)
  end

  def rival(team_id)
    least_favorite = wins_against_rivals(team_id).min_by do |team, stats|
      stats[1].to_f / stats[0]
    end
    team_name_by_team_id(least_favorite.first)
  end
end
