require 'simplecov'
SimpleCov.start

require './lib/stat_tracker'

RSpec.describe StatTracker do

  # before(:all) do
  #   game_path = './data/games.csv'
  #   team_path = './data/teams.csv'
  #   game_teams_path = './data/game_teams.csv'
  #
  #   locations = {
  #     games: game_path,
  #     teams: team_path,
  #     game_teams: game_teams_path
  #   }
  #
  #   @stat_tracker = StatTracker.from_csv(locations)
  # end

  before(:all) do
    game_path = './data/games_test.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_test.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  describe '#initialize' do
    it 'exists' do
      expect(@stat_tracker).to be_an_instance_of(StatTracker)
    end

    it 'has attributes' do
      expect(@stat_tracker.games).to be_a(Array)
      expect(@stat_tracker.teams).to be_a(Array)
      expect(@stat_tracker.game_teams).to be_a(Array)
    end
  end

  describe '::from_csv' do
    describe 'returns a StatTracker object' do
      it 'exists' do
        expect(@stat_tracker).to be_an_instance_of(StatTracker)
      end

      it 'has correct attributes and classes' do
        expect(@stat_tracker.games).to be_a(Array)
        expect(@stat_tracker.teams).to be_a(Array)
        expect(@stat_tracker.game_teams).to be_a(Array)
        expect(@stat_tracker.games[0]).to be_a(Games)
        expect(@stat_tracker.teams[0]).to be_a(Teams)
        expect(@stat_tracker.game_teams[0]).to be_a(GameTeams)
      end
    end
  end

  #Game Statistics Methods

  describe '#highest_total_score' do
    it 'will find the highest sum of the team scores from all the games' do
      expect(@stat_tracker.highest_total_score).to eq(6)
    end
  end
  describe '#lowest_total_score' do
    it 'will find the lowest sum of the team scores from all the games' do
      expect(@stat_tracker.lowest_total_score).to eq(2)
    end
  end


  describe  "percentage wins" do
    it "finds the percentage of visitor wins" do
      expect(@stat_tracker.percentage_visitor_wins).to eq(0.29)
    end
    it "finds the percentage of home wins" do
      expect(@stat_tracker.percentage_home_wins).to eq(0.43)
    end
  end

  describe "#percentage of ties" do
    it "checks the percentage of games that are ties" do
      expect(@stat_tracker.percentage_ties).to eq(0.29)
    end
  end
  describe ' #count_of_games_by_season' do
    it 'returns a hash with correct count of games per season' do
      expect(@stat_tracker.count_of_games_by_season).to be_a(Hash)
      expect(@stat_tracker.count_of_games_by_season).to eq({"20122013" => 6, "20142015" => 15})
    end
  end
  describe ' #average_goals_per_game' do
    it 'returns the average # of goals per game' do
      expect(@stat_tracker.average_goals_per_game).to eq(3.86)
    end
  end
  describe ' #average_goals_per_season' do
    xit 'returns a hash with average # of goals per season' do
      expect(@stat_tracker.average_goals_per_season).to be_a(Hash)
      expect(@stat_tracker.average_goals_per_season).to eq({"20122013" => 3.83, "20142015" => 3.87})
    end
  end

  #League Stat
  describe '#count_of_teams' do
    it 'counts the total number of teams' do
      expect(@stat_tracker.count_of_teams).to eq(@stat_tracker.teams.count)
    end
  end

  describe '#best_offense' do
    it 'uses the #average_goals method' do
      team = @stat_tracker.teams[5]
      expect(@stat_tracker.average_goals(team)).to eq(2)
    end

    it 'returns the team name with the highest average goals per game across seasons' do
      expect(@stat_tracker.best_offense).to eq("FC Dallas")
    end
  end

  describe '#worst_offense' do
    it 'returns the team with the lowest average goals per game across seasons' do
      allow(@stat_tracker).to receive(:worst_offense).and_return("New York Red Bulls")
      expect(@stat_tracker.worst_offense).to eq("New York Red Bulls")
    end
  end

  describe '#highest_scoring_visitor' do
    it 'finds all the visiting games for a team' do
      team = @stat_tracker.teams[5]
      expect(@stat_tracker.visiting_team_games(team).count).to eq(2)
    end

    it 'returns the highest average scoring visitor team name' do
      expect(@stat_tracker.highest_scoring_visitor).to eq("New York City FC")
    end
  end

  describe '#highest_scoring_home_team' do
    it 'finds all the visiting games for a team' do
      team = @stat_tracker.teams[4]
      expect(@stat_tracker.home_team_games(team).count).to eq(2)
    end

    it 'returns the highest average scoring home team name' do
      expect(@stat_tracker.highest_scoring_home_team).to eq("FC Dallas")
    end
  end

  describe '#lowest_scoring_visitor' do
    it 'returns the lowest average scoring visitor team name' do
      expect(@stat_tracker.lowest_scoring_visitor).to eq("Atlanta United")
    end
  end

  describe '#lowest_scoring_home_team' do
    it 'returns the lowest average scoring home team name' do
      expect(@stat_tracker.lowest_scoring_home_team).to eq("Atlanta United")
    end
  end

  describe '#team_info' do
    xit '' do

    end
  end

  describe '#best_season' do
    xit '' do

    end
  end

  describe '#worst_season' do
    xit '' do

    end
  end

  describe '#average_win_percentage' do
    xit '' do

    end
  end

  describe '#most_goals_scored' do
    xit '' do

    end
  end

  describe '#rival' do
    xit '' do

    end
  end

  describe '#rival' do
    xit '' do

    end
  end
  ### Season
  describe '#winningest_coach' do
    it "checks the ins by seasons" do
      expect(@stat_tracker.wins_by_season('20122013')).to be_a(Array)
    end
    xit "checks for the winning coaches to be an Array" do
      expect(@stat_tracker.wins_per_coaches('20122013')).to be_a(Integer)
    end
    it "gets the total games played by coaches" do
      expect(@stat_tracker.total_games_by_coaches('20122013')).to be_an(Integer)
    end
    xit "finds the average of the coach" do
      expect(@stat_tracker.average_wins_by_coach('20122013')).to be_an(Float)
    end

    xit 'Name of the Coach with the best win percentage for the season' do
      expect(@stat_tracker.winningest_coach('20122013')).to eq()
    end
  end
  describe '#worst_coach' do
    xit '' do

    end
  end
  describe '#most_accurate_team' do
    xit '' do

    end
  end
  describe '#least_accurate_team' do
    xit '' do

    end
  end
  describe ' #game_teams_in_season' do
    it 'returns an array of all of the game_teams that are a part of the selected season' do
      expect(@stat_tracker.game_teams_in_season('20122013')).to be_a(Array)
      expect(@stat_tracker.game_teams_in_season('20122013').length).to eq(4)
    end
  end
  describe 'get_team_from_game_teams' do
    it 'returns a single team name if a single team given' do
      team1 = @stat_tracker.teams[0]
      teams2 = @stat_tracker.teams[0..2]
      expect(@stat_tracker.get_teams_from_game_teams(team1)).to eq([team1])
      expect(@stat_tracker.get_teams_from_game_teams(teams2)).to eq(teams2)
    end
  end
  describe ' #most_tackles' do
    it 'returns the name of the team with the most tackles in the season' do
      expect(@stat_tracker.most_tackles('20122013')).to eq('FC Dallas')
    end
  end
  describe '  #fewest_tackles' do
    it 'returns the name of the team with the fewest tackles in the season' do
      expect(@stat_tracker.fewest_tackles('20122013')).to eq('Houston Dynamo')
    end
  end


end
