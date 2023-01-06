require_relative 'spec_helper'

RSpec.describe StatTracker do

  let(:stat_tracker) { 
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    StatTracker.from_csv(locations) 
  }
    
  describe '#initialize' do
	  it 'exists' do
      expect(stat_tracker).to be_a StatTracker
	  end

    it 'has attributes' do
      expect(stat_tracker.game_teams).to be_a(CSV::Table)
      expect(stat_tracker.games).to be_a(CSV::Table)
      expect(stat_tracker.teams).to be_a(CSV::Table)
    end

    it 'can count # of teams' do 
      expect(stat_tracker.teams.count).to eq(32)
    end

    it 'can see game venues' do 
      expect(stat_tracker.games[:venue].include?("Toyota Stadium")).to eq(true)
    end

    it 'can see game team ids' do 
      expect(stat_tracker.game_teams[:game_id][1].to_i).to eq(2012030221)
    end
  end  

	describe 'checks percentage of wins/ties' do
		it "#percentage_home_wins" do
		expect(stat_tracker.percentage_home_wins).to eq 0.44
	end

		it "#percentage_visitor_wins" do
			expect(stat_tracker.percentage_visitor_wins).to eq 0.36
		end

		it "#percentage_ties" do
			expect(stat_tracker.percentage_ties).to eq 0.20
		end
	end

  describe 'compares total scores' do
    it 'finds total score' do
      expect(stat_tracker.total_score).to be_a(Array)
    end
    
    it 'finds highest total score' do
      expect(stat_tracker.highest_total_score).to eq(11)
    end

    it 'finds lowest total score' do
      expect(stat_tracker.lowest_total_score).to eq(0)
    end
  end


  describe '#count_of_games_by_season' do
    it 'is a hash' do
      expect(stat_tracker.count_of_games_by_season).to be_a(Hash)
    end

    it 'can return number of games by season' do

      expected_hash = {
        "20122013"=>806, 
        "20162017"=>1317,
        "20142015"=>1319,
        "20152016"=>1321,
        "20132014"=>1323,
        "20172018"=>1355
      }

      expect(stat_tracker.count_of_games_by_season).to eq(expected_hash)
      expect(stat_tracker.count_of_games_by_season["20122013"]).to eq(806)

    end
  end

  describe '#average_goals_per_game' do
    it 'is a float' do
      expect(stat_tracker.average_goals_per_game).to be_a(Float)
    end

    it 'can find average' do
      expect(stat_tracker.average_goals_per_game).to eq(4.22)
    end
  end

  describe '#average_goals_by_season' do
    it 'is a Hash' do
      expect(stat_tracker.average_goals_by_season).to be_a(Hash)
    end

    it 'can find average for season' do
      expected_hash = {
        "20122013"=>4.12,
        "20162017"=>4.23,
        "20142015"=>4.14,
        "20152016"=>4.16,
        "20132014"=>4.19,
        "20172018"=>4.44
      }

      expect(stat_tracker.average_goals_by_season["20122013"]).to eq(4.12)
      expect(stat_tracker.average_goals_by_season).to eq(expected_hash)
    end
  end

  describe '#count_of_teams' do
    it 'is a integer' do
      expect(stat_tracker.count_of_teams).to be_a(Integer)
    end
  end

end