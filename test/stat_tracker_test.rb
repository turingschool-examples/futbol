require_relative 'test_helper'
require 'mocha/minitest'
require './lib/stat_tracker'
require './lib/stat_tracker'
require './lib/game'
require './lib/team'
require './lib/game_team'

class StatTrackerTest < Minitest::Test
  def setup
    game_path = './test/fixtures/games_truncated.csv'
    team_path = './test/fixtures/teams_truncated.csv'
    game_teams_path = './test/fixtures/game_teams_truncated.csv'

    # game_path = './data/games.csv'
    # team_path = './data/teams.csv'
    # game_teams_path = './data/game_teams.csv'
    #
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
  end

  def test_it_exists
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_can_create_objects
    assert_instance_of Game, @stat_tracker.games[2]
    assert_instance_of Team, @stat_tracker.teams[2]
    assert_instance_of GameTeam, @stat_tracker.game_teams[2]
  end

  def test_it_can_calculate_highest_total_score
    assert_equal 7, @stat_tracker.highest_total_score
  end

  def test_it_can_calculate_lowest_total_score
    assert_equal 1, @stat_tracker.lowest_total_score
  end

  def test_it_can_find_biggest_blowout
    assert_equal 4, @stat_tracker.biggest_blowout
  end

  def test_it_can_find_all_seasons
    assert_equal [20122013, 20132014], @stat_tracker.find_all_seasons
  end

  def test_it_can_calculate_count_of_games_by_season
    assert_equal ({"20122013"=>51, "20132014"=>29}), @stat_tracker.count_of_games_by_season
  end

  def test_it_can_average_goals_per_game
    assert_equal 4.01, @stat_tracker.average_goals_per_game
  end

  def test_it_can_average_goals_by_season
    assert_equal ({"20122013"=>4.02, "20132014"=>4.0}), @stat_tracker.average_goals_by_season
  end

  def test_it_can_find_percentage_home_wins
    assert_equal 0.68, @stat_tracker.percentage_home_wins
  end

  def test_it_can_find_percentage_visitor_wins
    assert_equal 0.25, @stat_tracker.percentage_visitor_wins
  end

  def test_it_can_find_percentage_ties
    assert_equal 0.05, @stat_tracker.percentage_ties
  end

  def test_it_can_count_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_it_can_find_team_names
    assert_equal "FC Dallas", @stat_tracker.find_team_names(6)
  end

  def test_it_can_calculate_goals_per_team
    expected = {
      3=>[2, 2, 1, 2, 1],
      6=>[3, 3, 2, 3, 3, 3, 4, 2, 1],
      5=>[0, 1, 1, 0],
      17=>[1, 2, 3, 2, 1, 3, 1],
      16=>[2, 1, 1, 0, 2, 2, 2],
      9=>[2, 1, 4],
      8=>[2, 3, 1, 2]
    }
    assert_equal expected, @stat_tracker.goals_per_team
  end

  def test_it_can_average_goals_per_team
    expected = {
      3=>1.6,
      6=>2.67,
      5=>0.5,
      17=>1.86,
      16=>1.43,
      9=>2.33,
      8=>2.0
    }
    assert_equal expected, @stat_tracker.average_goals_per_team
  end

  def test_it_can_tell_best_offense
    assert_equal "FC Dallas", @stat_tracker.best_offense
  end

  def test_it_can_tell_worst_offense
    assert_equal "Sporting Kansas City", @stat_tracker.worst_offense
  end

  def test_it_can_tell_games_teams_and_allowed_goals
    assert_equal [3, 3, 2, 3, 3], @stat_tracker.games_teams_and_allowed_goals[3]
  end

  def test_it_can_average_games_teams_and_allowed_goals
    assert_equal 2.8, @stat_tracker.average_games_teams_and_allowed_goals[3]
  end

  def test_it_can_tell_best_defense
    assert_equal "Orlando Pride", @stat_tracker.best_defense
  end

  def test_it_can_tell_worst_defense
    assert_equal "New York Red Bulls", @stat_tracker.worst_defense
  end

  def test_it_can_tell_visiting_teams_and_goals
    assert_equal [2, 3, 3, 4, 3], @stat_tracker.visiting_teams_and_goals[6]
  end

  def test_it_can_tell_average_visiting_teams_and_goals
    assert_equal 3, @stat_tracker.average_visiting_teams_and_goals[6]
  end

  def test_it_can_tell_highest_scoring_visitor
    assert_equal "Orlando Pride", @stat_tracker.highest_scoring_visitor
  end

  def test_lowest_scoring_visitor
    assert_equal "DC United", @stat_tracker.lowest_scoring_visitor
  end

  def test_it_can_return_home_teams_and_goals
    assert_equal [3, 3, 3, 2, 1, 2, 2, 4, 2], @stat_tracker.home_teams_and_goals[6]
  end

  def test_it_can_calculate_average_home_teams_and_goals
    assert_equal 2.44, @stat_tracker.average_home_teams_and_goals[6]
  end

  def test_highest_scoring_home_team
    assert_equal "New York City FC", @stat_tracker.highest_scoring_home_team
  end

  def test_it_can_tell_lowest_scoring_home_team
    assert_equal "DC United", @stat_tracker.lowest_scoring_home_team
  end

  def test_it_can_create_game_team_results
    assert_equal ["TIE", "WIN", "LOSS", "LOSS"], @stat_tracker.game_team_results[8]
  end

  def test_it_can_calculate_percent_wins
    assert_equal 25.0, @stat_tracker.percent_wins[8]
  end

  def test_it_can_tell_winningest_team
    assert_equal "FC Dallas", @stat_tracker.winningest_team
  end

  def test_finding_home_games_for_a_team
    assert_equal 5, @stat_tracker.home_games(6).length
    assert_equal @stat_tracker.game_teams[1], @stat_tracker.home_games(6)[0]
  end

  def test_finding_away_games_for_a_team
    assert_equal 4, @stat_tracker.away_games(6).length
    assert_includes @stat_tracker.away_games(6), @stat_tracker.game_teams[4]
  end

  def test_getting_home_win_percentage_for_a_team
    assert_equal 75.0, @stat_tracker.home_win_percentage(16)
    assert_equal 100, @stat_tracker.home_win_percentage(9)
  end

  def test_getting_away_win_percentage_for_a_team
    assert_equal 33.33, @stat_tracker.away_win_percentage(17)
    assert_equal 80, @stat_tracker.away_win_percentage(6)
  end

  def test_all_teams_playing
    assert_equal [3, 6, 5, 17, 16, 9, 8], @stat_tracker.all_teams_playing
  end

  def test_getting_the_team_with_the_best_fans
    assert_equal "New York City FC", @stat_tracker.best_fans
  end

  def test_getting_the_teams_with_the_worst_fans
    # @stat_tracker.stubs(:away_win_percentage).returns(80)
    expected = ["Houston Dynamo", "Sporting Kansas City", "New England Revolution", "New York Red Bulls"]
    assert_equal expected, @stat_tracker.worst_fans
  end

  def test_it_can_get_game_teams_that_season
      assert_kind_of Array, @stat_tracker.game_teams_that_season(8, 20122013)
      assert_equal 4, @stat_tracker.game_teams_that_season(8, 20122013).length
  end

  def test_all_goals_that_season
    expected = 0.23
    assert_equal expected, @stat_tracker.goals_to_shots_ratio_that_season(8, 20122013)
  end

  def test_most_accurate_team
     assert_equal "New York City FC", @stat_tracker.most_accurate_team(20122013)
  end

  def test_can_get_least_accurate_team
    assert_equal "Sporting Kansas City", @stat_tracker.least_accurate_team(20122013)
  end

  def test_if_can_get_all_coaches
    expected = ["John Tortorella", "Claude Julien", "Dan Bylsma",
                "Mike Babcock", "Joel Quenneville", "Paul MacLean", "Michel Therrien"
                ]
    assert_equal expected, @stat_tracker.all_coaches
  end

  def test_it_can_get_games_by_coach_and_season
    assert_kind_of Array, @stat_tracker.game_teams_that_season_by_coach("Mike Babcock", 20122013)
    assert_equal 9, @stat_tracker.game_teams_that_season_by_coach("Claude Julien", 20122013).length
  end

  def test_it_can_create_hash_with_coaches_and_games
    assert_kind_of Hash, @stat_tracker.create_hash_with_team_games_by_coach(20122013)
    assert_equal 7, @stat_tracker.create_hash_with_team_games_by_coach(20122013).length
  end

  def test_find_all_wins_by_coach
    expected = {"John Tortorella"=>0, "Claude Julien"=>9, "Dan Bylsma"=>0, "Mike Babcock"=>4, "Joel Quenneville"=>3, "Paul MacLean"=>1, "Michel Therrien"=>1}
    assert_equal expected, @stat_tracker.finding_all_wins_by_coach(20122013)
  end

  def test_number_of_games_by_coach
    expected = {"John Tortorella"=>5, "Claude Julien"=>9, "Dan Bylsma"=>4, "Mike Babcock"=>7, "Joel Quenneville"=>7, "Paul MacLean"=>3, "Michel Therrien"=>4}
    assert_equal expected, @stat_tracker.number_of_games_by_coach(20122013)
  end

  def test_percent_wins_by_coach
    expected = {"John Tortorella"=>0.0, "Claude Julien"=>1.0, "Dan Bylsma"=>0.0, "Mike Babcock"=>0.57, "Joel Quenneville"=>0.43, "Paul MacLean"=>0.33, "Michel Therrien"=>0.25}
    assert_equal expected, @stat_tracker.percent_wins_by_coach(20122013)
  end

  def test_winningest_coach
    assert_equal "Claude Julien", @stat_tracker.winningest_coach(20122013)
  end

  def test_worst_coach
    assert_equal "John Tortorella", @stat_tracker.worst_coach(20122013)
  end

  def test_it_can_get_game_id_by_team_id_and_season_type_hash
    expected = {
      :regular=>[2012020205, 2013021119],
      :post=>[2012030121, 2012030122, 2012030123, 2012030124, 2012030125]
    }
    assert_equal expected, @stat_tracker.game_id_by_team_id_and_season_type[9]
  end

  def test_it_can_return_post_results
    assert_equal ["TIE", "LOSS", "WIN"], @stat_tracker.game_team_postseason_results[9]
  end

  def test_it_can_return_regular_results
    skip
    @stat_tracker.stubs(:game_id_by_team_id_and_season_type).returns({9=>{
      :regular=>[2012020205, 2013021119],
      :post=>[2012030121, 2012030122, 2012030123, 2012030124, 2012030125]
    }})

    assert_equal ["LOSS", "WIN"], @stat_tracker.game_team_regular_season_results[9]
  end

  def test_it_can_return_percent_postseason_wins
    assert_equal 0.33, @stat_tracker.percent_wins_postseason[9]
  end

  def test_it_can_return_percent_regular_wins
    @stat_tracker.stubs(:game_team_regular_season_results).returns({
      9=>["LOSS", "WIN"]
    })
    assert_equal 0.50, @stat_tracker.percent_wins_regular_season[9]
  end

  def test_it_can_tell_biggest_bust
    @stat_tracker.stubs(:percent_wins_regular_season).returns({3=>0.66, 4=>0.75})
    @stat_tracker.stubs(:percent_wins_postseason).returns({3=>0.33, 4=>0.25})

    assert_equal "Chicago Fire", @stat_tracker.biggest_bust
  end

  def test_it_can_tell_biggest_surprise
    @stat_tracker.stubs(:percent_wins_regular_season).returns({3=>0.66, 4=>0.75})
    @stat_tracker.stubs(:percent_wins_postseason).returns({3=>0.33, 4=>0.25})

    assert_equal "Houston Dynamo", @stat_tracker.biggest_surprise
  end

  def test_find_games_in_season
    skip
    #not sure how to test this method but we may not need it
    assert_equal [], @stat_tracker.find_games_in_season(20122013)
  end

  def test_most_tackles
    assert_equal "FC Dallas", @stat_tracker.most_tackles(20122013)
    # might need more games or game_teams data to try another season
    #assert_equal "", @stat_tracker.most_tackles(20132014)
  end

  def test_fewest_tackles
    assert_equal "New York City FC", @stat_tracker.fewest_tackles(20122013)
    # assert_equal "", @stat_tracker.fewest_tackles(20132014)
  end

  def test_team_info
    assert_equal ({"team_id"=>6, "franchise_id"=>6, "team_name"=>"FC Dallas", "abbreviation"=>"DAL", "link"=>"/api/v1/teams/6"}), @stat_tracker.team_info(6)
  end

  def test_find_season_wins
    assert_equal 0.57, @stat_tracker.find_season_wins(17, 20122013)
  end

  def test_all_seasons
    assert_equal [20122013, 20132014], @stat_tracker.all_seasons
  end

  def test_find_win_average_in_season
    assert_equal ({20122013=>0.57, 20132014=>0}), @stat_tracker.find_win_average_in_seasons(17)
  end

  def test_best_season
    assert_equal 20122013, @stat_tracker.best_season(6)
  end

  def test_worst_season
    assert_equal 20132014, @stat_tracker.worst_season(6)
  end
end
