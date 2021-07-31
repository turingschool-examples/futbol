require 'CSV'
require_relative './game'
require_relative './team'
require_relative './game_teams'

class StatTracker
  attr_reader :games, :teams, :game_teams
  def initialize (games, teams, game_teams)
    @games = games
    @teams = teams
    @game_teams = game_teams
  end

  def self.from_csv(locations)
    games = []
    teams = []
    game_teams = []

    CSV.foreach(locations[:games], headers: true, header_converters: :symbol) do |row|
      headers ||= row.headers

      games << Game.new(row)
    end

    CSV.foreach(locations[:teams], headers: true, header_converters: :symbol) do |row|
      headers ||= row.headers

      teams << Team.new(row)

    end

    CSV.foreach(locations[:game_teams], headers: true, header_converters: :symbol) do |row|
      headers ||= row.headers

      game_teams << GameTeams.new(row)
    end

    StatTracker.new(games, teams, game_teams)

  end
# Game stats start
  def highest_total_score
    highest_scoring_game =
    @games.max_by do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end
    highest_scoring_game.away_goals.to_i + highest_scoring_game.home_goals.to_i
  end

  def lowest_total_score
    lowest_scoring_game =
    @games.min_by do |game|
      game.away_goals.to_i + game.home_goals.to_i
    end
    lowest_scoring_game.away_goals.to_i + lowest_scoring_game.home_goals.to_i
  end

  def percentage_home_wins
    (home_team_wins.fdiv(@games.length)).round(2)
  end

  def percentage_visitor_wins
    (visitor_team_wins.fdiv(@games.length)).round(2)
  end

  def percentage_ties
    (ties.fdiv(@games.length)).round(2)
  end

  def home_team_wins
    home_wins =
    @games.count do |game|
      game.home_goals > game.away_goals
    end
    home_wins
  end

  def visitor_team_wins
    visitor_wins =
    @games.count do |game|
      game.home_goals < game.away_goals
    end
    visitor_wins
  end

  def ties
    ties =
    @games.count do |game|
      game.home_goals == game.away_goals
    end
    ties
  end

  def count_of_games_by_season
    games_by_season = Hash.new(0)
    @games.each do |game|
        games_by_season[game.season] += 1
    end
    games_by_season
  end

  def average_goals_per_game
    goals = []
    @games.each do |game|
      goals << game.home_goals.to_i + game.away_goals.to_i
    end
    goals.sum.fdiv(goals.length).round(2)
  end

  def total_goals_by_season
    goals_by_season = Hash.new(0)
    @games.each do |game|
      goals_by_season[game.season] += game.home_goals.to_i + game.away_goals.to_i
    end
    goals_by_season
  end

  def average_goals_by_season
    average_goals_by_season = Hash.new(0)
    total_goals_by_season.each do |season, goals|
      count_of_games_by_season.each do |key, games|
        if season == key
          average_goals_by_season[season] = goals.fdiv(games).round(2)
        end
      end
    end
    average_goals_by_season
  end

  def team_identifier(id)
    matching_team =
    @teams.find do |team|
      team.team_id == id
    end
    matching_team.team_name
  end

  def total_shots(season)
    shots_by_team = Hash.new(0)
    season_shorten = season.slice(0..3)
    @game_teams.each do |game|
      if game.game_id.start_with?(season_shorten)
        shots_by_team[game.team_id] += game.shots.to_i
      end
    end
    shots_by_team
  end

  def most_accurate_team(season)
    goals_by_team = Hash.new(0)
    season_shorten = season.slice(0..3)
    @game_teams.each do |game|
      if game.game_id.start_with?(season_shorten)
        goals_by_team[game.team_id] += game.goals.to_i
      end
    end
    accuracy =
      goals_by_team.max_by do |id, goals|
      tot_goals = total_shots(season)[id]
      goals.fdiv(tot_goals)
    end
    team_identifier(accuracy[0])
  end

  def least_accurate_team(season)
    goals_by_team = Hash.new(0)
    season_shorten = season.slice(0..3)
    @game_teams.each do |game|
      if game.game_id.start_with?(season_shorten)
        goals_by_team[game.team_id] += game.goals.to_i
      end
    end
    accuracy =
      goals_by_team.min_by do |id, goals|
      tot_goals = total_shots(season)[id]
      goals.fdiv(tot_goals)
    end
    team_identifier(accuracy[0])
  end

  def total_games_by_coach(season)
    games_by_coach = Hash.new(0)
    season_shorten = season.slice(0..3)
    @game_teams.each do |game|
      if game.game_id.start_with?(season_shorten)
        games_by_coach[game.head_coach] += 1
      end
    end
    games_by_coach
  end
