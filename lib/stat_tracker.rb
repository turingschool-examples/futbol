require 'CSV'
require_relative './game'
require_relative './teams'
require_relative './game_teams'

class StatTracker

  def initialize(locations)
    @games_path = locations[:games]
    @teams_path = locations[:teams]
    @game_teams_path = locations[:game_teams]
    @games_repo = GameRepo.new(@games_path)
    @game_teams_repo = GameTeamsRepo.new(@game_teams_path)
    @teams_repo = TeamsRepo.new(@teams_path)
  end

  def self.from_csv(locations)
    StatTracker.new(locations)
  end

  def highest_total_score
    @games_repo.highest_total_score
  end

  def lowest_total_score
    @games_repo.lowest_total_score
  end

  def percentage_home_wins
    @games_repo.percentage_home_wins
  end

  def percentage_visitor_wins
    @games_repo.percentage_visitor_wins
  end

  def percentage_ties
    @games_repo.percentage_ties
  end

  def games_by_season
    @games_repo.games_by_season
  end

  def game_teams_by_team
    @game_teams_repo.game_teams_by_team
  end

  def game_teams_by_away
    @game_teams_repo.game_teams_by_away
  end

  def game_teams_by_home
    @game_teams_repo.game_teams_by_home
  end

  def game_teams_by_coach
    @game_teams_repo.game_teams_by_coach
  end

  def count_of_games_by_season
    @games_repo.count_of_games_by_season
  end

  def average_goals_per_game
    @games_repo.average_goals_per_game
  end

  def average_goals_by_season
    @games_repo.average_goals_by_season
  end

  def count_of_teams
    @games_repo.count_of_teams
  end

  def best_offense
    best_team = @game_teams_repo.best_offense
    match = @teams_repo.all_teams.find do |team|
      team.team_id == best_team
    end
    match.teamname
  end

  def worst_offense
    average_goals = {}
    game_teams_by_team.map do |team , games|
      average_goals[team] = (games.sum {|game|  game.goals}).to_f / games.count
    end
    worst_team = average_goals.key(average_goals.values.min)
    match = @teams.find do |team|
      team.team_id == worst_team
    end
    match.teamname
  end

  def highest_scoring_visitor
    average_goals = {}
    game_teams_by_away.map do |team , games|
      average_goals[team] = (games.sum {|game|  game.goals}).to_f / games.count
    end
    best_visit = average_goals.key(average_goals.values.max)
    match = @teams.find do |team|
      team.team_id == best_visit
    end
    match.teamname
  end

  def highest_scoring_home_team
    average_goals = {}
    game_teams_by_home.map do |team , games|
      average_goals[team] = (games.sum {|game|  game.goals}).to_f / games.count
    end
    best_home = average_goals.key(average_goals.values.max)
    match = @teams.find do |team|
      team.team_id == best_home
    end
    match.teamname
  end

  def lowest_scoring_visitor
    average_goals = {}
    game_teams_by_away.map do |team , games|
      average_goals[team] = (games.sum {|game|  game.goals}).to_f / games.count
    end
    worst_visit = average_goals.key(average_goals.values.min)
    match = @teams.find do |team|
      team.team_id == worst_visit
    end
    match.teamname
  end

  def lowest_scoring_home_team
    average_goals = {}
    game_teams_by_home.map do |team , games|
      average_goals[team] = (games.sum {|game|  game.goals}).to_f / games.count
    end
    worst_home = average_goals.key(average_goals.values.min)
    match = @teams.find do |team|
      team.team_id == worst_home
    end
    match.teamname
  end

  def team_info(arg_id)
    @teams_repo.team_info(arg_id)
  end

  # def season_game_ids
  #   @games_repo.season_game_ids
  # end

  def game_team_by_season(season_id)
    game_ids = @games_repo.season_game_ids
    team_by_season = @game_teams.find_all do |row|
      game_ids[season_id].include?(row.game_id)
    end
    team_by_season
  end

  def games_by_team_id(season_id)
    game_by_id = game_team_by_season(season_id).group_by do |game|
      game.team_id
    end
    game_by_id
  end

  def team_conversion_percent(season_id)
    team_ratio = {}
    season_id_games = games_by_team_id(season_id)
    season_id_games.map do |team, games|
      goals = 0.0
      shots = 0.0
      games.map do |game|
        goals += game.goals
        shots += game.shots
      end
      team_ratio[team] = goals / shots
    end
    team_ratio
  end

  def most_accurate_team(season_id)
    ratio = team_conversion_percent(season_id).max_by do |team, ratio|
      ratio
    end

    @teams.map do |team|
      return team.teamname if team.team_id == ratio[0]
    end
  end

  def least_accurate_team(season_id)
    ratio = team_conversion_percent(season_id).min_by do |team, ratio|
      ratio
    end

    @teams.map do |team|
      return team.teamname if team.team_id == ratio[0]
    end
  end

  def game_ids_by_season(season_id)
    @games_repo.game_ids_by_season(season_id)
  end

  def winningest_coach(season_id)
    game_set = @games_repo.game_ids_by_season(season_id)
    win_rate = {}

    game_teams_by_coach.map do |coach, games|
      win_rate[coach] = ((games.count {|game| (game.result == "WIN") && game_set.include?(game.game_id)}).to_f / (games.count {|game| game_set.include?(game.game_id)})).round(2)
    end
    win_rate.key(win_rate.values.reject{|x| x.nan?}.max)
  end

  def worst_coach(season_id)
    game_set = @games_repo.game_ids_by_season(season_id)
    win_rate = {}
    game_teams_by_coach.map do |coach, games|
      win_rate[coach] = ((games.count {|game| (game.result == "WIN") && game_set.include?(game.game_id)}).to_f / (games.count {|game| game_set.include?(game.game_id)})).round(2)
    end
    win_rate.key(win_rate.values.reject{|x| x.nan?}.min)
  end

  def total_games_per_team_away(team_id)
    @games_repo.total_games_per_team_away(team_id)
  end

  def total_games_per_team_home(team_id)
    @games_repo.total_games_per_team_home(team_id)
  end

  def games_per_season_by_team(team_id)

    games_by_season = Hash.new(0)
    total_games_per_team = total_games_per_team_away(team_id) + total_games_per_team_home(team_id)

    total_games_per_team.each do |game|
      games_by_season[game.season] += 1
    end
    games_by_season
  end

  def wins_per_season_by_team(team_id)
    wins_by_season = Hash.new(0)

    total_games_per_team_home(team_id).each do |game|
      if game.calculate_winner == :home
        wins_by_season[game.season] += 1
      end
    end
    total_games_per_team_away(team_id).each do |game|
      if game.calculate_winner == :away
        wins_by_season[game.season] += 1
      end
    end
    wins_by_season
  end

  def best_season(team_id)
    win_percentage = {}

    wins_per_season_by_team(team_id).each do |season, win_number|
      win_percentage[season] = ((win_number.to_f / ((total_games_per_team_home(team_id).count) + (total_games_per_team_away(team_id).count))) * 100).round(2)
    end
    win_percentage.key(win_percentage.values.max)
  end

  def worst_season(team_id)
    win_percentage = {}

    wins_per_season_by_team(team_id).each do |season, win_number|
      win_percentage[season] = ((win_number.to_f / ((total_games_per_team_home(team_id).count) + (total_games_per_team_away(team_id).count))) * 100).round(2)
    end
    win_percentage.key(win_percentage.values.min)
  end

  def average_win_percentage(team_id)
    wins = 0
    total_game_count = total_games_per_team_away(team_id).count + total_games_per_team_home(team_id).count

    total_games_per_team_home(team_id).each do |game|
      if game.calculate_winner == :home
        wins += 1
      end
    end

    total_games_per_team_away(team_id).each do |game|
      if game.calculate_winner == :away
        wins += 1
      end
    end
    (wins.to_f / total_game_count).round(2)
  end

  def most_goals_scored(team_id)
    goals = 0

    game_teams_by_team.each do |team, games|
      if team_id == team
        goals = games.max_by do |game|
          game.goals
        end.goals
      end
    end
    goals
  end

  def fewest_goals_scored(team_id)
    goals = 0

    game_teams_by_team.each do |team, games|
      if team_id == team
        goals = games.min_by do |game|
          game.goals
        end.goals
      end
    end
    goals
  end

  def game_teams_by_team_id
    game_set = {}
    game_teams_by_team.map do |team, games|
      game_set[team] = games.map do |game|
        game.game_id
      end
    end
    game_set
  end

  def favorite_opponent(team_id)
    game_set = game_teams_by_team_id[team_id]
    win_rate = {}
    game_teams_by_team.map do |team, games|
      games_won = 0.0
      games_total = 0.0
      games.map do |game|
        games_won += 1 if game.result == "WIN" && game_set.include?(game.game_id)
        games_total += 1 if game_set.include?(game.game_id)
      end
      win_rate[team] = games_won / games_total
    end
    fav = win_rate.key(win_rate.values.min)
    @teams.find do |team|
      team.team_id == fav
    end.teamname
  end

  def rival(team_id)
    game_set = game_teams_by_team_id[team_id]
    win_rate = {}
    game_teams_by_team.map do |team, games|
      games_won = 0.0
      games_total = 0.0
      games.map do |game|
        games_won += 1 if game.result == "WIN" && game_set.include?(game.game_id)
        games_total += 1 if game_set.include?(game.game_id)
      end
      win_rate[team] = games_won / games_total
    end
    fav = win_rate.key(win_rate.values.max)
    @teams.find do |team|
      team.team_id == fav
    end.teamname
  end

  def most_tackles(season_id)
    team_tackles = {}
    games_by_team_id(season_id).map do |team, games|
      tackles = 0
      games.map do |game|
        tackles += game.tackles
      end
      team_tackles[team] = tackles
    end

    @teams.find do |team|
      team.team_id == team_tackles.key(team_tackles.values.max)
    end.teamname
  end

  def fewest_tackles(season_id)
    team_tackles = {}
    games_by_team_id(season_id).map do |team, games|
      tackles = 0
      games.map do |game|
        tackles += game.tackles
      end
      team_tackles[team] = tackles
    end

    @teams.find do |team|
      team.team_id == team_tackles.key(team_tackles.values.min)
    end.teamname
  end

end
