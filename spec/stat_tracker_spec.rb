require './spec/spec_helper'

describe StatTracker do
  before :all do
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
      expect(@stat_tracker).to be_a(StatTracker)
    end

    it 'has a collection of games' do
      expect(@stat_tracker.games).to be_a(Array)
      expect(@stat_tracker.games[0]).to be_a(Game)
    end

    it 'has a collection of teams' do
      expect(@stat_tracker.teams).to be_a(Array)
      expect(@stat_tracker.teams[0]).to be_a(Team)
    end

    it 'has a collection of game teams' do
      expect(@stat_tracker.game_teams).to be_a(Array)
      expect(@stat_tracker.game_teams[0]).to be_a(GameTeam)
    end
  end

  describe '::from_csv' do
    it 'returns an object of type StatTracker' do
      expect(@stat_tracker).to be_a(StatTracker)
    end

    it 'returns a collection that holds Game objects created from external CSV data' do
      expect(@stat_tracker.games[0].venue).to eq("Toyota Stadium")
    end

    it 'returns a collection that holds Team objects created from external CSV data' do
      expect(@stat_tracker.teams[0].team_name).to eq("Atlanta United")
    end

    it 'returns a collection that holds GameTeam objects created from external CSV data' do
      expect(@stat_tracker.game_teams[0].head_coach).to eq("John Tortorella")
    end
  end

  # Game Statistics

  describe '#total_score' do
    it 'can return the highest total score' do
      expect(@stat_tracker.highest_total_score).to eq(11)
    end
  
    it 'can return the lowest total score' do
      expect(@stat_tracker.lowest_total_score).to eq(0)
    end
  end
  
  describe '#percentages' do
    it 'can return the percentage of home wins' do
      expect(@stat_tracker.percentage_home_wins).to eq(0.44)
    end
  
    it 'can return the percentage of visitor wins' do
      expect(@stat_tracker.percentage_visitor_wins).to eq(0.36)
    end
  
    it 'can return the percentage of ties' do
      expect(@stat_tracker.percentage_ties).to eq(0.20)
    end
  end
  
  describe "#count_of_games_by_season" do
    it "can return count of games by season in a hash" do
      expected = {
        "20122013"=>806,
        "20162017"=>1317,
        "20142015"=>1319,
        "20152016"=>1321,
        "20132014"=>1323,
        "20172018"=>1355
      }
      expect(@stat_tracker.count_of_games_by_season).to eq(expected)
    end
  end

  describe "#average_goals" do
    it "can find the average goals per game as a float" do
      expect(@stat_tracker.average_goals_per_game).to eq(4.22)
    end 
 
    it "can find the average goals by season" do
      expected = {
        "20122013"=>4.12,
        "20162017"=>4.23,
        "20142015"=>4.14,
        "20152016"=>4.16,
        "20132014"=>4.19,
        "20172018"=>4.44
      }
      expect(@stat_tracker.average_goals_by_season).to eq(expected)
    end
  end 

  #  League Stats
  
  describe '#count_of_teams' do
    it 'can return the count of teams' do
      expect(@stat_tracker.count_of_teams).to eq(32)
    end
  end

  describe '#offense' do
    it 'can find the team with the best offense' do
      expect(@stat_tracker.best_offense).to eq('Reign FC')
    end
  
    it 'can find the team with the worst offense' do
      expect(@stat_tracker.worst_offense).to eq('Utah Royals FC')
    end
  end

  describe "#average_scores" do 
    it "returns home average scores" do 
      expect(@stat_tracker.home_average_score).to be_a(Hash)
      expect(@stat_tracker.home_average_score["1"]).to eq(1.97)
      expect(@stat_tracker.home_average_score["17"]).to eq(2.08)
      expect(@stat_tracker.home_average_score["53"]).to eq(1.93)
    end
    
    it "returns visitor average scores" do
      expect(@stat_tracker.away_average_score).to be_a(Hash)
      expect(@stat_tracker.away_average_score["1"]).to eq(1.9)
      expect(@stat_tracker.away_average_score["17"]).to eq(2.04)
      expect(@stat_tracker.away_average_score["53"]).to eq(1.85)
    end
  end

  describe "#highest_scorers" do
    it "can find the name of the highest average scoring visitor" do
      expect(@stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
    end
  
    it "can find the name of the highest average home team" do
      expect(@stat_tracker.highest_scoring_home_team).to eq("Reign FC")
    end
  end
  
  describe '#lowest_scorers' do
    it "returns the visiting team name with the lowest average score" do 
      expect(@stat_tracker.lowest_scoring_visitor).to eq("San Jose Earthquakes")
    end
    
    it "returns the home team name with the lowest average score" do 
      expect(@stat_tracker.lowest_scoring_home_team).to eq("Utah Royals FC")
    end
  end
  
  describe "#team_name" do
    it "can find the team name based off of the team id" do
      expect(@stat_tracker.team_name("1")).to eq("Atlanta United")
    end
  end

  describe '#team_info' do 
    it "returns a hash with a specific teams info" do 
      expect(@stat_tracker.team_info("18")).to eq({
        "team_id" => "18", 
        "franchise_id" => "34", 
        "team_name" => "Minnesota United FC", 
        "abbreviation" => "MIN",
        "link" => "/api/v1/teams/18"
      })
    end
  end
  

  describe '#best and worst seasons' do
    it "can return the best season for a given team" do
      expect(@stat_tracker.best_season("6")).to eq("20132014")
    end

    it "can return the worst season for a given team" do
      expect(@stat_tracker.worst_season("6")).to eq("20142015")
    end
  end

  describe '#average_win_percentage' do
    it "retuns the average win percentage of all games for a team" do
      expect(@stat_tracker.average_win_percentage("6")).to eq(0.49)
    end
  end
  
  describe "#goals_scored" do
    it "can find the most goals scored by a given team" do
      expect(@stat_tracker.most_goals_scored("18")).to eq(7)
    end
  
    it "can find the fewest goals scored by a given team" do
      expect(@stat_tracker.fewest_goals_scored("18")).to eq(0)
    end
  end
  

  describe '#rivalries' do
    it "#favorite_opponent" do
      expect(@stat_tracker.favorite_opponent("18")).to eq("DC United")
    end

    it "#rival" do
      expect(@stat_tracker.rival("18")).to eq("Houston Dash").or(eq("LA Galaxy"))
    end
  end
  # Season 

  describe '#coach_stats' do 
    it "returns the name of the coach with the best win percentage for the season" do
      expect(@stat_tracker.winningest_coach("20132014")).to eq ("Claude Julien")
      expect(@stat_tracker.winningest_coach("20142015")).to eq ("Alain Vigneault")
    end

    it "returns the name of the coach with the worst win percentage for the season" do 
      expect(@stat_tracker.worst_coach("20132014")).to eq ("Peter Laviolette")
      expect(@stat_tracker.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Ted Nolan"))
    end
  end

  describe "#game_team_season" do
    it "can return the season of a given GameTeam object" do
      game_team = @stat_tracker.game_teams[0]
      corresponding_game = @stat_tracker.games[0]
      expect(@stat_tracker.game_team_season(game_team)).to eq(corresponding_game.season)
    end
  end

  describe "#team_accuracy" do
    it '#most_accurate_team' do
      expect(@stat_tracker.most_accurate_team("20132014")).to eq ("Real Salt Lake")
      expect(@stat_tracker.most_accurate_team("20142015")).to eq ("Toronto FC")
    end
    
    it "#least_accurate_team" do
      expect(@stat_tracker.least_accurate_team("20132014")).to eq ("New York City FC")
      expect(@stat_tracker.least_accurate_team("20142015")).to eq ("Columbus Crew SC")
    end
  end
    
  describe '#tackles' do 
    it 'can find the team with the most tackles for a given season' do
      expect(@stat_tracker.most_tackles('20132014')).to eq('FC Cincinnati')
      expect(@stat_tracker.most_tackles('20142015')).to eq('Seattle Sounders FC')
    end
  
    it 'can find the team with the fewest tackles for a given season' do
      expect(@stat_tracker.fewest_tackles('20132014')).to eq('Atlanta United')  
      expect(@stat_tracker.fewest_tackles('20142015')).to eq('Orlando City SC')  
    end
  end

end