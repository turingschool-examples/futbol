require_relative 'game'
require_relative 'team'
require_relative 'game_team'
require 'CSV'

class StatTracker

  def initialize(data)
    @games = CSV.read(data[:games], headers: true, header_converters: :symbol).map {|row| Game.new(row) }
    @teams = CSV.read(data[:teams], headers: true, header_converters: :symbol).map {|row| Team.new(row) }
    @game_teams = CSV.read(data[:game_teams], headers: true, header_converters: :symbol).map {|row| GameTeam.new(row) }
  end

  def self.from_csv(data)
    new(data)
    
  end





  #game_stats
  def highest_total_score
    output = @games.max do |game1, game2|
      (game1.away_goals + game1.home_goals) <=> (game2.away_goals + game2.home_goals)
    end
    return output.away_goals + output.home_goals
  end

  def lowest_total_score


  end

  def percentage_ties

  end

  def count_of_games_by_season

  end

  #league_stats

  #season_stats
end