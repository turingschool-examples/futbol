require_relative 'test_helper'

class StatTrackerTest < Minitest::Test
  def setup
    @locations = {
      games: './data/games.csv',
      teams: './data/teams.csv',
      game_teams: './data/game_teams.csv'
    }

    @stat_tracker = StatTracker.new(@locations)
    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_it_exists
   assert_instance_of StatTracker, @stat_tracker
  end

  def test_from_csv
    assert_instance_of StatTracker, @stat_tracker
  end

  def test_it_has_attributes
    @game_stats = GameStats.new(self)
    @game_teams_stats = LeagueStats.new(self)
    @team_stats = TeamStats.new(self)
    @team_stats = SeasonStats.new(self)

    assert_instance_of GameStats, @stat_tracker.game_stats
    assert_instance_of LeagueStats, @stat_tracker.team_stats
    assert_instance_of TeamStats, @stat_tracker.game_teams_stats
    assert_instance_of SeasonStats, @stat_tracker.game_teams_stats
  end

  def test_the_highest_score
    assert_equal 11, @stat_tracker.highest_total_score
  end

  def test_it_can_find_lowest_total_score
    assert_equal 0, @stat_tracker.lowest_total_score
  end

  def test_it_knows_percentage_home_wins
    assert_equal 0.44, @stat_tracker.percentage_home_wins
  end

  def test_it_knows_percentage_visitor_wins
    assert_equal 0.36, @stat_tracker.percentage_visitor_wins
  end

  def test_it_knows_percentage_ties
    assert_equal 0.20, @stat_tracker.percentage_ties
  end

  def test_it_knows_count_of_games_by_season
    expected = {
      "20122013"=>806,
      "20162017"=>1317,
      "20142015"=>1319,
      "20152016"=>1321,
      "20132014"=>1323,
      "20172018"=>1355
    }
    assert_equal expected, @stat_tracker.count_of_games_by_season
  end

  def test_average_goals_per_game
    assert_equal 4.22, @stat_tracker.average_goals_per_game
  end

  def test_average_goals_by_season
    expected = {
      "20122013"=>4.12,
      "20162017"=>4.23,
      "20142015"=>4.14,
      "20152016"=>4.16,
      "20132014"=>4.19,
      "20172018"=>4.44
    }

      assert_equal expected, @stat_tracker.average_goals_by_season
  end

  def test_count_of_teams
    assert_equal 32, @stat_tracker.count_of_teams
  end

  def test_team_with_best_offense
    assert_equal 'Reign FC', @stat_tracker.best_offense
  end

  def test_worst_offense
    assert_equal 'Utah Royals FC', @stat_tracker.worst_offense
  end

  def test_highest_scoring_visitor
    assert_equal 'FC Dallas', @stat_tracker.highest_scoring_visitor
  end

  def test_lowest_scoring_visitor
    assert_equal 'San Jose Earthquakes', @stat_tracker.lowest_scoring_visitor
  end

  def test_highest_scoring_home_team
    assert_equal 'Reign FC', @stat_tracker.highest_scoring_home_team
  end

  def test_lowest_scoring_home_team
    assert_equal 'Utah Royals FC', @stat_tracker.lowest_scoring_home_team
  end

  def test_winningest_coach
    assert_equal "Dan Lacroix", @stat_tracker.winningest_coach("20122013")
    assert_equal "Claude Julien", @stat_tracker.winningest_coach("20132014")
    assert_equal "Alain Vigneault", @stat_tracker.winningest_coach("20142015")
    assert_equal "Barry Trotz", @stat_tracker.winningest_coach("20152016")
    assert_equal "Bruce Cassidy", @stat_tracker.winningest_coach("20162017")
    assert_equal "Bruce Cassidy", @stat_tracker.winningest_coach("20172018")
  end

  def test_worst_coach
    assert_equal "Martin Raymond", @stat_tracker.worst_coach("20122013")
    assert_equal "Peter Laviolette", @stat_tracker.worst_coach("20132014")
    assert_equal "Ted Nolan", @stat_tracker.worst_coach("20142015")
    assert_equal "Todd Richards", @stat_tracker.worst_coach("20152016")
    assert_equal "Dave Tippett", @stat_tracker.worst_coach("20162017")
    assert_equal "Phil Housley", @stat_tracker.worst_coach("20172018")
  end

  def test_it_can_find_most_accurate_team_name
    assert_equal "Real Salt Lake", @stat_tracker.most_accurate_team("20132014")
    assert_equal "Toronto FC", @stat_tracker.most_accurate_team("20142015")
  end

  def test_it_can_find_least_accurate_team_name
    assert_equal "New York City FC", @stat_tracker.least_accurate_team("20132014")
    assert_equal "Columbus Crew SC", @stat_tracker.least_accurate_team("20142015")
  end

  def test_can_find_team_name_with_most_tackles_in_season
    assert_equal 'FC Cincinnati', @stat_tracker.most_tackles("20132014")
    assert_equal 'Seattle Sounders FC', @stat_tracker.most_tackles("20142015")
  end

  def test_can_find_team_name_with_fewest_tackles_in_season
    assert_equal 'Atlanta United', @stat_tracker.fewest_tackles("20132014")
    assert_equal 'Orlando City SC', @stat_tracker.fewest_tackles("20142015")
  end

  def test_in_can_find_team_info
    expected = {"team_id"=>"18",
                "franchise_id"=>"34",
                "team_name"=>"Minnesota United FC",
                "abbreviation"=>"MIN",
                "link"=>"/api/v1/teams/18"
    }
    assert_equal expected, @stat_tracker.team_info("18")
  end

  def test_it_can_find_best_season
    assert_equal "20132014", @stat_tracker.best_season("6")
  end

  def test_it_can_find_worst_season
    assert_equal "20142015", @stat_tracker.worst_season("6")
  end

  def test_it_can_find_avg_win_percentage
    assert_equal 0.49, @stat_tracker.average_win_percentage("6")
  end

  def test_it_can_find_most_goals_scored
    assert_equal 7, @stat_tracker.most_goals_scored("18")
  end

  def test_it_can_find_fewest_goals_scored
      assert_equal 0, @stat_tracker.fewest_goals_scored("18")
  end

  def test_it_can_find_favorite
    assert_equal "DC United", @stat_tracker.favorite_opponent("18")
  end

  def test_it_can_find_rival
    assert_includes ["Houston Dash", "LA Galaxy"], @stat_tracker.rival("18")
    stat_tracker = StatTracker.new(locations)
    @game_stats = GameStats.new(locations[:games], self)
    @game_teams_stats = GameTeamsStats.new(locations[:game_teams], self)
    @team_stats = TeamStats.new(locations[:teams], self)

    assert_instance_of GameStats, stat_tracker.game_stats
    assert_instance_of TeamStats, stat_tracker.team_stats
    assert_instance_of GameTeamsStats, stat_tracker.game_teams_stats
  end
end
