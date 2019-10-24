require './lib/game_collection'
require './lib/team_collection'
require './lib/game_teams_collection'

class StatTracker

  def self.from_csv(locations)
    game_path = locations[:games]
    team_path = locations[:teams]
    game_teams_path = locations[:game_teams]

    StatTracker.new(game_path, team_path, game_teams_path)
  end

  def initialize(game_path, team_path, game_teams_path)
    @game_path = game_path
    @team_path = team_path
    @game_teams_path = game_teams_path
  end

  def games
    GameCollection.new(@game_path)
  end

  def teams
    TeamCollection.new(@team_path)
  end

  def game_teams
    GameTeamsCollection.new(@game_teams_path)
  end

  def highest_total_score
    highest_total = games.game_objs.max_by{ |game| game.away_goals + game.home_goals }
    highest_total.away_goals + highest_total.home_goals
  end

  def lowest_total_score
    lowest_total = games.game_objs.min_by{ |game| game.away_goals + game.home_goals }
    lowest_total.away_goals + lowest_total.home_goals
  end

# Average number of goals scored in a game organized in a hash with season
# names (e.g. 20122013) as keys and a float representing the average number of
# goals in a game for that season as a key (rounded to the nearest 100th)
  def average_goals_by_season
    require 'pry'; binding.pry
    avg_per_season = games.game_objs.map do |game|
      game.away_goals + game.home_goals

    # games.game_objs.reduce({}) do |avg_goals_by_season, season|
    #   avg_goals_by_season[season] =
    #
  end
end

