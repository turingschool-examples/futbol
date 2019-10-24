require './lib/game_collection'
require './lib/team_collection'
require './lib/game_teams_collection'
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

  def percent_visitor_wins
      v_win = games.game_objs.count do |game|
        game.away_goals > game.home_goals
      end.to_f
        (v_win * 100 / games.game_objs.length).to_f 

  end

      # x = game.away_goals > game.home_goals
      # y = game.away_goals + game.home_goals
      # games.game_objs.reduce do |result, total|
      #   result / total

      # binding.pry
      # v_win / v_win.length
    #   total trues / v_win.count
    # end
end
