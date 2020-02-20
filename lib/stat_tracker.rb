require "./lib/team_collection"
require "./lib/game_team_collection"
require "./lib/game_collection"

class StatTracker

  def self.from_csv(csv_file_paths)
    self.new(csv_file_paths)

  end

  attr_reader :team_collection, :game_collection, :game_team_collection
  def initialize(files)
    @team_collection = TeamCollection.new(files[:team])
    @game_collection = GameCollection.new(files[:game])
    @game_team_collection = GameTeamCollection.new(files[:game_team])
    @team_collection.create_team_collection
    @game_collection.create_game_collection
    @game_team_collection.create_game_team_collection
  end

  def highest_total_score
    highest_scoring_team = @game_collection.games.max_by do |game|
      game.away_goals + game.home_goals
    end
    highest_scoring_team.away_goals + highest_scoring_team.home_goals
  end

  def lowest_total_score
    lowest_scoring_team = @game_collection.games.min_by do |game|
      game.away_goals + game.home_goals
    end
    lowest_scoring_team.away_goals + lowest_scoring_team.home_goals
  end
end
