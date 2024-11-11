require_relative 'spec_helper'

RSpec.describe StatCalculator do
  before(:all) do
    Games.load_csv('./data/games.csv')
    GameTeams.from_csv('./data/game_teams.csv')
    Teams.load_csv('./data/teams.csv')

    @games = Games.all
    @teams = Teams.all
    @game_teams = GameTeams.all
    @stat_calculator = StatCalculator.new(@games, @teams, @game_teams)
    
    # Set season-specific expected results - update these based on the CSV files
    @season_id = "20122013"  # Example season_id; replace with an appropriate one based on your dataset
    @expected_winningest_coach = "Dan Lacroix"    # Expected coach with the highest win percentage for the season
    @expected_worst_coach = "Martin Raymond"      # Expected coach with the lowest win percentage for the season
  end

  describe '#initialize' do
    it 'exists' do
      expect(@stat_calculator).to be_an_instance_of(StatCalculator)
    end

    it 'has attributes' do
      expect(@stat_calculator.games).to eq(Games.all)
      expect(@stat_calculator.teams).to eq(Teams.all)
      expect(@stat_calculator.game_teams).to eq(GameTeams.all)
    end
  end

  describe '#average_goals_per_game' do
    it "#average_goals_per_game" do
      expect(@stat_calculator.average_goals_per_game).to eq(4.22)
    end
  end

  describe '#average_goals_by_season' do
    it "#average_goals_by_season" do
      expected = {
        "20122013"=>4.12,
        "20162017"=>4.23,
        "20142015"=>4.14,
        "20152016"=>4.16,
        "20132014"=>4.19,
        "20172018"=>4.44
      }
      expect(@stat_calculator.average_goals_by_season).to eq(expected)
    end
  end

  describe '#count_of_teams' do
    it 'returns the number of teams' do
      expect(@stat_calculator.count_of_teams).to eq(32)
      expect(Teams.all.count).to eq(32)
    end
  end

  describe '#highest_total_score' do
    it 'returns the highest total score' do
      expect(@stat_calculator.highest_total_score).to eq(11)
    end
  end

  describe '#lowest_total_score' do
    it 'returns the lowest total score' do
      expect(@stat_calculator.lowest_total_score).to eq(0)  
    end
  end

# Tests for Win Percentage Calculations
# Test 1: Verifies that the method dynamically calculates the correct percentage of home wins
  describe '#percentage_home_wins' do
    it 'calculates the dynamically determined percentage of games won by the home team' do
      # Calculate dynamically based on the current dataset
      home_wins = @games.count { |game| game.home_goals.to_i > game.away_goals.to_i }
      total_games = @games.size
      expected_percentage = ((home_wins.to_f / total_games) * 100).round(2)

      expect(@stat_calculator.percentage_home_wins).to eq(expected_percentage)
    end
# Test 2: Verifies that the method returns 0.0 when there are no games in the dataset
    it 'returns 0.0 when there are no games' do
      empty_stat_calculator = StatCalculator.new([], @teams, @game_teams)
      expect(empty_stat_calculator.percentage_home_wins).to eq(0.0)
    end
  end

  # Test 3: Verifies that the method dynamically calculates the correct percentage of visitor wins
  describe '#percentage_visitor_wins' do
    it 'calculates the dynamically determined percentage of games won by the visiting team' do
      # Calculate dynamically based on the current dataset
      visitor_wins = @games.count { |game| game.away_goals.to_i > game.home_goals.to_i }
      total_games = @games.size
      expected_percentage = ((visitor_wins.to_f / total_games) * 100).round(2)

      expect(@stat_calculator.percentage_visitor_wins).to eq(expected_percentage)
    end
 # Test 4: Verifies that the method returns 0.0 when there are no games in the dataset
    it 'returns 0.0 when there are no games' do
      empty_stat_calculator = StatCalculator.new([], @teams, @game_teams)
      expect(empty_stat_calculator.percentage_visitor_wins).to eq(0.0)
    end
  end

  # Test 5: Verifies that the method dynamically calculates the correct percentage of tied games
  describe '#percentage_ties' do
    it 'calculates the dynamically determined percentage of games that resulted in a tie' do
      # Calculate dynamically based on the current dataset
      ties = @games.count { |game| game.home_goals.to_i == game.away_goals.to_i }
      total_games = @games.size
      expected_percentage = ((ties.to_f / total_games) * 100).round(2)

      expect(@stat_calculator.percentage_ties).to eq(expected_percentage)
    end
