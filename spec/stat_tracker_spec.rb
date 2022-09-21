require 'spec_helper'

RSpec.describe StatTracker do
  before(:all) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

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
  end

  describe '#game stats' do
    it 'can find total game score for each game' do 
      expect(@stat_tracker.total_game_goals.count).to eq(7441)
      expect(@stat_tracker.total_game_goals[4]).to eq(4)
      expect(@stat_tracker.total_game_goals[399]).to eq(6)
    end

    it 'can calculate the highest sum of the winning and losing teams scores' do 
      expect(@stat_tracker.highest_total_score).to eq(11)
    end

    it 'can calculate the lowest sum of the winning and losing teams scores' do
      expect(@stat_tracker.lowest_total_score).to eq(0)
    end

    it 'can calculate the percentage of games that a home team has won (to nearest 100th)' do
      expect(@stat_tracker.percentage_home_wins).to eq(0.44)
    end

    it 'can calculate the percentage of games that an visitor team has won (to nearest 100th)' do
      expect(@stat_tracker.percentage_visitor_wins).to eq(0.36)
    end

    it 'can calculate percentage of games that has resulted in a tie (rounded to the nearest 100th)' do
      expect(@stat_tracker.percentage_ties).to eq(0.2)
    end
  end

    it 'can calculate number of games by season' do
      expected = {
        "20122013"=>806,
        "20162017"=>1317,
        "20142015"=>1319,
        "20152016"=>1321,
        "20132014"=>1323,
        "20172018"=>1355
      }
      expect(@stat_tracker.count_of_games_by_season).to eq expected
    end

    it 'can calculate the average goals per game' do 
      expect(@stat_tracker.average_goals_per_game).to eq 4.22
    end

    it 'can calculate the average goals by season' do
      expected = {
      "20122013"=>4.12,
      "20162017"=>4.23,
      "20142015"=>4.14,
      "20152016"=>4.16,
      "20132014"=>4.19,
      "20172018"=>4.44
      }
      expect(@stat_tracker.average_goals_by_season).to eq expected
    end
  
  describe 'it handles the Season methods' do
    it "#winningest_coach" do
      expect(@stat_tracker.winningest_coach("20132014")).to eq "Claude Julien"
      expect(@stat_tracker.winningest_coach("20142015")).to eq "Alain Vigneault"
    end

    it "#worst_coach" do
      expect(@stat_tracker.worst_coach("20132014")).to eq "Peter Laviolette"
      expect(@stat_tracker.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Ted Nolan"))
    end

    it "#most_accurate_team" do
      expect(@stat_tracker.most_accurate_team("20132014")).to eq "Real Salt Lake"
      expect(@stat_tracker.most_accurate_team("20142015")).to eq "Toronto FC"
    end

    it "#least_accurate_team" do
      expect(@stat_tracker.least_accurate_team("20132014")).to eq "New York City FC"
      expect(@stat_tracker.least_accurate_team("20142015")).to eq "Columbus Crew SC"
    end

    it "#most_tackles" do
      expect(@stat_tracker.most_tackles("20132014")).to eq "FC Cincinnati"
      expect(@stat_tracker.most_tackles("20142015")).to eq "Seattle Sounders FC"
    end

    it "#fewest_tackles" do
      expect(@stat_tracker.fewest_tackles("20132014")).to eq "Atlanta United"
      expect(@stat_tracker.fewest_tackles("20142015")).to eq "Orlando City SC"
    end
  end

  describe '#League Statistics' do
    it 'returns the number of teams in the league' do
      expect(@stat_tracker.count_of_teams).to eq 32
    end

    it 'returns the team with highest average number of goals scored per game all seasons' do
      expect(@stat_tracker.best_offense).to eq "Reign FC"
    end

    it 'returns the worst offense' do
      expect(@stat_tracker.worst_offense).to eq "Utah Royals FC"
    end

    it "#highest_scoring_visitor" do
      expect(@stat_tracker.highest_scoring_visitor).to eq "FC Dallas"
    end

    it "#highest_scoring_home_team" do
      expect(@stat_tracker.highest_scoring_home_team).to eq "Reign FC"
    end

    it "#lowest_scoring_visitor" do
      expect(@stat_tracker.lowest_scoring_visitor).to eq "San Jose Earthquakes"
    end

    it "#lowest_scoring_home_team" do
      expect(@stat_tracker.lowest_scoring_home_team).to eq "Utah Royals FC"
    end
  end

  describe 'team statistics' do
    it 'can make a hash with key/value pairs for the following attributes' do
      expected = {
        'team_id' => '18',
        'franchise_id' => '34',
        'team_name' => 'Minnesota United FC',
        'abbreviation' => 'MIN',
        'link' => '/api/v1/teams/18'
      }
      expect(@stat_tracker.team_info('18')).to eq(expected)
    end
  end
  
  describe '#average_win_percentage' do
    it 'can tell the average win rate of a given team' do
      expect(@stat_tracker.average_win_percentage("6")).to eq 0.49
    end
  end
  
  describe '#most_goals_scored' do
    it "can show what game a team scored the most goals" do
      expect(@stat_tracker.most_goals_scored("18")).to eq 7
    end
  end
  
  describe '#fewest_goals_scored' do
    it "#fewest_goals_scored" do
      expect(@stat_tracker.fewest_goals_scored("18")).to eq 0
    end
  end
  
  describe '#favorite_opponent' do
    it "#favorite_opponent" do
      expect(@stat_tracker.favorite_opponent("18")).to eq "DC United"
    end
  end
  
  describe '#rival' do
    it "#rival" do
      expect(@stat_tracker.rival("18")).to eq("Houston Dash").or(eq("LA Galaxy"))
    end
  end


  describe 'Team statistics-best & worse season methods'do
    it "#season" do
      expect(@stat_tracker.season).to eq(["20122013", "20162017", "20142015", "20152016", "20132014", "20172018"])
    end
    
    it "#season_average_percentage" do
      expect(@stat_tracker.season_average_percentage('6')).to eq({"20122013"=>0.5429, "20132014"=>0.5745, "20142015"=>0.378, "20152016"=>0.4024, "20162017"=>0.5114, "20172018"=>0.5319})
    end
    
    it "#season_hash" do
      expect(@stat_tracker.season_hash('6')).to be_a Hash
    end
    
    it "#best_season" do
      expect(@stat_tracker.best_season("6")).to eq("20132014")
    end

    it "#worst_season" do
      expect(@stat_tracker.worst_season("6")).to eq("20142015")
    end
  end
end