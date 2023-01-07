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

	describe 'determines average scores and compares' do
		it 'creates a hash of teams by id and away goals' do
			expect(stat_tracker.team_away_goals_by_id).to be_a Hash
		end

		it 'creates a hash of teams by id and home goals' do
			expect(stat_tracker.team_home_goals_by_id).to be_a Hash
		end

		it 'averages away game scores per team' do
			expect(stat_tracker.average_score_away_game).to be_a Float
		end

		it 'averages home game scores per team' do
			expect(stat_tracker.average_score_home_game).to be_a Float
		end

		it 'averages home game scores per team' do
			expect(stat_tracker.highest_scoring_visitor).to be_a Float
		end
	end
	
		it "#highest_scoring_visitor" do
    	expect(stat_tracker.highest_scoring_visitor).to eq "FC Dallas"
  	end

  	it "#highest_scoring_home_team" do
    	expect(stat_tracker.highest_scoring_home_team).to eq "Reign FC"
  	end

  	it "#lowest_scoring_visitor" do
    	expect(stat_tracker.lowest_scoring_visitor).to eq "San Jose Earthquakes"
  	end

  	it "#lowest_scoring_home_team" do
    	expect(stat_tracker.lowest_scoring_home_team).to eq "Utah Royals FC"
  	end

  describe '#count_of_teams' do
    it 'is a integer' do
      expect(stat_tracker.count_of_teams).to be_a(Integer)
    end

    it 'returns total # of teams' do
      expect(stat_tracker.count_of_teams).to eq(32)
    end
  end

  describe '#best_offense' do
    it 'is a string' do
      expect(stat_tracker.best_offense).to be_a(String)
    end

    it 'returns team with highest average across all seasons' do
      expect(stat_tracker.best_offense).to eq("Reign FC")
    end
  end

  describe '#worst_offense' do
    it 'is a string' do
      expect(stat_tracker.worst_offense).to be_a(String)
    end

    it 'returns team with lowest average across all seasons' do
      expect(stat_tracker.worst_offense).to eq("Utah Royals FC")
    end
  end

  describe '#team_info' do
    it 'is a hash' do
      expect(stat_tracker.team_info("id")).to be_a(Hash)
    end

    it 'is a hash of info' do

    team = {
      "team_id" => "18",
      "franchise_id" => "34",
      "team_name" => "Minnesota United FC",
      "abbreviation" => "MIN",
      "link" => "/api/v1/teams/18"
    }

    expect(stat_tracker.team_info("18")).to eq(team)
    end
  end
end