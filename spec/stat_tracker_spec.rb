RSpec.describe StatTracker do
  mock_games_data = './data/mock_games.csv' 
  team_data = './data/teams.csv' 
  mock_game_teams_data = './data/mock_game_teams.csv' 
  
  let!(:mock_locations) {{games: mock_games_data, teams: team_data, game_teams: mock_game_teams_data}}

  let!(:stat_tracker) { StatTracker.from_csv(mock_locations) }
  
  context 'stat_tracker instantiates' do
    it 'should have a class' do
      expect(stat_tracker).to be_a StatTracker
    end

    it 'self method should be an instance of the class' do
      expect(StatTracker.from_csv(mock_locations)).to be_a StatTracker
    end
  end

  context 'game statistics' do

    it '#highest_total_score' do
      expect(stat_tracker.highest_total_score).to eq 8
    end

    it "#lowest_total_score" do
      expect(stat_tracker.lowest_total_score).to eq 1
    end

    xit "#percentage_home_wins" do
      expect(stat_tracker.percentage_home_wins).to eq 0.44
    end

    xit '#percentage_visitor_wins' do
      expect(stat_tracker.percentage_visitor_wins).to eq 0.36
    end

    xit '#percentage_ties' do
      expect(stat_tracker.percentage_ties).to eq 0.20
    end

    xit '#count_of_games_by_season' do
      expected = {
        "20122013"=>806,
        "20162017"=>1317,
        "20142015"=>1319,
        "20152016"=>1321,
        "20132014"=>1323,
        "20172018"=>1355
      }
      expect(stat_tracker.count_of_games_by_season).to eq expected
    end

    xit '#average_goals_per_game' do
      expect(stat_tracker.average_goals_per_game).to eq 4.22
    end

    xit '#average_goals_by_season' do
      expected = {
      "20122013"=>4.12,
      "20162017"=>4.23,
      "20142015"=>4.14,
      "20152016"=>4.16,
      "20132014"=>4.19,
      "20172018"=>4.44
      }
      expect(stat_tracker.average_goals_by_season).to eq expected
    end
  end
# # # League Statistics
  context 'league statistics' do

    xit '#count_of_teams' do
      expect(stat_tracker.count_of_teams).to eq 32
    end

    xit '#best_offense' do
      expect(stat_tracker.best_offense).to eq "Reign FC"
    end

    xit '#worst_offense' do
      expect(stat_tracker.worst_offense).to eq "Utah Royals FC"
    end

    xit '#highest_scoring_visitor' do
      expect(stat_tracker.highest_scoring_visitor).to eq "FC Dallas"
    end

    xit '#highest_scoring_home_team' do
      expect(stat_tracker.highest_scoring_home_team).to eq "Reign FC"
    end

    xit '#lowest_scoring_visitor' do
      expect(stat_tracker.lowest_scoring_visitor).to eq "San Jose Earthquakes"
    end

    xit '#lowest_scoring_home_team' do
      expect(stat_tracker.lowest_scoring_home_team).to eq "Utah Royals FC"
    end
  end
# # # Season Statistics
  context 'season statistics' do 

    xit '#winningest_coach' do
      expect(stat_tracker.winningest_coach).to eq("Dan Lacroix")
    end

    xit '#worst_coach' do
      expect(stat_tracker.worst_coach).to eq("Martin Raymond")
    end

    xit '#most_accurate_team' do
      expect(stat_tracker.most_accurate_team).to eq("Chicago Red Stars")
    end

    xit '#least_accurate_team' do
      expect(stat_tracker.least_accurate_team).to eq("New England Revolution")
    end

    xit '#most_tackles' do

      expect(stat_tracker.most_tackles).to eq("Orlando Pride")
    end

    xit '#fewest_tackles' do
      expect(stat_tracker.fewest_tackles).to eq("Philadelphia Union")
    end
  end
# # # Team Statistics
  context 'team statistics' do 

    xit '#team_info' do
      expect(stat_tracker.team_info("1")).to eq({:abbreviation=>"ATL", :franchise_id=>"23", :link=>"/api/v1/teams/1", :team_id=>"1", :team_name=>"Atlanta United"})
    end

    xit '#best_season' do

    end

    xit '#worst_season' do

    end

    xit '#average_win_percentage' do

    end

    xit '#most_goals_scored' do

    end

    xit '#fewest_goals_scored' do

    end

    xit '#favorite_opponent' do

    end

    xit '#rival' do

    end
  end
end