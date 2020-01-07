require 'minitest/autorun'
require 'minitest/pride'
require './lib/game'
require './lib/score_totals'

class ScoreTotalsTest < Minitest::Test
  def setup
    @game = Game.new({
      :game_id => "201203022015",
      :season => "20192020",
      :type => "Preseason",
      :date_time => "12/16/19",
      :away_team_id => "3",
      :home_team_id => "10",
      :away_goals => 4,
      :home_goals => 1,
      :venue => "Mercedes Benz Superdome"
      })
    @game_path = './test/dummy/games_trunc.csv'
    @games = Game.from_csv(@game_path)
    @csv_game = @games[4]
  end
end
