require_relative 'spec_helper'  
require './lib/stat_tracker'

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
  
  describe 'initialize' do
    it 'exists' do
      expect(@stat_tracker).is_a?(StatisticsGenerator)
      expect(@stat_tracker).to be_an_instance_of StatTracker
    end
  end

  describe 'percentage_home_wins' do
    it 'float of home teams that have won games' do
      expect(@stat_tracker.percentage_home_wins).to eq(0.44)
    end 
  end  

  describe 'percentage_visitor_wins' do
    it 'float of visitor teams that have won games' do
      expect(@stat_tracker.percentage_visitor_wins).to eq(0.36)
    end 
  end  

  describe 'percentage_ties' do
    it 'float of teams that tied games' do
      expect(@stat_tracker.percentage_ties).to eq(0.20)
    end 
  end  

  describe '#highest_total_score' do
    it 'sum of scores in highest scoring game' do
      expect(@stat_tracker.highest_total_score).to eq(11)
    end
  end

  describe '#average_goals_per_game' do
    it 'take average of goals scored in a game across all seasons, both home and away goals' do
    expect(@stat_tracker.average_goals_per_game).to eq(4.22)
    end
  end
  
  describe '#lowest_total_score' do
    it 'sum of scores in lowest scoring game' do
      expect(@stat_tracker.lowest_total_score).to eq(0)
    end
  end

  describe '#count_of_teams' do
    it '#count_of_teams' do
      expect(@stat_tracker.count_of_teams).to eq 32
    end
  end


  describe '#winningest_coach' do
    it 'coach with best win percentage for each season' do
      expect(@stat_tracker.winningest_coach("20122013")).to eq "Dan Lacroix"
      expect(@stat_tracker.winningest_coach("20132014")).to eq "Claude Julien"
      expect(@stat_tracker.winningest_coach("20142015")).to eq "Alain Vigneault"
      expect(@stat_tracker.winningest_coach("20152016")).to eq "Barry Trotz"
      expect(@stat_tracker.winningest_coach("20162017")).to eq "Bruce Cassidy"
      expect(@stat_tracker.winningest_coach("20172018")).to eq "Bruce Cassidy"
    end
   end
   
  describe '#count_of_games_by_season' do
    it '#count_of_games_by_season' do
      expect(@stat_tracker.count_of_games_by_season["20122013"]).to eq(806)
      expect(@stat_tracker.seasons_by_id["20122013"][:game_teams].length).to eq(1612)
    end
  end

  describe '#average_goals_by_season' do
    it '#average_goals_by_season' do
      expect(@stat_tracker.average_goals_by_season["20122013"]).to eq(4.12)
      expect(@stat_tracker.average_goals_by_season["20162017"]).to eq(4.23)
    end
  end

  describe '#most_accurate team' do
    it "#most_accurate_team" do
      expect(@stat_tracker.most_accurate_team("20132014")).to eq "Real Salt Lake"
      expect(@stat_tracker.most_accurate_team("20142015")).to eq "Toronto FC"
    end
  end

  describe '#least_accurate_team' do
    it '#least_accurate_team' do
      expect(@stat_tracker.least_accurate_team("20132014")).to eq "New York City FC"
      expect(@stat_tracker.least_accurate_team("20142015")).to eq "Columbus Crew SC"
    end
  end
  
  describe '#worst_coach' do
    it 'coach with worst win percentage for each season' do
    expect(@stat_tracker.worst_coach("20122013")).to eq "Martin Raymond"
    expect(@stat_tracker.worst_coach("20132014")).to eq "Peter Laviolette"
    expect(@stat_tracker.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Ted Nolan"))
    expect(@stat_tracker.worst_coach("20152016")).to eq "Todd Richards"
    expect(@stat_tracker.worst_coach("20162017")).to eq "Dave Tippett"
    expect(@stat_tracker.worst_coach("20172018")).to eq "Phil Housley"
    end
  end

  describe '#lowest_scoring_visitor' do
    it "name of team that scored lowest average goals while away" do
      expect(@stat_tracker.lowest_scoring_visitor).to eq "San Jose Earthquakes"
    end
  end
    
  describe 'offense' do
    it 'has #best_offense' do
      expect(@stat_tracker.best_offense).to eq "Reign FC"
    end
    
    it "#worst_offense" do
      expect(@stat_tracker.worst_offense).to eq "Utah Royals FC"
    end
  end
    
  describe 'lowest_scoring_home_team' do
    it "name of team that scored lowest average goals while home" do
      expect(@stat_tracker.lowest_scoring_home_team).to eq "Utah Royals FC"
    end
  
    it "#highest_scoring_visitor" do
    expect(@stat_tracker.highest_scoring_visitor).to eq "FC Dallas"
    end

    it "#highest_scoring_home_team" do
    expect(@stat_tracker.highest_scoring_home_team).to eq "Reign FC"
    end
  end

  describe "Tackles" do
    it "#most_tackles" do
      expect(@stat_tracker.most_tackles("20132014")).to eq "FC Cincinnati"
      expect(@stat_tracker.most_tackles("20142015")).to eq "Seattle Sounders FC"
    end

    it "#fewest_tackles" do
      expect(@stat_tracker.fewest_tackles("20132014")).to eq "Atlanta United"
      expect(@stat_tracker.fewest_tackles("20142015")).to eq "Orlando City SC"
    end
  end


  describe "#best and #worst season" do
    it "#best_season" do
    expect(@stat_tracker.best_season("6")).to eq "20132014"
  end

    it "#worst_season" do
      expect(@stat_tracker.worst_season("6")).to eq "20142015"
    end
  end

  describe "team info" do
    it "returns team info" do
      expect(@stat_tracker.team_info("3")).to eq({
        "team_id" => "3",
        "franchise_id" => "10",
        "team_name" => "Houston Dynamo",
        "abbreviation" => "HOU",
        "link" => "/api/v1/teams/3"
      })
    end
  end
end

