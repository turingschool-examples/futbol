require './test/test_helper'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test

  def setup
    @game_path = './data/dummy_game_path.csv'
    @team_path = './data/dummy_team_path.csv'
    @game_teams_path = './data/dummy_game_teams_path.csv'


    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_file_paths
    assert_equal './data/dummy_game_path.csv', @stat_tracker.games
    assert_equal './data/dummy_team_path.csv', @stat_tracker.teams
    assert_equal './data/dummy_game_teams_path.csv', @stat_tracker.game_teams
  end

  def test_read_from_games_file
    expected = [["game_id","team_id","HoA","result","settled_in","head_coach","goals","shots",
    "tackles","pim","powerPlayOpportunities","powerPlayGoals","faceOffWinPercentage","giveaways","takeaways"],
    ["2012030221","3","away","LOSS","OT","John Tortorella","2","8","44","8","3","0","44.8","17","7"],
    ["2012030221","6","home","WIN","OT","Claude Julien","3","12","51","6","4","1","55.2","4","5"]]

    assert_equal expected, @stat_tracker.read_from_games_file
  end

  def test_read_from_teams_file
    expected = [["team_id","franchiseId","teamName","abbreviation","Stadium","link"],
    ["1","23","Atlanta United","ATL","Mercedes-Benz Stadium","/api/v1/teams/1"],
    ["4","16","Chicago Fire","CHI","SeatGeek Stadium","/api/v1/teams/4"]]

    assert_equal expected, @stat_tracker.read_from_teams_file
  end

  def test_read_from_game_teams_file
    expected = [["game_id","team_id","HoA","result","settled_in","head_coach",
    "goals","shots","tackles","pim","powerPlayOpportunities","powerPlayGoals",
    "faceOffWinPercentage","giveaways","takeaways"],
    ["2012030221","3","away","LOSS","OT","John Tortorella","2","8","44","8","3","0","44.8","17","7"],
    ["2012030221","6","home","WIN","OT","Claude Julien","3","12","51","6","4","1","55.2","4","5"]]

    assert_equal expected, @stat_tracker.read_from_game_teams_file
  end

end
