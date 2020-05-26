require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_collection'
require './lib/game'
require 'pry'

class GameCollectionTest < Minitest::Test

  def test_it_exists
    game = Game.new({
      :id => "2012030221",
      :season => "20122013",
      :type => "Postseason",
      :date_time => "5/16/13",
      :away_team_id => 3,
      :home_team_id => 6,
      :away_goals => 2,
      :home_goals => 3,
      :venue => "Toyota Stadium"})
    game_collection = GameCollection.new([game])
    assert_instance_of GameCollection, game_collection
  end

  def test_it_can_return_games
    game1 = Game.new({
      :id => "2012030221",
      :season => "20122013",
      :type => "Postseason",
      :date_time => "5/16/13",
      :away_team_id => 3,
      :home_team_id => 6,
      :away_goals => 2,
      :home_goals => 3,
      :venue => "Toyota Stadium"})
    game2 = Game.new({
      :id => "2012030222",
      :season => "20122014",
      :type => "Postseason",
      :date_time => "5/17/13",
      :away_team_id => 2,
      :home_team_id => 4,
      :away_goals => 1,
      :home_goals => 2,
      :venue => "Pepsi Stadium"})
      game_collection = GameCollection.new([game1, game2])
    assert_equal [game1, game2], game_collection.all
  end

end
