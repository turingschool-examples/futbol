require 'spec_helper'
require 'team'
require 'league'
RSpec.describe Team do
  before(:all) do
    game_path = './data/games.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    @teams_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    @game_teams_data = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
    @games_data = CSV.read(locations[:games], headers: true, header_converters: :symbol)
    @team = Team.new(@teams_data, @game_teams_data, @games_data)
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
      expect(@team.team_info('18')).to eq(expected)
    end
  end

  describe '#average_win_percentage' do
    it 'can tell the average win rate of a given team' do
      expect(@team.average_win_percentage('6')).to eq 0.49
    end
  end

  describe '#most_goals_scored' do
    it 'can show what game a team scored the most goals' do
      expect(@team.most_goals_scored('18')).to eq 7
    end
  end

  describe '#fewest_goals_scored' do
    it '#fewest_goals_scored' do
      expect(@team.fewest_goals_scored('18')).to eq 0
    end
  end

  describe '#favorite_opponent' do
    it '#favorite_opponent' do
      expect(@team.favorite_opponent('18')).to eq 'DC United'
    end
  end

  describe '#rival' do
    it '#rival' do
      expect(@team.rival('18')).to eq('Houston Dash').or(eq('LA Galaxy'))
    end
  end
  describe '#win_loss_hashes' do
    it 'gathers the opponents win/loss information against given team' do
      rival_stats = [{"19"=>15,
        "18"=>0,
        "52"=>14,
        "21"=>12,
        "17"=>9,
        "29"=>6,
        "25"=>10,
        "20"=>7,
        "30"=>11,
        "16"=>14,
        "3"=>3,
        "22"=>4,
        "28"=>11,
        "24"=>8,
        "5"=>9,
        "8"=>3,
        "23"=>7,
        "15"=>5,
        "26"=>8,
        "27"=>2,
        "6"=>3,
        "13"=>6,
        "10"=>5,
        "7"=>3,
        "2"=>4,
        "14"=>0,
        "4"=>2,
        "9"=>2,
        "12"=>4,
        "1"=>4,
        "53"=>3,
        "54"=>1},
       {"19"=>19,
        "52"=>17,
        "21"=>20,
        "20"=>11,
        "16"=>24,
        "1"=>6,
        "29"=>9,
        "8"=>7,
        "23"=>11,
        "14"=>10,
        "15"=>5,
        "25"=>17,
        "28"=>14,
        "22"=>14,
        "24"=>23,
        "5"=>7,
        "2"=>6,
        "7"=>7,
        "27"=>4,
        "6"=>7,
        "3"=>7,
        "30"=>16,
        "13"=>4,
        "10"=>5,
        "9"=>8,
        "26"=>10,
        "12"=>6,
        "54"=>2,
        "4"=>8,
        "17"=>5,
        "53"=>9}]
      expect(@team.win_loss_hashes("18")).to eq(rival_stats)
    end
  end

  describe 'Team statistics-best & worse season methods'do
    it "#season" do
      expect(@team.season).to eq(["20122013", "20162017", "20142015", "20152016", "20132014", "20172018"])
    end
    
    it "#season_average_percentage" do
      expect(@team.season_average_percentage('6')).to eq({"20122013"=>0.5429, "20132014"=>0.5745, "20142015"=>0.378, "20152016"=>0.4024, "20162017"=>0.5114, "20172018"=>0.5319})
    end
    
    it "#season_hash" do
      expect(@team.season_hash('6')).to be_a Hash
    end
    
    it "#best_season" do
      expect(@team.best_season("6")).to eq("20132014")
    end

    it "#worst_season" do
      expect(@team.worst_season("6")).to eq("20142015")
    end
  end
end
