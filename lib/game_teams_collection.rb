require_relative './game_team'
require_relative './calculator'

class GameTeamsCollection
  include Calculator

  attr_reader :game_teams
  def initialize(game_teams_path)
    @game_teams = create_game_teams(game_teams_path)
  end

  def create_game_teams(game_teams_path)
    CSV.foreach(game_teams_path, headers: true, header_converters: :symbol).map do |row|
      GameTeam.new(row)
    end
  end

  def games_by_team
    games_by_hoa
  end

  def away_games_by_team
    games_by_hoa("away")
  end

  def home_games_by_team
    games_by_hoa("home")
  end

  def games_by_hoa(hoa = "all")
    game_teams.each_with_object(Hash.new(0)) do |game_team, average|
      if game_team.hoa == hoa
        average[game_team.team_id] += 1
      elsif hoa == "all"
        average[game_team.team_id] += 1
      end
    end
  end

  def goal_total_by_hoa(hoa = "all")
    game_teams.each_with_object(Hash.new(0)) do |game_team, average|
      if game_team.hoa == hoa
        average[game_team.team_id] += game_team.goals
      elsif hoa == "all"
        average[game_team.team_id] += game_team.goals
      end
    end
  end

  def average_goals_by_team
    combine(games_by_team, goal_total_by_hoa)
  end

  def average_away_goals_by_team
    combine(away_games_by_team, goal_total_by_hoa("away"))
  end

  def average_home_goals_by_team
    combine(home_games_by_team, goal_total_by_hoa("home"))
  end

  def best_offense
    high(average_goals_by_team).first
  end

  def worst_offense
    low(average_goals_by_team).first
  end

  def highest_scoring_visitor
    high(average_away_goals_by_team).first
  end

  def highest_scoring_hometeam
    high(average_home_goals_by_team).first
  end

  def lowest_scoring_visitor
    low(average_away_goals_by_team).first
  end

  def lowest_scoring_hometeam
    low(average_home_goals_by_team).first
  end

  def wins_by_coach(season_id)
    @game_teams.each_with_object(Hash.new {|h, k| h[k] = {success: 0, total: 0}}) do |game_team, wins|
      next unless game_team.game_id[0..3] == season_id[0..3]
      wins[game_team.head_coach][:total] += 1
      wins[game_team.head_coach][:success] += 1 if game_team.result == "WIN"
    end
  end

  def winningest_coach(season_id)
    max_avg(wins_by_coach(season_id)).first
  end

  def worst_coach(season_id)
    min_avg(wins_by_coach(season_id)).first
  end

  def shots_by_team_by_season(season_id)
    game_teams.each_with_object(Hash.new {|h, k| h[k] = {success: 0, total: 0}}) do |game_team, stat|
      next unless game_team.game_id[0..3] == season_id[0..3]
      stat[game_team.team_id][:success] += game_team.shots
      stat[game_team.team_id][:total] += game_team.goals
    end
  end

  def most_accurate_team(season_id)
    min_avg(shots_by_team_by_season(season_id)).first
  end

  def least_accurate_team(season_id)
    max_avg(shots_by_team_by_season(season_id)).first
  end

  def teams_with_tackles(season_id)
    game_teams.each_with_object(Hash.new(0)) do |game_team, teams|
      next unless game_team.game_id[0..3] == season_id[0..3]
      teams[game_team.team_id] += game_team.tackles
    end
  end

  def most_tackles(season_id)
    high(teams_with_tackles(season_id)).first
  end

  def fewest_tackles(season_id)
    low(teams_with_tackles(season_id)).first
  end
end
