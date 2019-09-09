require './test/test_helper'
require './lib/game'
require './lib/team'
require './lib/league'
require './lib/season'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test

  def setup
    game_path = './data/dummy_data/games.csv'
    team_path = './data/dummy_data/teams.csv'
    game_team_path = './data/dummy_data/game_teams.csv'

    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_team_path
    }
  end

  def test_it_exists
    stat_tracker = StatTracker.new
    assert_instance_of StatTracker, stat_tracker
  end

  def test_it_has_attributes
  end

  def test_it_create_data_from_csv
    stat_tracker = StatTracker.from_csv(@locations)

    assert_equal 18, stat_tracker.games.length
    stat_tracker.games.each do |_, game|
      assert_equal false, game.home_team.empty?
      assert_equal false, game.away_team.empty?
    end

    assert_equal 3, stat_tracker.teams.length
    stat_tracker.teams.each { |_, team| assert_equal false, team.games.empty? }

    assert_equal 2, stat_tracker.seasons.length
    stat_tracker.seasons.values do |season| 
      assert_equal 3, season.teams.length
      season.teams.values.each do |team|
        assert_equal true, stat_tracker.teams[team.id].length > team.games.length
      end
    end
  end

  def test_creates_team_hash_from_line
    team_line = {
      "team_id" => "3",
      "franchiseId" => "10",
      "teamName" => "Houston Dynamo",
      "abbreviation" => "HOU",
      "Stadium" => "BBVA Stadium",
      "link" => "/api/v1/teams/3"
    }
    
    expected_hash = {
      team_id:      3,
      franchiseId:  10,
      teamName:     "Houston Dynamo",
      abbreviation: "HOU",
      Stadium:      "BBVA Stadium",
      link:         "/api/v1/teams/3",
      games:        {}
    }
    stat_tracker = StatTracker.new
    assert_equal expected_hash, StatTracker.create_team_hash(team_line)
  end

  def test_creates_game_hash_from_line
    game_line = {
      "game_id" => "2012030221",
      "season" => "20122013",
      "type" => "Postseason",
      "date_time" => "5/16/13",
      "away_team_id" => "3",
      "home_team_id" => "6",
      "away_goals" => "2",
      "home_goals" => "3",
      "venue" => "Toyota Stadium",
      "venue_link" => "/api/v1/venues/null"
    }

    expected_hash = {
      id:         2012030221,
      season:     20122013,
      type:       "Postseason",
      date_time:  "5/16/13",
      venue:      "Toyota Stadium",
      venue_link: "/api/v1/venues/null"
    }
    stat_tracker = StatTracker.new
    assert_equal expected_hash, StatTracker.create_game_hash(game_line)
  end

  def test_creates_game_teams_hash_from_line
    game_team_line = {
      "game_id" => "2013030143",
      "team_id" => "3",
      "HoA" => "away",
      "result" => "WIN",
      "settled_in" => "REG",
      "head_coach" => "Alain Vigneault",
      "goals" => "3",
      "shots" => "5",
      "tackles" => "39",
      "pim" => "12",
      "powerPlayOpportunities" => "4",
      "powerPlayGoals" => "0",
      "faceOffWinPercentage" => "45.9",
      "giveaways" => "9",
      "takeaways" => "6"
    }

    expected_hash = {
      id:                       3,
      hoa:                      "away",
      result:                   "WIN",
      head_coach:               "Alain Vigneault",
      goals:                    3,
      shots:                    5,
      tackles:                  39,
      pim:                      12,
      power_play_opportunities: 4,
      power_play_goals:         0,
      face_off_win_percentage:  45.9,
      giveaways:                9,
      takeaways:                6
    }

    stat_tracker = StatTracker.new
    assert_equal expected_hash, StatTracker.create_game_team_hash(game_team_line)
  end

end

# season_hash = {}
# seasons.each do |season_id, season|
#   season_hash[season_id] = season.teams.values.sum_by { |team| games.length }
# end
