require_relative 'test_helper'

class TeamStatHelperTest < Minitest::Test

  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    @stat_tracker ||= StatTracker.new({games: game_path, teams: team_path, game_teams: game_teams_path})
    @team_stat_helper ||= TeamStatHelper.new(@stat_tracker.game_table, @stat_tracker.team_table, @stat_tracker.game_team_table)
  end


  def test_collect_seasons
    expected = ["20122013", "20172018", "20132014", "20142015", "20152016", "20162017"]
    assert_equal expected, @team_stat_helper.collect_seasons("6").keys
    assert_equal 53, @team_stat_helper.collect_seasons("8")["20122013"].length
    assert_equal 82, @team_stat_helper.collect_seasons("6")["20142015"].length
  end

  def test_collect_wins_per_season
    expected = ["20152016", "20172018", "20132014", "20122013", "20142015", "20162017"]
    assert_equal expected, @team_stat_helper.collect_wins_per_season("28").keys
    assert_equal 19, @team_stat_helper.collect_wins_per_season("53")["20142015"]
    assert_equal 26, @team_stat_helper.collect_wins_per_season("22")["20152016"]
  end

  def test_collect_losses_per_season
    expected = ["20122013", "20152016", "20142015", "20132014", "20162017", "20172018"]
    assert_equal expected, @team_stat_helper.collect_losses_per_season("2").keys
    expected_1 = [30, 63, 62, 56, 55, 48]
    assert_equal expected_1, @team_stat_helper.collect_losses_per_season("22").values
    assert_equal 43, @team_stat_helper.collect_losses_per_season("8")["20162017"]
  end

  def test_games_for_team_id
    assert_equal 1014, @team_stat_helper.games_for_team_id("19").length
    assert_equal 926, @team_stat_helper.games_for_team_id("1").length
    assert_equal 656, @team_stat_helper.games_for_team_id("53").length
  end

  def test_add_game_wins_to_win_count
    game_table = @stat_tracker.game_table
    info = []
    count = 0
    game_table.values.each do |game|
      break if count == 5
      if game.away_team_id == 6
        info << game
        count += 1
      end
    end
    assert_equal 5, @team_stat_helper.add_game_wins_to_win_count("6", info)
    # stub game_table to be the exact values
    # hash with 5 key/value pairs only.
    # values are game object. So away/home_ids and away/home_goals.
  end

  def test_add_game_losses_to_loss_count
    game_table = @stat_tracker.game_table
    info = []
    count = 0
    game_table.values.each do |game|
      break if count == 5
      if game.away_team_id == 6
        info << game
        count += 1
      end
    end
    assert_equal 0, @team_stat_helper.add_game_losses_to_loss_count("6", info)
  end

  def test_games_for_team_id
    assert_equal 1020, @team_stat_helper.games_for_team_id("6")
    assert_equal 656, @team_stat_helper.games_for_team_id("53")
  end

  def test_process_game_result
    skip
    game_with_away_team_win = GameTeam.new({
      "faceOffWinPercentage" => 62,
      "game_id" => 2016030231,
      "giveaways" => 6,
      "goals" => 2,
      "head_coach" => "Peter Laviolette",
      "hoa" => "away",
      "pim" => 4,
      "powerPlayGoals" => 2,
      "powerPlayOpportunities" => 3,
      "result" => "LOSS",
      "settled_in" => "REG",
      "shots" => 8,
      "tackles" => 34,
      "takeaways" => 6,
      "team_id" => 6
      })
    opponent_input_hash = {}
    game_input_hash = {}
    @team_stat_helper.process_game_result("6", game_with_away_team_win, game_input_hash, game_input_hash)
    require "pry"; binding.pry
    assert_equal 1, game_input_hash["6"]
    # assert_equal {},
    # require "pry"; binding.pry
  end

end
