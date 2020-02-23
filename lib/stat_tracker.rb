require_relative "team_collection"
require_relative "game_team_collection"
require_relative "game_collection"

class StatTracker

  def self.from_csv(csv_file_paths)
    self.new(csv_file_paths)
  end

  attr_reader :team_collection, :game_collection, :game_team_collection
  def initialize(files)
    @team_collection = TeamCollection.new(files[:teams])
    @game_collection = GameCollection.new(files[:games])
    @game_team_collection = GameTeamCollection.new(files[:game_teams])
    @team_collection.create_team_collection
    @game_collection.create_game_collection
    @game_team_collection.create_game_team_collection
  end

  def highest_total_score
    @game_collection.total_goals_per_game.max
  end

  def lowest_total_score
    @game_collection.total_goals_per_game.min
  end

  def biggest_blowout
    @game_collection.games.map {|game| (game.away_goals - game.home_goals).abs}.max
  end

  # This only requires game information.
  # It should probably move to game collection eventually.
  def count_of_games_by_season
    games_by_season = @game_collection.all.group_by{|game| game.season}         #games_by_season 1st occurance
    games_by_season.transform_values!{|games| games.length}
  end

  # This only requires game information.
  # It should probably move to game collection eventually.
  def average_goals_per_game
    all_goals = @game_collection.total_goals_per_game
    (all_goals.sum / all_goals.length.to_f).round(2)                            # create module with average method??

  end

  # This only requires game information.
  # It should probably move to game collection eventually.
  def average_goals_by_season
    games_by_season = @game_collection.all.group_by{|game| game.season}         #games_by_season 2nd occurance
    games_by_season.transform_values! do |games|
      all_goals = games.map{|game| game.away_goals + game.home_goals}
      (all_goals.sum/all_goals.length.to_f).round(2)                            #average_calculation
    end
  end

  # This only requires team information.
  # It should probably move to team collection eventually.
  def count_of_teams
    @team_collection.teams.length
  end

  # uses both team and game_team collections
  def best_offense
    games_by_team = @game_team_collection.all.group_by{|game| game.team_id}
    average_goals_by_team = games_by_team.transform_values do |games|
      ((games.map{|game| game.goals}.sum)/games.length.to_f)                      # average calculation
    end
    best_team = average_goals_by_team.key(average_goals_by_team.values.max)
    @team_collection.where_id(best_team)
  end

  # uses both team and game_team collections
  def worst_offense
    games_by_team = @game_team_collection.all.group_by{|game| game.team_id}
    average_goals_by_team = games_by_team.transform_values do |games|
      ((games.map{|game| game.goals}.sum)/games.length.to_f)                      # average calculation
    end
    worst_team = average_goals_by_team.key(average_goals_by_team.values.min)
    @team_collection.where_id(worst_team)
  end

  #uses both team and game collections.
  def best_defense
    goals_against_by_team = {}
    @team_collection.array_by_key(:team_id).each do |team_id|
      goals_against_by_team[team_id] = []
    end
    @game_collection.all.each do |game|
      goals_against_by_team[game.home_team_id] << game.away_goals
      goals_against_by_team[game.away_team_id] << game.home_goals
    end
    goals_against_by_team.transform_values! do |goals|
      goals.sum/goals.length.to_f                                                 # average calcultion
    end
    best_defense = goals_against_by_team.key(goals_against_by_team.values.min)
    @team_collection.where_id(best_defense)
  end

end