# Season stats start
  def winningest_coach(season)
    wins_by_coach = Hash.new(0)
    season_shorten = season.slice(0..3)
    @game_teams.each do |game|
      if game.game_id.start_with?(season_shorten) && game.result == 'WIN'
        wins_by_coach[game.head_coach] += 1
      end
    end
    coach = wins_by_coach.max_by do |coach, wins|
      tot_games = total_games_by_coach(season)[coach]
      wins.fdiv(tot_games)
    end
    coach[0]
  end

  def worst_coach(season)
    wins_by_coach = total_games_by_coach(season)
    season_shorten = season.slice(0..3)
    @game_teams.each do |game|
      if game.game_id.start_with?(season_shorten) && game.result == ("WIN")
        wins_by_coach[game.head_coach] += 1
      end
    end

    loser_coach = wins_by_coach.min_by do |coach, wins|
      tot_games = total_games_by_coach(season)[coach]
      (wins_by_coach[coach] - tot_games).fdiv(tot_games)
    end
    loser_coach[0]
  end

  def most_tackles(season)
    tackles_by_team = Hash.new(0)
    season_shorten = season.slice(0..3)
    @game_teams.each do |game|
      if game.game_id.start_with?(season_shorten)
        tackles_by_team[game.team_id] += game.tackles.to_i
      end
    end
    team_highest = tackles_by_team.max_by do |team_id, tackles|
      tackles
    end
    team_identifier(team_highest[0])
  end

  def fewest_tackles(season)
    tackles_by_team = Hash.new(0)
    season_shorten = season.slice(0..3)
    @game_teams.each do |game|
      if game.game_id.start_with?(season_shorten)
        tackles_by_team[game.team_id] += game.tackles.to_i
      end
    end
    team_highest = tackles_by_team.min_by do |team_id, tackles|
      tackles
    end
    team_identifier(team_highest[0])
  end
# League stats start
  def count_of_teams
    @teams.length
  end

  def worst_offense
    acc = {}
    @teams.each do |team|
      if games_by_team(team.team_id).length != 0
        acc[games_average(team.team_id)] = team.team_name
      end
    end
    acc[acc.keys.min]
  end

  def best_offense
    acc = {}
    @teams.each do |team|
      if games_by_team(team.team_id).length != 0
        acc[games_average(team.team_id)] = team.team_name
      end
    end
    acc[acc.keys.max]
  end

  def games_average(team_id)
    goals_scored = 0.00
    games_by_team(team_id).each do |game|
      goals_scored += game.goals.to_i
    end
    goals_scored / games_by_team(team_id).length
  end

  def games_by_team(team_id)
    @game_teams.find_all do |game|
      game.team_id == team_id.to_s
    end
  end

  def away_games(team_id)
    games_by_team(team_id).find_all do |game|
      game.hoa == 'away'
    end
  end

  def away_average(team_id)
    goals_scored = 0.00
    away_games(team_id).each do |game|
      goals_scored += game.goals.to_i
    end
    goals_scored.fdiv(away_games(team_id).length)
  end

  def highest_scoring_visitor
    highest_scoring = {}
    @teams.each do |team|
      if away_games(team.team_id).length != 0
        highest_scoring[team.team_name] = away_average(team.team_id)
      end
    end
    highest_scoring.key(highest_scoring.values.max)
  end

  def lowest_scoring_visitor
    lowest_scoring = {}
    @teams.each do |team|
      if away_games(team.team_id).length != 0
        lowest_scoring[team.team_name] = away_average(team.team_id)
      end
    end
    lowest_scoring.key(lowest_scoring.values.min)
  end

  def home_games(team_id)
    games_by_team(team_id).find_all do |game|
      game.hoa == 'home'
    end
  end

  def home_average(team_id)
    goals_scored = 0.00
    home_games(team_id).each do |game|
      goals_scored += game.goals.to_i
    end
    goals_scored.fdiv(home_games(team_id).length)
  end

  def highest_scoring_home_team
    highest_scoring = {}
    @teams.each do |team|
      if home_games(team.team_id).length != 0
        highest_scoring[team.team_name] = home_average(team.team_id)
      end
    end
    highest_scoring.key(highest_scoring.values.max)
  end

  def lowest_scoring_home_team
    lowest_scoring = {}
    @teams.each do |team|
      if home_games(team.team_id).length != 0
        lowest_scoring[team.team_name] = home_average(team.team_id)
      end
    end
    lowest_scoring.key(lowest_scoring.values.min)
  end
