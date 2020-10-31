require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_team_collection'
require './lib/stat_tracker'
require 'mocha/minitest'

class GameTeamCollectionTest < Minitest::Test
  def setup
    game_path       = './data/games.csv'
    team_path       = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
                  games: game_path,
                  teams: team_path,
                  game_teams: game_teams_path
                }

    stat_tracker          = mock('stat_tracker')
    @game_team_collection = GameTeamCollection.new(game_teams_path, stat_tracker)
  end

  def test_it_exists_and_has_attributes
    assert_instance_of GameTeamCollection, @game_team_collection
  end
  #FROM THE GAMES STATS SECTION
  # def test_it_calls_percentage_of_games_w_home_team_win
  #   assert_equal 45.23, @gamestats.percentage_home_wins
  # end
  #
  # def test_it_calls_percentage_of_games_w_away_team_win
  #   assert_equal 45.23, @gamestats.percentage_away_wins
  # end
  #
  # def test_it_calls_percentage_of_games_tied
  #   assert_equal 11.55, @gamestats.percentage_ties
  # end
  #
  # def test_total_percentages_equals_100
  #   assert_equal 100, (@gamestats.percentage_home_wins +
  #                      @gamestats.percentage_away_wins +
  #                      @gamestats.percentage_ties)
  # end
end
