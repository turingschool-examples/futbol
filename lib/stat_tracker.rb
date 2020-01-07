require 'csv'
require_relative 'games_collection'
require_relative 'game_teams_collection'
require_relative 'teams_collection'

class StatTracker
  attr_reader :games_path, :teams_path, :game_teams_path

  def self.from_csv(file_paths)
    games_path = file_paths[:games]
    teams_path = file_paths[:teams]
    game_teams_path = file_paths[:game_teams]

    StatTracker.new(games_path, teams_path, game_teams_path)
  end

  def initialize(games_path, teams_path, game_teams_path)
    @games_path = games_path
    @teams_path = teams_path
    @game_teams_path = game_teams_path
  end

  def game_teams_collection
    GameTeamsCollection.new(@game_teams_path)
  end

  def games_collection
    GamesCollection.new(@games_path)
  end

  def teams_collection
    TeamsCollection.new(@teams_path)
  end

  def highest_total_score
    games_collection.highest_total_score
  end

  def lowest_total_score
    games_collection.lowest_total_score
  end

  def biggest_blowout
    games_collection.biggest_blowout
  end

  def percentage_home_wins
    games_collection.percentage_home_wins
  end

  def percentage_visitor_wins
    games_collection.percentage_visitor_wins
  end

   def average_goals_per_game
    games_collection.average_goals_per_game
   end

  def average_goals_by_season
    games_collection.average_goals_by_season
  end

  def count_of_games_by_season
    games_collection.count_of_games_by_season
  end

  def percentage_ties
    games_collection.percentage_ties
  end

  def count_of_teams
    teams_collection.count_of_teams
  end

  def best_offense
    teams_collection.associate_team_id_with_team_name(games_collection.best_offense_id)
  end

  def worst_offense
    teams_collection.associate_team_id_with_team_name(games_collection.worst_offense_id)
  end

  def best_defense
    teams_collection.associate_team_id_with_team_name(games_collection.best_defense_id)
  end

  def worst_defense
    teams_collection.associate_team_id_with_team_name(games_collection.worst_defense_id)
  end

  def highest_scoring_visitor
    teams_collection.associate_team_id_with_team_name(game_teams_collection.highest_scoring_visitor)
  end

  def highest_scoring_home_team
    teams_collection.associate_team_id_with_team_name(game_teams_collection.highest_scoring_home_team)
  end

  def lowest_scoring_visitor
    teams_collection.associate_team_id_with_team_name(game_teams_collection.lowest_scoring_visitor)
  end

  def lowest_scoring_home_team
    teams_collection.associate_team_id_with_team_name(game_teams_collection.lowest_scoring_home_team)
  end

  # def biggest_bust(season_id)
  #   teams_collection.associate_team_id_with_team_name(game_teams_collection.biggest_bust_id(season_id))
  # end
  #
  # def biggest_surprise(season_id)
  #   teams_collection.associate_team_id_with_team_name(game_teams_collection.biggest_surprise_id(season_id))
  # end
  #
  # def winningest_coach(season_id)
  #   game_teams_collection.winningest_coach_name(season_id)
  # end
  #
  # def worst_coach(season_id)
  #   game_teams_collection.worst_coach_name(season_id)
  # end
  def biggest_team_blowout(teamid)
    games_collection.biggest_team_blowout_num(teamid)
  end

  def head_to_head(teamid)
    names_percent = {}
    game_teams_collection.head_to_head_hash(teamid).each do |key, value|
      names_percent[teams_collection.associate_team_id_with_team_name(key)] = value.round(2)
    end
    names_percent
  end

end
