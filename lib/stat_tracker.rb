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

  def winningest_team
    teams_collection.associate_team_id_with_team_name(game_teams_collection.winningest_team_id)
  end

  def best_fans
    teams_collection.associate_team_id_with_team_name(game_teams_collection.best_fans_team_id)
  end

  def worst_fans
    teams_collection.associate_multi_team_id_with_team_name(game_teams_collection.worst_fans_team_id)
  end

  def most_tackles(season_id)
    #narrow down the games i can work with based on season
    use_games = games_collection.narrow_down_by_season(season_id)
    x = use_games.map do |game|
      game.game_id
    end

    game_ids = game_teams_collection.game_teams.find_all do |gameteam|
      x.any? do |game|
        gameteam.game_id == game
      end
    end

    most_tackles = game_ids.max_by do |game|
      game.tackles
    end

    # x = use_games.find do |game|
    #   game.game_id == game_teams_collection.most_tackles_game_id
      #problem with this method is it never finds the game id with the mos
      #tackless since it does not exists in the collection

      #if i can find all the game ids in the game team collection for the season
      #i can then use a method that will find the most tackles
      # for that collection of game teams and spit out the id
    # end

    # y = game_teams_collection.game_teams.find do |gameteam|
    #   gameteam.game_id == x.game_id
    # end

    teams_collection.associate_team_id_with_team_name(most_tackles.team_id)
  end

  def fewest_tackles(season_id)
    use_games = games_collection.narrow_down_by_season(season_id)
    x = game_teams_collection.game_teams.find_all do |gameteams|
      use_games.each do |game|
        gameteams.game_id == game.game_id
      end
    end

    fewest_tackles = x.min_by do |team|
      team.tackles
    end

    teams_collection.associate_team_id_with_team_name(fewest_tackles.team_id)
  end
end
