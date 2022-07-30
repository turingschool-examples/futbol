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
      expect(stat_tracker.highest_total_score).to eq 9
    end

    it "#lowest_total_score" do
      expect(stat_tracker.lowest_total_score).to eq 1
    end

    it "#percentage_home_wins" do
      expect(stat_tracker.percentage_home_wins).to eq 0.55
    end

    it '#percentage_visitor_wins' do
      expect(stat_tracker.percentage_visitor_wins).to eq 0.34
    end

    it '#percentage_ties' do
      expect(stat_tracker.percentage_ties).to eq 0.11
    end

    it '#count_of_games_by_season' do
      expected = {
        "20122013"=>36,
        "20162017"=>16,
        "20142015"=>18,
        "20152016"=>41,
        "20132014"=>13,
        "20172018"=>24
      }
      expect(stat_tracker.count_of_games_by_season).to eq expected
    end

    it '#average_goals_per_game' do
      expect(stat_tracker.average_goals_per_game).to eq 4.09
    end

    it '#average_goals_by_season' do
      expected = {
      "20122013"=>3.92,
      "20162017"=>4.56,
      "20142015"=>3.89,
      "20152016"=>4.02,
      "20132014"=>4.15,
      "20172018"=>4.29
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
      expect(stat_tracker.best_offense).to eq 'Columbus Crew SC'
    end

    it '#worst_offense' do
      expect(stat_tracker.worst_offense).to eq 'Houston Dynamo'
    end

    it '#highest_scoring_visitor' do
      expect(stat_tracker.highest_scoring_visitor).to eq 'Columbus Crew SC'
    end

    it '#highest_scoring_home_team' do
      expect(stat_tracker.highest_scoring_home_team).to eq 'Chicago Red Stars'
    end

    it '#lowest_scoring_visitor' do
      expect(stat_tracker.lowest_scoring_visitor).to eq 'Philadelphia Union'
    end

    it '#lowest_scoring_home_team' do
      expect(stat_tracker.lowest_scoring_home_team).to eq 'Chicago Fire'
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
      expect(stat_tracker.team_info(28)).to eq({:abbreviation=> "LFC", :franchise_id=> "29", :link=> "/api/v1/teams/28", :team_id=> "28", :team_name=> "Los Angeles FC"})
    end

    it '#best_season' do
      expect(stat_tracker.best_season(28)).to eq '20162017'
    end

    it '#worst_season' do
      expect(stat_tracker.worst_season(28)).to eq '20172018'
    end

    it '#average_win_percentage' do
      expect(stat_tracker.average_win_percentage(28)).to eq 62.5
    end

    it '#most_goals_scored' do
      expect(stat_tracker.most_goals_scored(28)).to eq '4'
    end

    it '#fewest_goals_scored' do
      expect(stat_tracker.fewest_goals_scored(28)).to eq 0
    end

    it '#favorite_opponent' do
      expect(stat_tracker.favorite_opponent(28)).to eq 'FC Cincinnati'
    end
    
    it '#rival' do
      expect(stat_tracker.rival(28)).to eq 'Seattle Sounders FC'
    end
  end
end