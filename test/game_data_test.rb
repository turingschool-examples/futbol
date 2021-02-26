require './test/test_helper'

class GameDataTest < Minitest::Test
  def setup
    @game_path = ''

    locations = {
      games: @game_path
    }

    @stat_tracker = mock

    @game_data = GameData.new(locations[:games], @stat_tracker)
    # binding.pry

    # @game7 = Game.new({
    #                 game_id: 2015030133,
    #                 season: 20152016,
    #                 type: "Postseason",
    #                 date_time: "4/18/16",
    #                 away_team_id: 15,
    #                 home_team_id: 4,
    #                 away_goals: 4,
    #                 home_goals: 1,
    #                 venue: "SeatGeek Stadium",
    #                 venue_link: "/api/v1/venues/null"
    #               })
    #
    # @game8 = Game.new({
    #               game_id: 2015030131,
    #               season: 20152016,
    #               type: "Postseason",
    #               date_time: "4/24/16",
    #               away_team_id: 11,
    #               home_team_id: 3,
    #               away_goals: 2,
    #               home_goals: 5,
    #               venue: "SeatGeek Stadium",
    #               venue_link: "/api/v1/venues/null"
    #             })
    #
    # @game9 = Game.new({
    #               game_id: 2015030134,
    #               season: 20152016,
    #               type: "Postseason",
    #               date_time: "4/30/16",
    #               away_team_id: 17,
    #               home_team_id: 5,
    #               away_goals: 6,
    #               home_goals: 2,
    #               venue: "SeatGeek Stadium",
    #               venue_link: "/api/v1/venues/null"
    #             })
  end

  def test_it_exists
    assert_instance_of GameData, @game_data
    assert mock, @stat_tracker
  end

  def test_game_with_highest_total_score
    assert_equal 11, @game_data.game_with_highest_total_score
  end

  def test_game_with_lowest_total_score
    assert_equal 0, @game_data.game_with_lowest_total_score
  end

  # def test_home_wins_array
  # end
end
