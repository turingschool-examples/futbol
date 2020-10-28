require 'minitest/autorun'
require 'minitest/pride'
require './lib/game_statistics'
require './lib/object_data'
require './lib/stat_tracker'
require './lib/season_statistics'

class SeasonStatisticsTest < Minitest::Test
  def setup
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
    @object_data ||= ObjectData.new(@stat_tracker)
    @season_statistics = SeasonStatistics.new
  end

  def test_it_exists
    assert_instance_of SeasonStatistics, @season_statistics
  end

  def test_winningest_coach
    skip
   assert_equal "Claude Julien", @season_statistics.winningest_coach("20132014", @object_data.games, @object_data.game_teams)
   assert_equal "Alain Vigneault", @season_statistics.winningest_coach("20142015", @object_data.games, @object_data.game_teams)
  end

  def test_team_total_wins_by_season
      expected = {
        14=>{:wins=>45, :total=>108},
        16=>{:wins=>44, :total=>105},
        3=>{:wins=>52, :total=>101},
        5=>{:wins=>37, :total=>87},
        19=>{:wins=>38, :total=>88},
        30=>{:wins=>42, :total=>92},
        8=>{:wins=>46, :total=>94},
        9=>{:wins=>34, :total=>88},
        15=>{:wins=>49, :total=>96},
        2=>{:wins=>40, :total=>89},
        24=>{:wins=>48, :total=>98},
        52=>{:wins=>36, :total=>86},
        29=>{:wins=>26, :total=>82},
        26=>{:wins=>33, :total=>82},
        12=>{:wins=>25, :total=>82},
        53=>{:wins=>19, :total=>82},
        22=>{:wins=>20, :total=>82},
        21=>{:wins=>29, :total=>82},
        28=>{:wins=>31, :total=>82},
        6=>{:wins=>31, :total=>82},
        4=>{:wins=>27, :total=>82},
        25=>{:wins=>29, :total=>82},
        13=>{:wins=>24, :total=>82},
        10=>{:wins=>27, :total=>82},
        17=>{:wins=>37, :total=>89},
        7=>{:wins=>15, :total=>82},
        20=>{:wins=>35, :total=>93},
        1=>{:wins=>28, :total=>82},
        23=>{:wins=>42, :total=>88},
        18=>{:wins=>45, :total=>88}
      }
    assert_equal expected, @season_statistics.winningest_coach("20142015", @object_data.games, @object_data.game_teams)
  end

end

# winningest_coach	Name of the Coach with the best win percentage for the season	String
