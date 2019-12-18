require_relative '../test_helper'
require "minitest/autorun"
require 'minitest/pride'
require './lib/game'
require './lib/game_collection'

class GameCollectionTest < Minitest::Test
  def setup
<<<<<<< HEAD
    @game_collection = GameCollection.new("./test/fixtures/games.csv")
    @game = @game_collection.games.first
=======
    csv_file_path = './test/fixtures/games.csv'
    @game_collection = GameCollection.new(csv_file_path)
    game_info = {:game_id => "2012030221",
                 :season => "20122013",
                 :type => "Postseason",
                 :date_time => "5/16/13",
                 :away_team_id => "3",
                 :home_team_id => "6",
                 :away_goals => "2",
                 :home_goals => "3",
                 :venue => "Toyota Stadium"}
    @first_game = @game_collection.games.first
>>>>>>> 0e05bb735e64f8567bb3885d8bfd5e9b0e68baae
  end

  def test_it_exists
    assert_instance_of GameCollection, @game_collection
  end

  def test_it_can_create_games
    assert_instance_of Array, @game_collection.games
    @game_collection.games.each do |game|
      assert_instance_of Game, game
    end
  end
end
