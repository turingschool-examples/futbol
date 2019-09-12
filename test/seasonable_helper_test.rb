require './test/test_helper'
require './lib/stat_tracker'
require './lib/seasonable'
require './lib/seasonable_helper'

class SeasonableHelperTest < Minitest::Test

  def setup
    @game_path = './data/games.csv'
    @team_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'

    @locations = {
      games: @game_path,
      teams: @team_path,
      game_teams: @game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(@locations)
  end

  def test_coach_win_percentage_helper
    expected = {"Adam Oates"=>0.35, "Alain Vigneault"=>0.51, "Barry Trotz"=>0.51, "Bill Peters"=>0.3, "Bob Hartley"=>0.38, "Bruce Boudreau"=>0.49, "Claude Julien"=>0.38, "Craig Berube"=>0.33, "Craig MacTavish"=>0.2, "Dallas Eakins"=>0.29, "Darryl Sutter"=>0.4, "Dave Cameron"=>0.43, "Dave Tippett"=>0.23, "Gerard Gallant"=>0.29, "Jack Capuano"=>0.45, "Joel Quenneville"=>0.42, "Jon Cooper"=>0.42, "Ken Hitchcock"=>0.43, "Lindy Ruff"=>0.35, "Michel Therrien"=>0.49, "Mike Babcock"=>0.42, "Mike Johnston"=>0.43, "Mike Yeo"=>0.46, "Patrick Roy"=>0.35, "Paul MacLean"=>0.3, "Paul Maurice"=>0.42, "Peter DeBoer"=>0.33, "Peter Horachek"=>0.21, "Peter Laviolette"=>0.51, "Randy Carlyle"=>0.45, "Ted Nolan"=>0.18, "Todd McLellan"=>0.38, "Todd Nelson"=>0.22, "Todd Richards"=>0.32, "Willie Desjardins"=>0.48}

    assert_equal expected, @stat_tracker.coach_win_percentage_helper("20142015")
  end

  # Working
  def test_coach_array_helper
    expected = ["Adam Oates", "Alain Vigneault", "Barry Trotz", "Bill Peters", "Bob Boughner", "Bob Hartley", "Bruce Boudreau", "Bruce Cassidy", "Claude Julien", "Claude Noel", "Craig Berube", "Craig MacTavish", "Dallas Eakins", "Dan Bylsma", "Dan Lacroix", "Darryl Sutter", "Dave Cameron", "Dave Hakstol", "Dave Tippett", "Doug Weight", "Gerard Gallant", "Glen Gulutzan", "Guy Boucher", "Jack Capuano", "Jared Bednar", "Jeff Blashill", "Joe Sacco", "Joel Quenneville", "John Hynes", "John Stevens", "John Torchetti", "John Tortorella", "Jon Cooper", "Ken Hitchcock", "Kevin Dineen", "Kirk Muller", "Lindy Ruff", "Martin Raymond", "Michel Therrien", "Mike Babcock", "Mike Johnston", "Mike Sullivan", "Mike Yeo", "Patrick Roy", "Paul MacLean", "Paul Maurice", "Peter DeBoer", "Peter Horachek", "Peter Laviolette", "Phil Housley", "Ralph Krueger", "Randy Carlyle", "Rick Tocchet", "Ron Rolston", "Ted Nolan", "Todd McLellan", "Todd Nelson", "Todd Richards", "Tom Rowe", "Travis Green", "Willie Desjardins"]

    assert_equal expected, @stat_tracker.coach_array_helper
  end

  # Working
  def test_season_converter
    assert_equal 2013, @stat_tracker.season_converter("20132014")
  end

end