# Team stats start
  def team_info(team_id)
    team_info = {}
    @teams.each do |team|
      if team.team_id == team_id
        team_info["team_id"] = team.team_id
        team_info["franchise_id"] = team.franchise_id
        team_info["team_name"] = team.team_name
        team_info["abbreviation"] = team.abbreviation
        team_info["link"] = team.link
      end
    end
    team_info
  end

  def games_won(team_id)
    @game_teams.find_all do |game|
      game.team_id == team_id && game.result == "WIN"
    end
  end

  def all_games_played(team_id)
    @game_teams.find_all do |game|
      game.team_id == team_id
    end
  end

  def average_win_percentage(team_id)
    games_won(team_id).length.fdiv(all_games_played(team_id).length)
  end

  def most_goals_scored(team_id)
    all_games_played(team_id).max_by do |game|
      game.goals
    end.goals.to_i
  end

  def fewest_goals_scored(team_id)
    all_games_played(team_id).min_by do |game|
      game.goals
    end.goals.to_i
  end

  def all_seasons
    seasons = []
    @games.each do |game|
      seasons << game.season if !seasons.include?(game.season)
    end
    seasons
  end

  def best_season(team_id)
    all_seasons.max_by do |season|
       [season_win_percentage(season, team_id)].compact
    end
  end

  def season_win_percentage(season, team_id)
    winning_game_ids = games_won(team_id).map do |game|
      game.game_id
    end

    games_in_season = []
    total_games = 0
    @games.each do |game|
      if game.season == season && (game.away_team_id == team_id || game.home_team_id == team_id)
        total_games += 1
      end
      if game.season == season
        games_in_season << game.game_id
      end
    end

    winning_game_in_season_ids = winning_game_ids & games_in_season
    if total_games != 0
      winning_game_in_season_ids.length.fdiv(total_games)
    end
  end

  def worst_season(team_id)
    all_seasons.min_by do |season|
      [season_win_percentage(season, team_id)].compact
    end
  end

  def all_opponents(team_id)
    @games.filter_map do |game|
      if team_id == game.home_team_id
        game.away_team_id
      elsif team_id == game.away_team_id
        game.home_team_id
      end
    end.uniq
  end

  def team_opponent_win_percentage(opponent_id, team_id)
    team_wins = 0
    total_games = 0
    @games.each do |game|
      if game.away_team_id == team_id && game.home_team_id == opponent_id
        team_wins +=1 if game.away_goals > game.home_goals
        total_games += 1
      elsif game.home_team_id == team_id && game.away_team_id == opponent_id
        team_wins += 1 if game.away_goals < game.home_goals
        total_games += 1
      end
    end
    team_wins.fdiv(total_games)
  end

end
