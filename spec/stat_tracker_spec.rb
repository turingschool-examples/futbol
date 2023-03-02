require_relative 'spec_helper'  
require './lib/stat_tracker'

RSpec.describe StatTracker do
  before(:each) do 
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'
    
    @locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    
    @stat_tracker = StatTracker.from_csv(@locations)
  end
  
  describe 'initialize' do
    xit 'exists' do
      expect(@stat_tracker).to be_an_instance_of StatTracker
    end
    
    xit 'processed team data, retrieves data from teams' do
      expect(@stat_tracker.processed_teams_data(@locations)).to all(be_a(Team))
    end

    xit 'processed team data, retrieves data from teams' do
      expect(@stat_tracker.processed_games_data(@locations)).to all(be_a(Game))
    end

    xit 'processed season data, creates hash of season info' do
      expect(@stat_tracker.seasons_by_id).to be_a(Hash)
      expect(@stat_tracker.seasons_by_id["20122013"][:games]).to all(be_a(Game))
      expect(@stat_tracker.seasons_by_id["20122013"][:game_teams]).to all(be_a(GameTeam))
    end


    xit 'can parse data into a string of objects' do
      expect(@stat_tracker.games).to be_a(Array)
      expect(@stat_tracker.games).to all(be_a(Game))
    end
    xit 'processed team data, retrieves data from teams' do
      expect(@stat_tracker.processed_game_teams_data(@locations)).to all(be_a(GameTeam))
    end
  end

  describe 'percentage_home_wins' do
    xit 'float of home teams that have won games' do
      expect(@stat_tracker.percentage_home_wins).to eq(0.44)
    end 
  end  

  describe 'percentage_visitor_wins' do
    xit 'float of visitor teams that have won games' do
      expect(@stat_tracker.percentage_visitor_wins).to eq(0.36)
    end 
  end  

  describe 'percentage_ties' do
    xit 'float of teams that tied games' do
      expect(@stat_tracker.percentage_ties).to eq(0.20)
    end 
  end  

  describe '#highest_total_score' do
    xit 'sum of scores in highest scoring game' do
      expect(@stat_tracker.highest_total_score).to eq(11)
    end
  end

  describe '#average_goals_per_game' do
    xit 'take average of goals scored in a game across all seasons, both home and away goals' do
    expect(@stat_tracker.average_goals_per_game).to eq(4.22)
    end
  end
  
  describe '#lowest_total_score' do
    xit 'sum of scores in lowest scoring game' do
      expect(@stat_tracker.lowest_total_score).to eq(0)
    end
  end

  describe '#count_of_teams' do
    xit '#count_of_teams' do
      expect(@stat_tracker.count_of_teams).to eq 32
    end
  end

  describe '#count_of_games_per_season' do
    xit '#count_of_games_per_season' do
      expect(@stat_tracker.count_of_games_per_season("20122013")).to eq(806)
      expect(@stat_tracker.seasons_by_id["20122013"][:game_teams].length).to eq(1612)
    end
  end

  describe '#average_goals_by_season' do
    xit '#average_goals_by_season' do
      expect(@stat_tracker.average_goals_by_season("20122013")).to eq(4.12)
      expect(@stat_tracker.average_goals_by_season("20162017")).to eq(4.23)
    end
  end

  describe '#most_accurate team' do
    xit "#most_accurate_team" do
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
end