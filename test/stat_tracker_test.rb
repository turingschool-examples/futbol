require "./test/test_helper"
require './lib/stat_tracker'
require "./lib/game"
require "./lib/team"
require "./lib/game_team"

class StatTrackerTest < Minitest::Test
  @@locations = {
                games: "./data/games.csv",
                game_teams: "./data/game_teams.csv",
                teams: "./data/teams.csv"
                }

  @@stat_tracker = StatTracker.from_csv(@@locations)

  def test_it_can_find_games
    assert_equal 720, @@stat_tracker.find_games("20122013", "Regular Season").count
    assert_equal 1230, @@stat_tracker.find_games("20142015", "Regular Season").count
    assert_equal 86, @@stat_tracker.find_games("20122013", "Postseason").count
    assert_equal 89, @@stat_tracker.find_games("20142015", "Postseason").count
  end

  def test_from_csv_returns_new_instance
    assert_instance_of StatTracker, @@stat_tracker
  end

  def test_it_can_create_items
    StatTracker.create_items("./data/teams.csv", Team)
  end

  def test_it_finds_regular_season_teams
    assert_equal 30, @@stat_tracker.find_regular_season_teams("20142015").count
    assert_equal true, @@stat_tracker.find_regular_season_teams("20142015").include?(26)
    assert_equal false, @@stat_tracker.find_regular_season_teams("20142015").include?(59)
  end

  def test_it_has_post_season_teams
    assert_equal 16, @@stat_tracker.find_post_season_teams("20142015").count
  end

  def test_it_can_find_eligible_teams
    assert_equal true, @@stat_tracker.find_eligible_teams("20142015").include?(14)
    assert_equal true, @@stat_tracker.find_eligible_teams("20142015").include?(5)
    assert_equal true, @@stat_tracker.find_eligible_teams("20132014").include?(23)
  end

  def test_it_can_calculate_regular_season_win_percentage
    assert_equal 0.479, @@stat_tracker.win_percentage_by_season("20122013", 6, "Regular Season")
    assert_equal 0.39, @@stat_tracker.win_percentage_by_season("20142015", 14, "Regular Season")
  end

  def test_it_can_calculate_post_season_win_percentage
    assert_equal 0.682, @@stat_tracker.win_percentage_by_season("20122013", 6, "Postseason")
    assert_equal 0.167, @@stat_tracker.win_percentage_by_season("20122013", 3, "Postseason")
    assert_equal 0, @@stat_tracker.win_percentage_by_season("20132014", 23, "Postseason")
  end

  def test_it_can_calculate_biggest_bust
    assert_equal "Sporting Kansas City", @@stat_tracker.biggest_bust("20142015")
    assert_equal "Montreal Impact", @@stat_tracker.biggest_bust("20132014")
  end

  def test_it_can_calculate_biggest_surprise
    assert_equal "Minnesota United FC", @@stat_tracker.biggest_surprise("20142015")
    assert_equal "FC Cincinnati", @@stat_tracker.biggest_surprise("20132014")
  end

  def test_from_csv_loads_all_three_files
    assert_equal 7441, Game.all.count
    assert_equal 7441, GameTeam.all.count
    assert_equal 32, Team.all.count
  end

  def test_it_can_get_team_info_by_team_id
    expected = {
      "team_id" => "18",
      "franchise_id" => "34",
      "team_name" => "Minnesota United FC",
      "abbreviation" => "MIN",
      "link" => "/api/v1/teams/18"
    }

    assert_instance_of Hash, @@stat_tracker.team_info("18")
    assert_equal expected, @@stat_tracker.team_info("18")
    assert_equal 5, @@stat_tracker.team_info("18").count
    assert_equal 5, @@stat_tracker.team_info("5").count
  end

  def test_it_can_get_best_season
    assert_equal "20142015", @@stat_tracker.best_season("3")
    assert_equal "20162017", @@stat_tracker.best_season("5")
    assert_equal "20132014", @@stat_tracker.best_season("6")
  end

  def test_it_can_get_worst_season
    assert_equal "20122013", @@stat_tracker.worst_season("3")
    assert_equal "20122013", @@stat_tracker.worst_season("5")
    assert_equal "20142015", @@stat_tracker.worst_season("6")
  end

  def test_it_can_get_average_win_percentage_by_team_id
    assert_equal 0.36, @@stat_tracker.average_win_percentage("1")
    assert_equal 0.43, @@stat_tracker.average_win_percentage("3")
    assert_equal 0.48, @@stat_tracker.average_win_percentage("5")
    assert_equal 0.49, @@stat_tracker.average_win_percentage("6")
  end

  def test_it_can_get_most_goals_scored_by_team_id
    assert_equal 6, @@stat_tracker.most_goals_scored("3")
    assert_equal 6, @@stat_tracker.most_goals_scored("6")
    assert_equal 7, @@stat_tracker.most_goals_scored("18")
  end

  def test_it_can_get_fewest_goals_scored
    assert_equal 0, @@stat_tracker.fewest_goals_scored("3")
    assert_equal 0, @@stat_tracker.fewest_goals_scored("6")
    assert_equal 0, @@stat_tracker.fewest_goals_scored("18")
  end

  def test_it_can_get_biggest_team_blowout
    assert_equal 4, @@stat_tracker.biggest_team_blowout("3")
    assert_equal 4, @@stat_tracker.biggest_team_blowout("6")
    assert_equal 5, @@stat_tracker.biggest_team_blowout("18")
  end

  def test_it_can_get_worst_loss
    assert_equal 5, @@stat_tracker.worst_loss("3")
    assert_equal 5, @@stat_tracker.worst_loss("6")
    assert_equal 4, @@stat_tracker.worst_loss("18")
  end

  def test_it_can_get_all_game_teams_by_team_id_in_array
    assert_instance_of Array, @@stat_tracker.all_game_teams_by_team_id("3")
    assert_equal 531, @@stat_tracker.all_game_teams_by_team_id("3").length

    assert_instance_of Array, @@stat_tracker.all_game_teams_by_team_id("5")
    assert_equal 552, @@stat_tracker.all_game_teams_by_team_id("5").length
  end

  def test_it_can_get_all_games_by_team_id_in_array
    assert_instance_of Array, @@stat_tracker.all_games_by_team_id("3")
    assert_equal 531, @@stat_tracker.all_games_by_team_id("3").length

    assert_instance_of Array, @@stat_tracker.all_games_by_team_id("5")
    assert_equal 552, @@stat_tracker.all_games_by_team_id("5").length
  end

  def test_it_can_get_total_results_by_team_id
    assert_instance_of Array, @@stat_tracker.total_results_by_team_id("3")
    assert_equal 531, @@stat_tracker.total_results_by_team_id("3").length

    assert_instance_of Array, @@stat_tracker.total_results_by_team_id("5")
    assert_equal 552, @@stat_tracker.total_results_by_team_id("5").length
  end

  def test_it_can_get_all_goals_scored_by_team_id
    assert_instance_of Array, @@stat_tracker.all_goals_scored_by_team_id("3")
    assert_equal 531, @@stat_tracker.all_goals_scored_by_team_id("3").length
    assert_equal 2, @@stat_tracker.all_goals_scored_by_team_id("3").first
    assert_equal 3, @@stat_tracker.all_goals_scored_by_team_id("6").first
    assert_equal 0, @@stat_tracker.all_goals_scored_by_team_id("5").first
  end

  def test_it_can_get_score_differences_by_team_id
    assert_equal 531, @@stat_tracker.score_differences_by_team_id("3").length
    assert_equal (-1), @@stat_tracker.score_differences_by_team_id("3").first

    assert_equal 552, @@stat_tracker.score_differences_by_team_id("5").length
    assert_equal (-3), @@stat_tracker.score_differences_by_team_id("5").first
  end

  def test_it_can_get_team_name
    assert_equal "Houston Dynamo", @@stat_tracker.get_team_name("3")
    assert_equal "FC Dallas", @@stat_tracker.get_team_name("6")
    assert_equal "Reign FC", @@stat_tracker.get_team_name("54")
  end

  def test_it_can_get_win_percentage_by_season
    expected = {
      "20122013"=>0.041,
      "20152016"=>0.073,
      "20142015"=>0.098,
      "20132014"=>0.092,
      "20172018"=>0.045,
      "20162017"=>0.083
    }

    assert_instance_of Hash, @@stat_tracker.win_percentage_by_season_by_team_id("3")
    assert_equal expected, @@stat_tracker.win_percentage_by_season_by_team_id("3")
  end

  def test_it_can_calc_win_percentage
    games = [
              Game.new({home_team_id: 1, home_goals: 5, away_team_id: 2, away_goals: 1}),
              Game.new({home_team_id: 2, home_goals: 20, away_team_id: 1, away_goals: 5})
            ]
    team = Team.new({team_id: 1, teamname: "taco terrors"})

    @@stat_tracker.win_percentage(games, team)
  end

  def test_it_knows_how_many_teams_there_are
    assert_equal 32, @@stat_tracker.count_of_teams
  end

  def test_it_knows_best_offense
    assert_equal "Reign FC", @@stat_tracker.best_offense
  end

  def test_it_knows_worst_offense
    assert_equal  "Utah Royals FC", @@stat_tracker.worst_offense
  end

  def test_it_knows_best_defense
    assert_equal "FC Cincinnati", @@stat_tracker.best_defense
  end

  def test_it_knows_worst_defense
    assert_equal "Columbus Crew SC", @@stat_tracker.worst_defense
  end

  def test_it_knows_highest_scoring_visitor
    assert_equal "FC Dallas", @@stat_tracker.highest_scoring_visitor
  end

  def test_it_knows_highest_scoring_home_team
    assert_equal "Reign FC", @@stat_tracker.highest_scoring_home_team
  end

  def test_it_knows_lowest_scoring_visitor
    assert_equal "San Jose Earthquakes", @@stat_tracker.lowest_scoring_visitor
  end

  def test_it_knows_lowest_scoring_home_team
    assert_equal "Utah Royals FC", @@stat_tracker.lowest_scoring_home_team
  end

  def test_it_knows_winningest_team
    assert_equal "Reign FC", @@stat_tracker.winningest_team
  end

  def test_it_knows_best_fans
    assert_equal "San Jose Earthquakes", @@stat_tracker.best_fans
  end

  def test_it_knows_worst_fans
    assert_equal ["Houston Dynamo", "Utah Royals FC"], @@stat_tracker.worst_fans
  end

  def test_it_knows_winningest_coach
  assert_equal "Claude Julien", @@stat_tracker.winningest_coach("20132014")
  assert_equal "Alain Vigneault", @@stat_tracker.winningest_coach("20142015")
  end

  def test_it_knows_worst_coach
  assert_equal "Peter Laviolette", @@stat_tracker.worst_coach("20132014")
  assert_includes ["Craig MacTavish", "Ted Nolan"], @@stat_tracker.worst_coach("20142015")
  end

  def test_sort_module
    assert_equal [0,1,2,3,4,5,6,7,8,9,10,11], Game.find_all_scores
  end

  def test_highest_total_score
    assert_equal 11, @@stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 0, @@stat_tracker.lowest_total_score
  end

  def test_biggest_blowout
    assert_equal 8, @@stat_tracker.biggest_blowout
  end

  def test_percentage_home_wins
    assert_equal 0.44, @@stat_tracker.percentage_home_wins
  end

  def test_percentage_away_wins
    assert_equal 0.36, @@stat_tracker.percentage_visitor_wins
  end

  def test_percentage_ties
    assert_equal 0.2, @@stat_tracker.percentage_ties
  end

  def test_count_of_games_by_season
    expected =
    {
    "20122013"=>806,
    "20162017"=>1317,
    "20142015"=>1319,
    "20152016"=>1321,
    "20132014"=>1323,
    "20172018"=>1355
    }

    assert_equal expected, @@stat_tracker.count_of_games_by_season
  end

  def test_average_goals_per_game
    assert_equal 4.22, @@stat_tracker.average_goals_per_game
  end

  def test_total_goals_per_games
    games = Game.games_in_a_season("20122013")

    assert_equal 3322.0, @@stat_tracker.total_goals_per_games(games)
  end

  def test_average_goals_by_season
    expected =
    {
      "20122013"=>4.12,
      "20162017"=>4.23,
      "20142015"=>4.14,
      "20152016"=>4.16,
      "20132014"=>4.19,
      "20172018"=>4.44
    }

    assert_equal expected, @@stat_tracker.average_goals_by_season
  end

  def test_return_team_name
    tackles = mock("tackles")
    tackles.stubs(:accumulator).returns({3 => 10, 10 => 1})

    assert_equal "Houston Dynamo", @@stat_tracker.return_team_name(tackles.accumulator)
  end

  def test_most_tackles
    game = Game.all.values.first

    assert_equal "FC Cincinnati", @@stat_tracker.most_tackles(game.season)
  end

  def test_fewest_tackles
    game = Game.all.values.first

    assert_equal "Atlanta United", @@stat_tracker.fewest_tackles(game.season)
  end

  def test_games_in_season
    game = Game.all.values.first

    assert_equal 806, Game.games_in_a_season(game.season).length
  end

  def test_most_accurate_team
    game = Game.all.values.first

    assert_equal "DC United", @@stat_tracker.most_accurate_team(game.season)
  end

  def test_least_accurate_team
    game = Game.all.values.first

    assert_equal "New York City FC", @@stat_tracker.least_accurate_team(game.season)
  end

  def test_all_seasons
    assert_equal ["20122013", "20162017", "20142015", "20152016", "20132014", "20172018"], @@stat_tracker.all_seasons
  end

  def test_it_can_get_win_percentage_against_opponent
    assert_equal 0.0, @@stat_tracker.win_percentage_against_opponent("18", "14")
    assert_equal 1.5, @@stat_tracker.win_percentage_against_opponent("3", "6")
  end

  def test_it_can_get_all_team_average_wins_by_opponent
    assert_equal 0.615, @@stat_tracker.all_team_average_wins_by_opponent("6")[14]
    assert_equal 0.0, @@stat_tracker.all_team_average_wins_by_opponent("18")[14]
  end

  def test_it_can_get_favorite_opponent
    assert_equal "Montreal Impact", @@stat_tracker.favorite_opponent("3")
    assert_equal "Columbus Crew SC", @@stat_tracker.favorite_opponent("6")
    assert_equal "DC United", @@stat_tracker.favorite_opponent("18")
  end

  def test_it_can_get_rival
    assert_equal "San Jose Earthquakes", @@stat_tracker.rival("3")
    assert_equal "Real Salt Lake", @@stat_tracker.rival("6")
    assert_equal "Houston Dash", @@stat_tracker.rival("18")
  end

  def test_it_can_get_all_opponent_average_wins
    assert all_opponent_average_wins("18")

  end

  def test_it_can_get_average_wins_against_opponent
  assert average_wins_against_opponent("18", "6")

  end

  def test_it_can_get_head_to_head
    assert @@stat_tracker.head_to_head("18").length
    assert @@stat_tracker.head_to_head("18")
  end

  def test_it_can_get_seasonal_summary
    expected = {
      "20162017"=>
        {:postseason=>
          {:win_percentage=>0.59,
           :total_goals_scored=>48,
           :total_goals_against=>40,
           :average_goals_scored=>2.18,
           :average_goals_against=>1.82},
         :regular_season=>
          {:win_percentage=>0.38,
           :total_goals_scored=>180,
           :total_goals_against=>170,
           :average_goals_scored=>2.2,
           :average_goals_against=>2.07}},
       "20172018"=>
        {:postseason=>
          {:win_percentage=>0.54,
           :total_goals_scored=>29,
           :total_goals_against=>28,
           :average_goals_scored=>2.23,
           :average_goals_against=>2.15},
         :regular_season=>
          {:win_percentage=>0.44,
           :total_goals_scored=>187,
           :total_goals_against=>162,
           :average_goals_scored=>2.28,
           :average_goals_against=>1.98}},
       "20132014"=>
        {:postseason=>
          {:win_percentage=>0.0,
           :total_goals_scored=>0,
           :total_goals_against=>0,
           :average_goals_scored=>0.0,
           :average_goals_against=>0.0},
         :regular_season=>
          {:win_percentage=>0.38,
           :total_goals_scored=>166,
           :total_goals_against=>177,
           :average_goals_scored=>2.02,
           :average_goals_against=>2.16}},
       "20122013"=>
        {:postseason=>
          {:win_percentage=>0.0,
           :total_goals_scored=>0,
           :total_goals_against=>0,
           :average_goals_scored=>0.0,
           :average_goals_against=>0.0},
         :regular_season=>
          {:win_percentage=>0.25,
           :total_goals_scored=>85,
           :total_goals_against=>103,
           :average_goals_scored=>1.77,
           :average_goals_against=>2.15}},
       "20142015"=>
        {:postseason=>
          {:win_percentage=>0.67,
           :total_goals_scored=>17,
           :total_goals_against=>13,
           :average_goals_scored=>2.83,
           :average_goals_against=>2.17},
         :regular_season=>
          {:win_percentage=>0.5,
           :total_goals_scored=>186,
           :total_goals_against=>162,
           :average_goals_scored=>2.27,
           :average_goals_against=>1.98}},
       "20152016"=>
        {:postseason=>
          {:win_percentage=>0.36,
           :total_goals_scored=>25,
           :total_goals_against=>33,
           :average_goals_scored=>1.79,
           :average_goals_against=>2.36},
         :regular_season=>
          {:win_percentage=>0.45,
           :total_goals_scored=>178,
           :total_goals_against=>159,
           :average_goals_scored=>2.17,
           :average_goals_against=>1.94}}}

    assert_equal expected, @@stat_tracker.seasonal_summary("18")
    assert_instance_of Hash, @@stat_tracker.seasonal_summary("18")
    assert @@stat_tracker.seasonal_summary("18")["20122013"].key?(:regular_season)
    assert @@stat_tracker.seasonal_summary("18")["20122013"].key?(:postseason)
  end
end
