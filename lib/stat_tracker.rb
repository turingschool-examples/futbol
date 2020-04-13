require_relative './team'
require_relative './game'
require_relative './game_teams'
require_relative './game_teams_repository'
require_relative './team_repository'
require_relative './game_repository'
require_relative './league_repository'
require_relative './season_repository'


require 'CSV'


class StatTracker


  def self.from_csv(file_paths)
    league_repository = LeagueRepository.new(file_paths[:games], file_paths[:game_teams], file_paths[:teams])
    team_repository = TeamRepository.new(file_paths[:game_teams], file_paths[:teams], file_paths[:games])
    game_repository = GameRepository.new(file_paths[:games])
    game_team_repository = GameTeamsRepository.new(file_paths[:game_teams])
    season_repository = SeasonRepository.new(file_paths[:games], file_paths[:game_teams], file_paths[:teams])
    stat_tracker = StatTracker.new(team_repository, game_repository, game_team_repository, league_repository, season_repository)

  end
    attr_reader :team_repository, :game_repository, :game_team_repository, :season_repository

  def initialize(team_repository, game_repository, game_team_repository, league_repository, season_repository)
    @team_repository = team_repository
    @game_repository = game_repository
    @game_team_repository = game_team_repository
    @league_repository = league_repository
    @season_repository = season_repository
  end

  def highest_total_score
    @game_repository.highest_total_score
  end

  def lowest_total_score
    @game_repository.lowest_total_score
  end

  def percentage_home_wins
    @game_repository.percentage_home_wins
  end

  def team_info(id)
    @team_repository.team_info(id)
  end

  def count_of_teams
    @league_repository.count_of_teams
  end

  def best_offense
    @league_repository.best_offense
  end

  def worst_offense
    @league_repository.worst_offense
  end

  def highest_scoring_visitor
    @league_repository.highest_scoring_visitor
  end


  def best_offense
    @league_repository.best_offense
  end

  def highest_scoring_home_team
    @league_repository.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @league_repository.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @league_repository.lowest_scoring_home_team
  end


  def best_season(id)

  end

  def most_goals_scored(id)
    @team_repository.most_goals_scored(id)
  end

  def fewest_goals_scored(id)
    @team_repository.fewest_goals_scored(id)
  end

  def percentage_visitor_wins
    @game_repository.percentage_visitor_wins
  end

  def percentage_ties
    @game_repository.percentage_ties
  end

  def count_of_games_by_season

  end

  def average_goals_per_game
    @game_repository.average_goals_per_game

  end

  def average_goals_by_season

  end


  def worst_offense
    @league_repository.worst_offense
  end

  def highest_scoring_visitor
    @league_repository.highest_scoring_visitor
  end

  def highest_scoring_home_team
    @league_repository.highest_scoring_home_team
  end

  def lowest_scoring_visitor
    @league_repository.lowest_scoring_visitor
  end

  def lowest_scoring_home_team
    @league_repository.lowest_scoring_home_team
  end

  def team_info(id)
    @team_repository.team_info(id)
  end

  def best_season(id)
    @team_repository.best_season(id)
  end

  def worst_season(id)
    @team_repository.worst_season(id)
  end

  def average_win_percentage(id)
    @team_repository.average_win_percentage(id)
  end

  def favorite_opponent(id)
    @team_repository.favorite_opponent(id)
  end

  def rival

  end

  def winningest_coach
    @league_repository.winningest_coach(season)
  end

  def worst_coach
    @league_repository.worst_coach(season)
  end

  def most_accurate_team
    @season_repository.most_accurate_team(season)
  end

  def least_accurate_team
    @season_repository.least_accurate_team(season)
  end

  def most_tackles(season_id)
     @season_repository.most_tackles(season_id)
  end

  def fewest_tackles(season_id)
    @season_repository.fewest_tackles(season_id)
  end



end
