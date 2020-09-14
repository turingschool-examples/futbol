require './test/test_helper'
require './lib/stat_tracker'

class TeamStatisticsTest < Minitest::Test
  def setup
    locations = {
      games: './fixtures/team_stats_fixture_games.csv',
      teams: './data/teams.csv',
      game_teams: './fixtures/team_stats_fixture_game_teams.csv'
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  # def test_team_info
  #   expected ={
  #          "team_id" => "1",
  #     "franchise_id" => "23",
  #        "team_name" => "Atlanta United",
  #     "abbreviation" => "ATL",
  #             "link" => "/api/v1/teams/1"
  #   }
  #   actual = @stat_tracker.team_info('1')
  #
  #   assert_equal expected, actual
  # end

  # def test_it_can_find_games_by_team_id
  #   games = @stat_tracker.games
  #   expected = [games[11], games[12], games[13], games[14], games[15], games[16], games[17], games[28], games[45]]
  #
  #   assert_equal expected, @stat_tracker.games_by_team_id('26')
  #
  #   different_games = [games[0], games[1], games[28], games[2], games[3], games[13], games[4], games[5]]
  #   expected = [games[28], games[13]]
  #
  #   assert_equal expected, @stat_tracker.games_by_team_id('26', different_games)
  # end

  def test_it_can_separate_games_by_season_id
    season_20122013 = @stat_tracker.games.select do |game|
      game.season == "20122013"
    end
    season_20162017 = @stat_tracker.games.select do |game|
      game.season == "20162017"
    end
    season_20132014 = @stat_tracker.games.select do |game|
      game.season == "20132014"
    end
    expected = {
      "20122013" => season_20122013,
      "20162017" => season_20162017,
      "20132014" => season_20132014
    }
    actual = @stat_tracker.separate_games_by_season_id

    assert_equal expected, actual

    games = @stat_tracker.games[0..10]
    expected = {
      "20122013" => games[0..6],
      "20162017" => games[7..-1]
    }
    actual = @stat_tracker.separate_games_by_season_id(games)

    assert_equal expected, actual
  end

  # def test_it_can_find_game_stats_by_team_id
  #   team_stats = @stat_tracker.game_teams
  #   expected = [team_stats[0], team_stats[2], team_stats[5], team_stats[7], team_stats[8], team_stats[11], team_stats[12]]
  #
  #   assert_equal expected, @stat_tracker.game_stats_by_team_id("17")
  # end

  # def test_it_can_generate_an_array_of_game_ids_from_an_array_of_games
  #   games = @stat_tracker.games_by_team_id("17")
  #   expected = ["2012030161", "2012030162", "2012030163", "2012030164", "2012030165", "2012030166", "2012030167"]
  #
  #   assert_equal expected, @stat_tracker.games_to_game_ids(games)
  # end

  # def test_it_can_find_most_goals_scored_by_team
  #   assert_equal 3, @stat_tracker.most_goals_scored("17")
  #   # Add more assertions?
  # end
  #
  # def test_it_can_find_fewest_goals_scored_by_team
  #   assert_equal 0, @stat_tracker.fewest_goals_scored("17")
  #   # Add more assertions?
  # end

  # def test_it_can_count_total_games_wins_losses_and_ties_for_a_team
  #   expected = {
  #     total: 9,
  #     wins: 5,
  #     ties: 1,
  #     losses: 3
  #   }
  #   actual = @stat_tracker.result_counts_by_team_id("26")
  #
  #   assert_equal expected, actual
  #   # What if one or multiple of the categories is 0?
  # end

  # def test_it_can_calculate_average_win_percentage_for_a_team
  #   assert_equal 0.56, @stat_tracker.average_win_percentage("26")
  #   assert_equal 0.45, @stat_tracker.average_win_percentage("24")
  # end

  def test_it_can_find_team_results_by_season
    game_teams = @stat_tracker.game_teams
    actual = @stat_tracker.results_by_season("20")
    expected = {
      "20162017" => [game_teams[14], game_teams[16], game_teams[19], game_teams[21]]
    }
    assert_equal expected, actual
  end

  def test_it_can_find_season_totals
    expected = {"20122013"=>{:total=>10, :wins=>5, :average=>0.5}, "20162017"=>{:total=>18, :wins=>8, :average=>0.44}, "20132014"=>{:total=>23, :wins=>10, :average=>0.43}}
    actual = @stat_tracker.season_totals(@stat_tracker.results_by_season("24"))

    assert_equal expected, actual
  end

  def test_it_can_find_a_teams_best_season
    assert_equal "20122013", @stat_tracker.best_season("24")
    # Add more assertions?
  end

  def test_it_can_find_a_teams_worst_season
    assert_equal "20132014", @stat_tracker.worst_season("24")
    # Add more assertions?
  end

  # def test_it_can_generate_a_hash_of_opponent_game_teams
  #   teams = @stat_tracker.teams
  #   @stat_tracker.stubs(:games_to_game_ids).returns("2012030163")
  #   @stat_tracker.stubs(:teams).returns([teams[7], teams[17]])
  #   expected = {
  #     "24" => { game_data: [@stat_tracker.game_teams[4]] }
  #   }
  #   actual = @stat_tracker.opponent_game_teams('17')
  #
  #   assert_equal expected, actual
  # end

  # def test_it_can_generate_opponent_win_stats
  #   value = {
  #     "24" => { game_data: [@stat_tracker.game_teams[4]] }
  #   }
  #   @stat_tracker.stubs(:opponent_game_teams).returns(value)
  #   expected = {
  #     "24" => {
  #       game_data: [@stat_tracker.game_teams[4]],
  #       total: 1,
  #       wins:  1,
  #       win_percent: 1
  #     }
  #   }
  #   actual = @stat_tracker.opponent_win_stats('17')
  #
  #   assert_equal expected, actual
  # end

  def test_it_can_find_a_teams_favorite_opponent
    locations2 = {
      games: './data/games.csv',
      game_teams: './data/game_teams.csv',
      teams: './data/teams.csv'
    }
    stats = StatTracker.from_csv(locations2)

    assert_equal "DC United", stats.favorite_opponent("18")
  end

  def test_it_can_find_a_teams_rival
    locations2 = {
      games: './data/games.csv',
      game_teams: './data/game_teams.csv',
      teams: './data/teams.csv'
    }
    stats = StatTracker.from_csv(locations2)

    actual = stats.rival("18")

    assert (actual == "Houston Dash" || actual == "LA Galaxy")
  end
end
