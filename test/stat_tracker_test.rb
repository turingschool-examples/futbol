require './test/setup'
require './lib/game'
require './lib/team'
require './lib/game_team'
require './lib/stat_tracker'

class StatTrackerTest < Minitest::Test
  def setup
    game_path = './fixtures/games_fixture.csv'
    team_path = './fixtures/teams_fixture.csv'
    game_teams_path = './fixtures/game_teams_fixture.csv'

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

  def test_it_has_games
    assert_instance_of Game, @stat_tracker.games.first
    assert_equal 2012030221, @stat_tracker.games.first.game_id
    assert_equal 20122013, @stat_tracker.games.first.season
    assert_equal 3, @stat_tracker.games.first.away_team_id
    assert_equal 6, @stat_tracker.games.first.home_team_id
  end

  def test_it_has_teams
    assert_instance_of Team, @stat_tracker.teams.first
    assert_equal 1, @stat_tracker.teams.first.team_id
    assert_equal 23, @stat_tracker.teams.first.franchise_id
    assert_equal "Atlanta United", @stat_tracker.teams.first.team_name
    assert_equal "ATL", @stat_tracker.teams.first.abbreviation
    assert_equal "/api/v1/teams/1", @stat_tracker.teams.first.link
  end

  def test_it_has_game_teams
    assert_instance_of GameTeam, @stat_tracker.game_teams.first
  end

  # GAME STATISTICS

  def test_highest_total_score
    assert_equal 5, @stat_tracker.highest_total_score
  end

  def test_lowest_total_score
    assert_equal 3, @stat_tracker.lowest_total_score
  end

  def test_find_home_wins
    assert_instance_of Array, @stat_tracker.find_home_wins
    assert_equal 2, @stat_tracker.find_home_wins.count
  end

  def test_home_wins_percentage
    assert_equal 66.67, @stat_tracker.percentage_home_wins
  end

  def test_find_visitor_wins
    assert_instance_of Array, @stat_tracker.find_visitor_wins
    assert_equal 1, @stat_tracker.find_visitor_wins.count
  end

  def test_away_wins_percentage
    assert_equal 33.33, @stat_tracker.percentage_visitor_wins
  end

  # LEAGUE STATISTICS

  def test_it_can_count_teams
    assert_equal 6, @stat_tracker.count_of_teams
  end

  def test_it_can_find_team_by_id
    assert_equal "FC Dallas", @stat_tracker.find_team_by_id(6).team_name
  end

  def test_it_can_organize_scores_by_team
    team_scores = {3=>[2, 2, 1], 6=>[3, 3, 2]}
    assert_equal team_scores, @stat_tracker.scores_by_team
  end

  def test_it_can_report_each_teams_avg_score
    average_scores = {3=>1.6666666666666667, 6=>2.6666666666666665}
    assert_equal average_scores, @stat_tracker.average_scores_by_team
  end

  def test_it_can_identify_best_offense
    assert_equal "FC Dallas", @stat_tracker.best_offense
  end

  def test_it_can_identify_worst_offense
    assert_equal "Houston Dynamo", @stat_tracker.worst_offense
  end

  def test_it_can_identify_highest_scoring_visitor
    skip
    assert_equal "", @stat_tracker.highest_scoring_visitor
  end

  def test_it_can_identify_highest_scoring_home_team
    skip
    assert_equal "", @stat_tracker.highest_scoring_home_team
  end

  def test_it_can_identify_lowest_scoring_visitor
    skip
    assert_equal "", @stat_tracker.lowest_scoring_visitor
  end

  def test_it_can_identify_lowest_scoring_home_team
    skip
    assert_equal "", @stat_tracker.lowest_scoring_home_team
  end

  # SEASON STATISTICS

  def test_it_can_find_games_by_season
  assert_instance_of Array, @stat_tracker.games_by_season(20122013)
  assert_equal 5, @stat_tracker.games_by_season(20122013).count
  end


  def test_winningest_coach
    game_path = './fixtures/games_fixture.csv'
    team_path = './fixtures/teams_fixture.csv'
    game_teams_path = './fixtures/large_game_teams_fixture.csv'

    locations = {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    assert_equal "Claude Julien", @stat_tracker.winningest_coach(20122013)
  end

  def test_worst_coach
    game_path = './fixtures/games_fixture.csv'
    team_path = './fixtures/teams_fixture.csv'
    game_teams_path = './fixtures/large_game_teams_fixture.csv'

    locations = {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    # Name of the Coach with the worst win percentage for the season	String
    assert_equal "John Tortorella", @stat_tracker.worst_coach(20122013)
  end

  def test_most_accurate_team
    # Name of the Team with the best ratio of shots to goals for the season	String
    assert_equal "FC Dallas", @stat_tracker.most_accurate_team(20122013)
  end

  def test_least_accurate_team
    skip
    # Name of the Team with the worst ratio of shots to goals for the season	String
  end

  def test_most_tackles
    skip
    # Name of the Team with the most tackles in the season	String
  end

  def test_fewest_tackles
    skip
    # Name of the Team with the fewest tackles in the season	String
  end

  # TEAM STATISTICS

  def test_can_get_team_info_hash
    result = @stat_tracker.team_info(1)
    assert_instance_of Hash, result
    assert_equal 1, result[:team_id]
    assert_equal "ATL", result[:abbreviation]
  end

  def test_most_goals_scored_for_given_team
    assert_equal 3, @stat_tracker.most_goals_scored(6)
  end

  def test_fewest_goals_scored_for_given_team
    assert_equal 2, @stat_tracker.fewest_goals_scored(6)
  end

  def test_best_season_per_given_team
    assert_equal "20122013", @stat_tracker.best_season(6)
  end

end
