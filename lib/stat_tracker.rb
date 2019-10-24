require './lib/game_collection'
require './lib/team_collection'
require './lib/game_team_collection'
require 'pry'

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
    @games = GameCollection.new(@game_path)
    @teams = TeamCollection.new(@team_path)
    @game_teams = GameTeamCollection.new(@game_teams_path)
  end

  def highest_total_score
    highest_total = @games.games.max_by{ |game| game.away_goals + game.home_goals }
    highest_total.away_goals + highest_total.home_goals
  end

  def biggest_blowout
    blowout = @games.games.max_by { |game| (game.home_goals - game.away_goals).abs }
    (blowout.home_goals - blowout.away_goals).abs
  end

  def percent_home_wins
    h_win = @games.games.count { |game| game.away_goals < game.home_goals }
    (h_win * 100.00 / @games.games.length).to_f
  end

  def percent_visitor_wins
    v_win = @games.games.count { |game| game.away_goals > game.home_goals }
    (v_win * 100.00 / @games.games.length).to_f
  end

  def percent_ties
    ties = @games.games.count { |game| game.away_goals == game.home_goals }
    (ties * 100.00 / @games.games.length).to_f
  end

end
