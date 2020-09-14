require_relative 'test_helper'

class LeagueStatHelperTest < Minitest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    @stat_tracker ||= StatTracker.from_csv({games: game_path, teams: team_path})
    @league_stat_helper ||= LeagueStatHelper.new(@stat_tracker.game_table, @stat_tracker.team_table)
    # <Game:0x00007fcd112ffbf8
       # @away_goals=2,
       # @away_team_id=3,
       # @date_time="5/16/13",
       # @game_id=2012030221,
       # @home_goals=3,
       # @home_team_id=6,
       # @season="20122013",
       # @type="Postseason",
       # @venue="Toyota Stadium",
       # @venue_link="/api/v1/venues/null">
  end

  def test_team_name_ids
    assert_equal 32, @league_stat_helper.team_name_ids.length
    assert_equal "17", @league_stat_helper.team_name_ids["LA Galaxy"]
  end

  def test_add_goals_to_season_average
    @league_stat_helper.team_season_average

    game_with_this_team_as_away_team = Game.new({
        "game_id"=> "1",
        "season"=> "20122013",
        "type"=> "fun",
        "date_time"=> "summer",
        "away_team_id"=> "17",
        "home_team_id"=> "3",
        "away_goals" => "5",
        "home_goals"=> "4",
        "venue"=> "Kali's house",
        "venue_link"=> "the internet"
      })

    expected = {}
    input_hash = {}
    @league_stat_helper.add_goals_to_season_average(input_hash, "LA Galaxy", "17", game_with_this_team_as_away_team)
    assert_equal 5, input_hash["LA Galaxy"]
  end

end
