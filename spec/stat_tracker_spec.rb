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

    it "#percentage_home_wins" do
      expect(stat_tracker.percentage_home_wins).to eq 0.71
    end

    it '#percentage_visitor_wins' do
      expect(stat_tracker.percentage_visitor_wins).to eq 0.29
    end

    it '#percentage_ties' do
      expect(stat_tracker.percentage_ties).to eq 0.03
    end

    it '#count_of_games_by_season' do
      expected = {
        "20122013"=>17,
        "20162017"=>4,
        "20142015"=>18,
        "20152016"=>22,
        "20132014"=>13
      }
      expect(stat_tracker.count_of_games_by_season).to eq expected
    end

    it '#average_goals_per_game' do
      expect(stat_tracker.average_goals_per_game).to eq 4.01
    end

    it '#average_goals_by_season' do
      expected = {
      "20122013"=>3.88,
      "20162017"=>4.75,
      "20142015"=>3.89,
      "20152016"=>4.0,
      "20132014"=>4.15
      }
      expect(stat_tracker.average_goals_by_season).to eq expected
    end
  end
# # # League Statistics
  context 'league statistics' do

    it '#count_of_teams' do
      expect(stat_tracker.count_of_teams).to eq 32
    end

    it '#best_offense' do
      expect(stat_tracker.best_offense).to eq "New York City FC"
    end

    it '#worst_offense' do
      expect(stat_tracker.worst_offense).to eq "Orlando City SC"
    end

    it '#highest_scoring_visitor' do
      expect(stat_tracker.highest_scoring_visitor).to eq "New York City FC"
    end

    it '#highest_scoring_home_team' do
      expect(stat_tracker.highest_scoring_home_team).to eq "New York City FC"
    end

    it '#lowest_scoring_visitor' do
      expect(stat_tracker.lowest_scoring_visitor).to eq "Seattle Sounders FC"
    end

    it '#lowest_scoring_home_team' do
      expect(stat_tracker.lowest_scoring_home_team).to eq "Orlando City SC"
    end
  end
# # # Season Statistics
  context 'season statistics' do 

    it '#winningest_coach' do

      expect(stat_tracker.winningest_coach("20122013")).to eq("Adam Oates")
      expect(stat_tracker.winningest_coach("20152016")).to eq("Lindy Ruff")
    end

    it '#worst_coach' do
      expect(stat_tracker.worst_coach("20122013")).to eq("John Tortorella")
      expect(stat_tracker.worst_coach("20152016")).to eq("Paul Maurice")
    end

    it '#most_accurate_team' do
      expect(stat_tracker.most_accurate_team("20122013")).to eq("Portland Timbers")
      expect(stat_tracker.most_accurate_team("20152016")).to eq("Chicago Red Stars")
    end

    it '#least_accurate_team' do
      expect(stat_tracker.least_accurate_team("20122013")).to eq("Houston Dynamo")
      expect(stat_tracker.least_accurate_team("20152016")).to eq("Portland Thorns FC")
    end

    it '#most_tackles' do
      expect(stat_tracker.most_tackles("20122013")).to eq("Seattle Sounders FC")
      expect(stat_tracker.most_tackles("20152016")).to eq("Chicago Red Stars")
    end

    it '#fewest_tackles' do
      expect(stat_tracker.fewest_tackles("20122013")).to eq("Portland Timbers")
      expect(stat_tracker.fewest_tackles("20152016")).to eq("Portland Thorns FC")
    end

  end
# # # Team Statistics
  context 'team statistics' do 

    it '#team_info' do
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