# Test 6: Verifies that the method returns 0.0 when there are no games in the dataset
    it 'returns 0.0 when there are no games' do
      empty_stat_calculator = StatCalculator.new([], @teams, @game_teams)
      expect(empty_stat_calculator.percentage_ties).to eq(0.0)
    end
  end

  # Tests for Coach Performance Calculations by Season

describe '#winningest_coach' do
  # Test 1: Ensures the coach with the highest win percentage for a given season is returned
  it 'returns the coach with the highest win percentage for a specific season' do
    expect(@stat_calculator.winningest_coach(@season_id)).to eq(@expected_winningest_coach)
  end

  # Test 2: Handles edge case where no data exists for the given season
  it 'returns nil if no games are found for the specified season' do
    expect(@stat_calculator.winningest_coach("INVALID_SEASON")).to be_nil
  end

  # Test 3: Handles a season where multiple coaches exist with data
  it 'correctly determines the coach with the highest win percentage when multiple coaches exist' do
    season_with_multiple_coaches = "20132014" # Season ID where multiple coaches have data
    expected_coach = "Claude Julien" # Expected coach.
    expect(@stat_calculator.winningest_coach(season_with_multiple_coaches)).to eq(expected_coach)
  end

  # Test 4: Handles a dataset with only one coach for the season
  it 'returns the only coach available for the season when there is only one' do
    season_with_one_coach = "20142015" # Season ID where only one coach exists
    expected_coach = "Alain Vigneault" # Expected coach
    expect(@stat_calculator.winningest_coach(season_with_one_coach)).to eq(expected_coach)
  end

  # Test 5: Handles a season where all games are losses
  it 'returns nil when all coaches have a win percentage of 0.0 for the season' do
    season_with_no_wins = "2013021105" # Replace with a real season ID where all games are losses
    expect(@stat_calculator.winningest_coach(season_with_no_wins)).to be_nil
  end
end

  describe '#worst_coach' do
    # Test 1: Ensures the coach with the lowest win percentage for a given season is returned
    it 'returns the coach with the lowest win percentage for a specific season' do
      expect(@stat_calculator.worst_coach(@season_id)).to eq(@expected_worst_coach)
    end

    # Test 2: Handles edge case where no data exists for the given season
    it 'returns nil if no games are found for the specified season' do
      expect(@stat_calculator.worst_coach("INVALID_SEASON")).to be_nil
    end
  end
  describe '#highest_scoring_visitor' do
    it 'returns the name of the away team with the highest average score' do
      expect(@stat_calculator.highest_scoring_visitor).to eq("FC Dallas")
    end
  end

  describe '#lowest_scoring_visitor' do
    it 'returns the name of the away team with the lowest average score' do
      expect(@stat_calculator.lowest_scoring_visitor).to eq("San Jose Earthquakes")
    end
  end

  describe '#count_of_games_by_season' do
    it 'returns the total number of games for each season' do
      expected = {
        "20122013"=>806,
        "20162017"=>1317,
        "20142015"=>1319,
        "20152016"=>1321,
        "20132014"=>1323,
        "20172018"=>1355
      }
      expect(@stat_calculator.count_of_games_by_season).to eq(expected)
    end
  end

  describe '#highest_scoring_home_team' do
    it 'returns the name of the home team with the highest average score' do
      expect(@stat_calculator.highest_scoring_home_team).to eq("Reign FC")
    end
  end

  describe '#lowest_scoring_home_team' do
    it 'returns the name of the home team with the lowest average score' do
      expect(@stat_calculator.lowest_scoring_home_team).to eq("Utah Royals FC")
    end
  end
      
  describe '#best_offense' do
    it "returns name of the team with the highest average number of goals scored per game across all seasons" do
      expect(@stat_calculator.best_offense).to eq("Reign FC")
    end
  end

  describe '#worst_offense' do
    it "returns name of the team with the lowest average number of goals scored per game across all seasons" do
      expect(@stat_calculator.worst_offense).to eq("Utah Royals FC")
    end
  end

  describe '#most_tackles' do
    it "returns name of the Team with the most tackles in the season" do
      expect(@stat_calculator.most_tackles("20132014")).to eq("FC Cincinnati")
      expect(@stat_calculator.most_tackles("20142015")).to eq("Seattle Sounders FC")
    end
  end

  describe '#fewest_tackles' do
    it "returns name of the Team with the fewest tackles in the season" do
      expect(@stat_calculator.fewest_tackles("20132014")).to eq("Atlanta United")
      expect(@stat_calculator.fewest_tackles("20142015")).to eq("Orlando City SC")
    end
  end
end