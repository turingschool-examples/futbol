require 'spec_helper'

RSpec.describe StatTracker do
  before(:each) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.new(locations)
  end

  describe '.from_csv and inherits' do
    it 'exists' do
      expect(@stat_tracker).to be_a(StatTracker)
    end

    it 'inherits from stat data and CSV data' do
      expect(StatTracker.superclass).to eq(StatData)
      expect(@stat_tracker.game_data).to be_a CSV::Table
      expect(@stat_tracker.team_data).to be_a CSV::Table
      expect(@stat_tracker.game_teams_data).to be_a CSV::Table
    end
  end

  describe '#all_games' do
    it 'makes an array of game objects' do
      expect(@stat_tracker.all_games).to be_an(Array)
      expect(@stat_tracker.all_games).to all(be_a Game)
      expect(@stat_tracker.all_games.count).to eq(7441)
    end
  end

  describe '#all_teams' do
    it 'makes an array of team objects' do
      expect(@stat_tracker.all_teams).to be_an(Array)
      expect(@stat_tracker.all_teams).to all(be_a Team)
      expect(@stat_tracker.all_teams.count).to eq(32)
    end

    it 'adds games to a teams games array' do
      expect(@stat_tracker.all_teams[0].games).to be_an(Array)
      expect(@stat_tracker.all_teams[0].games).to all(be_a Game)
      expect(@stat_tracker.all_teams[0].games.empty?).to be(false)
    end
  end

  describe '#all_game_teams' do
    it 'makes an array of game team objects' do
      expect(@stat_tracker.all_game_teams).to be_an Array
      expect(@stat_tracker.all_game_teams).to all(be_a GameTeam)
      expect(@stat_tracker.all_game_teams.count).to eq(14_882)
    end
  end

  describe '#games_by_season' do
    it 'games by season' do
      expect(@stat_tracker.games_by_season).to be_a(Hash)
    end
  end

  describe '#game_teams_by_season' do
    it 'returns an array of game_teams corresponding to a seasons games' do
      expect(@stat_tracker.game_teams_by_season('20122013')).to be_an(Array)
      expect(@stat_tracker.game_teams_by_season('20122013').count).to eq(806 * 2)
    end
  end

  describe '#team_name_by_id' do
    it 'returns the team name by given id' do
      expect(@stat_tracker.team_name_by_id(1)).to eq('Atlanta United')
    end
  end

  describe '#average_goals_by_season' do
    it 'returns a hash of season keys and average goals value' do
      expected = {
        '20122013' => 4.12,
        '20162017' => 4.23,
        '20142015' => 4.14,
        '20152016' => 4.16,
        '20132014' => 4.19,
        '20172018' => 4.44
      }

      expect(@stat_tracker.average_goals_by_season).to eq(expected)
    end
  end

  describe '#counts_games_by_season' do
    it 'counts games by season' do
      expect(@stat_tracker.count_of_games_by_season).to be_a(Hash)

      expected = {
        '20122013' => 806,
        '20132014' => 1323,
        '20142015' => 1319,
        '20152016' => 1321,
        '20162017' => 1317,
        '20172018' => 1355
      }

      expect(@stat_tracker.count_of_games_by_season).to eq(expected)
    end
  end

  describe '#count_of_teams' do
    it 'counts the number of teams' do
      expect(@stat_tracker.count_of_teams).to eq(32)
    end
  end

  describe '#avg_score_per_game' do
    it 'calculates average number of goals per game' do
      expect(@stat_tracker.avg_score_per_game([1, 2, 3, 4])).to eq(2.5)
    end
  end

  describe '#percentage_wins' do
    it 'calculates the percentage of wins for all teams playing home games' do
      expect(@stat_tracker.percentage_home_wins).to eq(0.44)
    end

    it 'calculates the percentage of wins for all teams playing away games' do
      expect(@stat_tracker.percentage_visitor_wins).to eq(0.36)
    end

    it 'calculates the percentage of ties for all teams across all seasons' do
      expect(@stat_tracker.percentage_ties).to eq(0.20)
    end
  end

  describe '#most_tackles and #fewest_tackles' do
    it 'returns the name of the team with the most tackles of a given season' do
      expect(@stat_tracker.most_tackles('20132014')).to eq('FC Cincinnati')
    end

    it 'returns the name of the team with the fewest tackles of a given season' do
      expect(@stat_tracker.fewest_tackles('20142015')).to eq('Orlando City SC')
    end
  end

  describe '#highest_scoring_home_team and #lowest_scoring_home_team' do
    it 'returns the home team with the highest score' do
      expect(@stat_tracker.highest_scoring_home_team).to eq('Reign FC')
    end

    it 'returns the home team with the lowest score' do
      expect(@stat_tracker.lowest_scoring_home_team).to eq('Utah Royals FC')
    end
  end

  describe '#best_offense and #worst_offense' do
    it 'calculates the best_offense with the highest number of goals per game' do
      expect(@stat_tracker.best_offense).to eq('Reign FC')
    end

    it 'calculates the worst_offense with the highest number of goals per game' do
      expect(@stat_tracker.worst_offense).to eq('Utah Royals FC')
    end
  end

  describe '#most_accurate_team and #least_accurate_team' do
    it 'returns the name of the team witha seasons  most accurate goals to shots ratio' do
      expect(@stat_tracker.most_accurate_team('20132014')).to eq('Real Salt Lake')
    end

    it 'returns the name of the team with a seasons least accurate goals to shots ratio' do
      expect(@stat_tracker.least_accurate_team('20142015')).to eq('Columbus Crew SC')
    end
  end

  describe '#goals_to_shots_ratio' do
    it 'returns a hash of team key and goals to shots ratio' do
      expect(@stat_tracker.goals_to_shots_ratio('20122013')).to be_a(Hash)
      expect(@stat_tracker.goals_to_shots_ratio('20122013').keys.all?(Integer)).to be true
      expect(@stat_tracker.goals_to_shots_ratio('20122013').values.all?(Float)).to be true
    end
  end

  describe '#Highest and lowest scoring teams' do
    it "shows lowest scoring away team's name across all seasons" do
      expect(@stat_tracker.lowest_scoring_visitor).to eq('San Jose Earthquakes')
    end

    it "shows highest scoring away team's name across all seasons" do
      expect(@stat_tracker.highest_scoring_visitor).to eq('FC Dallas')
    end
  end
end
