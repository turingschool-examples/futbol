require_relative 'test_helper'

class LeagueStatHelperTest < Minitest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    @stat_tracker ||= StatTracker.from_csv({games: game_path, teams: team_path})
    @league_stat_helper ||= LeagueStatHelper.new(@stat_tracker.game_table, @stat_tracker.team_table)
  end

  def test_team_name_ids
    assert_equal 32, @league_stat_helper.team_name_ids.length
    assert_equal "17", @league_stat_helper.team_name_ids["LA Galaxy"]
  end

  def test_add_goals_to_season_average
    @league_stat_helper.team_season_average

    game_with_this_team_as_away_team = Game.new({
            "game_id" => "1",
             "season" => "20122013",
               "type" => "fun",
          "date_time" => "summer",
       "away_team_id" => "17",
       "home_team_id" => "3",
         "away_goals" => "5",
         "home_goals" => "4",
              "venue" => "Kali's house",
         "venue_link" => "the internet"
      })

    input_hash = {}
    @league_stat_helper.add_goals_to_season_average(input_hash, "LA Galaxy", "17", game_with_this_team_as_away_team)
    assert_equal 5, input_hash["LA Galaxy"]
  end

  def test_team_season_average
    results = @league_stat_helper.team_season_average
    assert_equal 2.06, results["LA Galaxy"].round(2)
    assert_equal 2.21, results["Portland Timbers"].round(2)
  end

  def test_add_goals_to_away_average
    game_with_this_team_as_away_team = Game.new({
           "game_id" => "1",
            "season" => "20122013",
              "type" => "fun",
         "date_time" => "summer",
      "away_team_id" => "17",
      "home_team_id" => "3",
        "away_goals" => "4",
        "home_goals" => "3",
             "venue" => "Kali's house",
        "venue_link" => "the internet"
      })

    input_hash = {}
    @league_stat_helper.add_goals_to_away_average(input_hash, "Toronto FC", "17", game_with_this_team_as_away_team)
    assert_equal 4, input_hash["Toronto FC"]
  end

  def test_team_away_average
    results = @league_stat_helper.team_away_average
    assert_equal 2.01, results["New York City FC"].round(2)
    assert_equal 2.02, results["Sky Blue FC"].round(2)
  end

  def test_add_goals_to_home_average
    game_with_this_team_as_home_team = Game.new({
           "game_id" => "1",
            "season" => "20122013",
              "type" => "fun",
         "date_time" => "summer",
      "away_team_id" => "17",
      "home_team_id" => "3",
        "away_goals" => "6",
        "home_goals" => "5",
             "venue" => "Kali's house",
        "venue_link" => "the internet"
      })

      input_hash = {}
      @league_stat_helper.add_goals_to_home_average(input_hash, "Toronto FC", "3", game_with_this_team_as_home_team)
      assert_equal 5, input_hash["Toronto FC"]
    end

  def test_team_home_average
    results = @league_stat_helper.team_home_average
    assert_equal 2.22, results["Portland Timbers"].round(2)
    assert_equal 2.39, results["Sporting Kansas City"].round(2)
  end

end
