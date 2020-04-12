require './lib/season_repository'
require 'minitest/autorun'
require 'minitest/pride'

#season_repository = SeasonRepository.new('./data/games.csv', './data/game_teams.csv', './data/teams.csv')

#season_repository.worst_coach("20122013")
#season_repository.number_of_games("20122013", "John Tortorella")


#it "#winningest_coach" do
#    expect(@stat_tracker.winningest_coach("20132014")).to eq "Claude Julien"
#    expect(@stat_tracker.winningest_coach("20142015")).to eq "Alain Vigneault"
#  end
#
#  it "#worst_coach" do
#    expect(@stat_tracker.worst_coach("20132014")).to eq "Peter Laviolette"
#    expect(@stat_tracker.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Ted Nolan"))
#  end


class SeasonRepositoryTest < Minitest::Test

  def test_winningest_coach
    season_repository = SeasonRepository.new('./data/games.csv', './data/game_teams.csv', './data/teams.csv')
    assert_equal "Claude Julien", season_repository.winningst_coach("20132014")
  end

  def test_worst_coach
    season_repository = SeasonRepository.new('./data/games.csv', './data/game_teams.csv', './data/teams.csv')
    assert_equal "Peter Laviolette", season_repository.worst_coach("20132014")
  end
end
