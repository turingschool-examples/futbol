require './test/test_helper'
require './lib/game'
require './lib/team'

class TeamTest < Minitest::Test

  def setup
    @game_hash = {
      id: "2012030221",
      season: "20122013",
      type: "Postseason",
      date_time: "5/16/13",
      venue: "Toyota Stadium",
      venue_link: "/api/v1/venues/null",
      away_team: {
        id: "3",
        hoa: "away",
        result: "LOSS",
        head_coach: "John Tortorella",
        goals: 2,
        shots: 8,
        tackles: 44,
        pim: 8,
        power_play_opportunities: 3,
        power_play_goals: 0,
        face_off_win_percentage: 44.8,
        giveaways: 17,
        takeaways: 7
      },
      home_team: {
        id: "6",
        hoa: "home",
        result: "WIN",
        head_coach: "Claude Julien",
        goals: 3,
        shots: 12,
        tackles: 51,
        pim: 6,
        power_play_opportunities: 4,
        power_play_goals: 1,
        face_off_win_percentage: 55.2,
        giveaways: 4,
        takeaways: 5
      }
    }
    @game = Game.new(@game_hash)

    @team_hash = {
     team_id: "6",
     franchiseId: "23",
     teamName: "Atlanta United",
     abbreviation: "ATL",
     Stadium: "Mercedes-Benz Stadium",
     link: "/api/v1/teams/1",
     games: {
       @game.id => @game
     }
    }
   @team = Team.new(@team_hash)
  end

  def test_it_exists
    assert_instance_of Team, @team
  end

  def test_it_has_attributes
    assert_equal @team_hash[:team_id], @team.id
    assert_equal @team_hash[:franchiseId], @team.franchise_id
    assert_equal @team_hash[:teamName], @team.name
    assert_equal @team_hash[:abbreviation], @team.abbreviation
    assert_equal @team_hash[:Stadium], @team.stadium
    assert_equal @team_hash[:link], @team.link
    assert_equal @team_hash[:games], @team.games
  end

  def test_can_get_total_goals_of_team
    assert_equal 3, @team.total_goals
  end

  def test_can_get_total_goals_allowed
    assert_equal 2, @team.total_goals_allowed
  end

  def test_it_can_get_total_away_goals
    assert_equal 0, @team.total_away_goals
  end

  def test_it_can_get_total_home_goals
    assert_equal 3, @team.total_home_goals
  end

  def test_it_can_get_total_away_games
    assert_equal 0, @team.total_away_games
  end

  def test_it_can_get_total_home_games
    assert_equal 1, @team.total_home_games
  end

  def test_it_can_get_total_wins
    assert_equal 1, @team.total_wins
  end

  def test_it_can_check_home_team
    assert_equal true, @team.home_team?(@game)
  end

  def test_it_can_check_if_game_was_a_win
    assert_equal true, @team.win?(@game)
  end

  def test_it_can_check_if_game_was_a_tie
    assert_equal false, @team.tie?(@game)
  end

  def test_it_can_get_goals_scored_in_a_game
    assert_equal 3, @team.goals_scored(@game)
  end

  def test_it_can_get_goals_allowed
    assert_equal 2, @team.goals_allowed(@game)
  end

  def test_it_can_get_shots_taken_in_a_game
    assert_equal 12, @team.shots_taken(@game)
  end

  def test_it_can_get_tackles_made_in_a_game
    assert_equal 51, @team.tackles_made(@game)
  end

  def test_it_can_get_the_id_of_the_opponent_team
    assert_equal "3", @team.opponent_id(@game)
  end

  def test_it_can_make_win_percentage_by_opponents
    expected_hash = {
      "3" => {
        games_won: 1,
        games_played: 1
      }
    }
    assert_equal expected_hash, @team.opponent_win_percentage
  end

  def test_it_can_make_a_default_summary_hash
    expected_hash = {
      win_percentage:        0,
      total_goals_scored:    0,
      total_goals_against:   0,
      average_goals_scored:  0,
      average_goals_against: 0
    }
    assert_equal expected_hash, @team.default_summary_hash
  end

  def test_it_can_make_a_summary
    expected_hash = {
      regular_season: {
        win_percentage:        0,
        total_goals_scored:    0,
        total_goals_against:   0,
        average_goals_scored:  0,
        average_goals_against: 0
      },
      postseason: {
        win_percentage:        1.0,
        total_goals_scored:    3,
        total_goals_against:   2,
        average_goals_scored:  3.0,
        average_goals_against: 2.0
      }
    }
    assert_equal expected_hash, @team.summary
  end
end
