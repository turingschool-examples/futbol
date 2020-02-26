require_relative 'calculable'
require_relative 'hashable'


class SeasonStatistics
  include Calculable
  include Hashable

  def initialize
    @games = Game.all
    @teams = Team.all
    @game_teams = GameTeam.all
  end

  def find_team_names(team_id)
    match_team = @teams.find do |team|
      team.team_id == team_id
    end
    match_team.team_name
  end

  #reduce on top level of nested loop
  # goes through all of inner loop before outer loop will move to next element
  # value_by_key method name

  # my_hash = Hash.new do |my_hash, key|
  #   my_hash[key] = []
  # end

  # def game_game_teams_hash
  #   x = @games.reduce({}) do |game_hash, game|
  #     @game_teams.each do |game_team|
  #       game_hash[game_team] = game
  #       # require "pry"; binding.pry
  #     end
  #     game_hash
  #   end
  #   # require "pry"; binding.pry
  # end

  def game_types_and_teams
    @games.reduce({}) do |game_hash, game|
      game_hash[game.away_team_id] = Hash.new{ |my_hash, key| my_hash[key] = [] } if game_hash[game.away_team_id].nil?
      game_hash[game.home_team_id] = Hash.new{ |my_hash, key| my_hash[key] = [] } if game_hash[game.home_team_id].nil?

      if game.type == "Postseason"
        game_hash[game.away_team_id][:post] << game.game_id
        game_hash[game.home_team_id][:post] << game.game_id
      elsif game.type == "Regular Season"
        game_hash[game.away_team_id][:regular] << game.game_id
        game_hash[game.home_team_id][:regular] << game.game_id
      end
      game_hash
    end
  end

  def game_team_post_results
    game_team_post_results = {}

    @game_teams.each do |game_team|
      game_team_post_results[game_team.team_id] = [] if game_team_post_results[game_team.team_id].nil?

      if game_types_and_teams[game_team.team_id][:post].include?(game_team.game_id)
        game_team_post_results[game_team.team_id] << game_team.result
      end
    end
    game_team_post_results
  end

  def game_team_regular_results
    game_team_regular_results = {}

    @game_teams.each do |game_team|
      game_team_regular_results[game_team.team_id] = [] if game_team_regular_results[game_team.team_id].nil?

      if game_types_and_teams[game_team.team_id][:regular].include?(game_team.game_id)
        game_team_regular_results[game_team.team_id] << game_team.result
      end
    end
    game_team_regular_results
  end

  def percent_wins_regular
    game_team_regular_results.transform_values do |results|
      wins = (results.find_all { |result| result == "WIN"})
      percent(wins.length.to_f, results.length)
    end
  end

  def percent_wins_post
    game_team_post_results.transform_values do |results|
      wins = (results.find_all { |result| result == "WIN"})
      percent(wins.length.to_f, results.length)
    end
  end

  def biggest_bust
    difference = percent_wins_regular.merge(percent_wins_post) do |team_id, reg, post|
      (reg - post).round(2)
    end

    find_team_names(hash_key_max_by(difference))
  end

  def biggest_surprise
    increase = percent_wins_regular.merge(percent_wins_post) do |team_id, reg, post|
      (post - reg).round(2)
    end
    find_team_names(hash_key_max_by(increase))
  end

end


require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/minitest'
require './lib/game'
require './lib/team'
require './lib/game_team'

class SeasonStatisticsTest < Minitest::Test

  def setup
    Game.create_games('./test/fixtures/games_truncated.csv')
    Team.create_teams('./test/fixtures/teams_truncated.csv')
    GameTeam.create_game_teams('./test/fixtures/game_teams_biggest_bust.csv')
    @season_stats = SeasonStatistics.new
  end

  def test_it_exists
    assert_instance_of SeasonStatistics, @season_stats
  end

  def test_it_can_get_game_types_and_teams_hash
    expected = {
      :regular=>[2012020205, 2013021119],
      :post=>[2012030121, 2012030122, 2012030123, 2012030124, 2012030125]
    }
    assert_equal expected, @season_stats.game_types_and_teams[9]

  end

  def test_it_can_return_post_results
    assert_equal ["TIE", "LOSS", "WIN"], @season_stats.game_team_post_results[9]
  end

  def test_it_can_return_regular_results
    assert_equal ["LOSS", "WIN"], @season_stats.game_team_regular_results[9]
  end

  def test_it_can_return_percent_post_wins
    assert_equal 0.33, @season_stats.percent_wins_post[9]
  end

  def test_it_can_return_percent_regular_wins
    assert_equal 0.50, @season_stats.percent_wins_regular[9]
  end

  def test_it_can_tell_biggest_bust
    @season_stats.stubs(:percent_wins_regular).returns({3=>0.66, 4=>0.75})
    @season_stats.stubs(:percent_wins_post).returns({3=>0.33, 4=>0.25})

    assert_equal "Chicago Fire", @season_stats.biggest_bust
  end

  def test_it_can_tell_biggest_surprise
    @season_stats.stubs(:percent_wins_regular).returns({3=>0.66, 4=>0.75})
    @season_stats.stubs(:percent_wins_post).returns({3=>0.33, 4=>0.25})

    assert_equal "Houston Dynamo", @season_stats.biggest_surprise
  end
end
