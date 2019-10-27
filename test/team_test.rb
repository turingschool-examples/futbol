require 'csv'
require './test/test_helper'
require './lib/team'

require 'csv'
require './test/test_helper'
require './lib/team'
require 'mocha/minitest'
require './lib/game_team'

class TeamsTest < Minitest::Test

  def setup
    csv = CSV.read('./data/game_teams_sample.csv', headers: true, header_converters: :symbol)
    all_games = csv.map do |row|
      GameTeam.new(row)
    end

    csv = CSV.read('./data/teams_sample.csv', headers: true, header_converters: :symbol)
    @teams = csv.map do |team|
      all_game_ids = []
      all_team_games = all_games.find_all do |game_team|
        if team[:team_id] == game_team.team_id
          all_game_ids << game_team.game_id
        end
      end
      all_opponent_games = all_game_ids.flat_map do |game_id|
        all_games.find_all do |game_team|
          game_team.game_id == game_id && game_team.team_id != team[:team_id]
        end
      end
      # all_opponent_games = @total_games.find_all do |game|
      #   team[:team_id] == game.team_id
      # end
      Team.new(team, all_team_games, all_opponent_games)
    end
  end

  def test_it_exists
    @teams.each do |team|
      assert_instance_of Team, team
    end
  end

  # def test_it_has_attributes
  #   team = @teams.first
  #   assert_equal "3", team.team_id
  #   assert_equal 10, team.franchise_id
  #   assert_equal "Houston Dynamo", team.team_name
  #   assert_equal "HOU", team.abbreviation
  # end
  #
  # def test_it_has_a_win_percentage
  #   team = @teams.find {|team| team.team_id == "8"}
  #   # 1 win 3 losses 1 tie
  #   win_percentage = (1 / 5.0).round(2)
  #   assert_equal win_percentage, team.win_percentage
  # end
  #
  # def test_it_has_average_goals_scored_per_game
  #   team = @teams.find {|team| team.team_id == "8"}
  #   average_goals_scored_per_game = (9/5.0).round(2)
  #   assert_equal average_goals_scored_per_game, team.average_goals_scored_per_game
  # end
  #
  # def test_it_has_average_goals_allowed_per_game
  #   team = @teams.find {|team| team.team_id == "8"}
  #   average_goals_allowed_per_game = (14/5.0).round(2)
  #   assert_equal 2.8, team.average_goals_allowed_per_game
  # end
  #
  # def test_it_has_a_home_win_percentage
  #   team = @teams.find {|team| team.team_id == "8"}
  #   home_win_percentage = (1/3.0*100).round(2)
  #   assert_equal home_win_percentage, team.home_win_percentage
  # end
  #
  # def test_it_has_an_away_win_percentage
  #   team = @teams.find {|team| team.team_id == "8"}
  #   assert_equal 0, team.away_win_percentage
  # end

  def test_it_can_group_by_away_team_id_and_goals
    assert_equal 3, @teams.group_away_teams
  end

end
