# require 'rspec'
require './lib/season_stats'
require './lib/stat_tracker'


RSpec.describe TeamStatistics do
  before(:all) do
    game_path = './data/dummy_games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/dummy_game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @stat_tracker = StatTracker.from_csv(locations)
  end
  
  describe '#find_season' do
    it 'returns the relevant games based on the season' do
      expect(@stat_tracker.find_season('20122013').first).to be_a(CSV::Row)

      expect(@stat_tracker.find_season('20102011')).to eq([])
    end
  end
  
  describe '#total_goals(season)' do
    it 'returns a hash containing key value pair of team_id and total goals for that team' do
      expect(@stat_tracker.total_goals('20122013')).to eq({"17"=>6.0, "16"=>2.0})
    end
  end
  
  describe '#total_shots(season)' do
    it 'returns a hash containing key value pair of team_id and total shots for that team' do
      expect(@stat_tracker.total_shots('20122013')).to eq({"17"=>19.0, "16"=>18.0})
    end
  end
  
  describe '#most_accurate_team(season)' do
    it 'returns the team that made the most accurate shots over the season' do
      expect(@stat_tracker.most_accurate_team('20142015')).to eq('New York Red Bulls')
    end
  end

  describe '#least_accurate_team(season)' do
    it 'returns the team that made the least accurate shots over the season' do
      expect(@stat_tracker.least_accurate_team('20142015')).to eq('New York City FC')
    end
  end
  
  describe '#total_games_played_per_team(season)' do
    it 'returns a hash containing a key value pair of coach and number of games' do
      expect(@stat_tracker.total_games_played_per_team("20122013")).to eq({"Mike Babcock"=>3, "Joel Quenneville"=>2})
    end
  end
  
  describe '#total_wins_per_team(season)' do
    it 'returns a hash containing a key value pair of coach and number of wins' do
      expect(@stat_tracker.total_wins_per_team('20122013')).to eq({"Mike Babcock"=>2, "Joel Quenneville"=>1})
    end
  end
  
  describe '#winningest_coach(season)' do
    it 'returns the name of the coach with the best win record over a given season' do
      expect(@stat_tracker.winningest_coach('20122013')).to eq("Mike Babcock")
    end
  end
    
  describe '#worst_coach(season)' do
    it 'returns the name of the coach with the worst win record over a given season' do
      expect(@stat_tracker.worst_coach('20122013')).to eq("Joel Quenneville")
    end
  end
  
  describe "#most_tackles" do
    it 'returns the name of the team with the most tackles in a given season' do
      expect(@stat_tracker.most_tackles("20122013")).to eq "LA Galaxy"
      expect(@stat_tracker.most_tackles("20142015")).to eq "New York Red Bulls"
    end
  end

  describe "#fewest_tackles" do
    it 'returns the name of the team with the most tackles in a given season' do
      expect(@stat_tracker.fewest_tackles("20132014")).to eq "Chicago Red Stars"
      expect(@stat_tracker.fewest_tackles("20142015")).to eq "New York City FC"
    end
  end
  
end