require 'spec_helper'

RSpec.describe Season do
  before(:all) do
    fixture_game_path = 'spec/fixture/games_fixture.csv'
    fixture_team_path = 'spec/fixture/teams_fixture.csv'
    fixture_game_teams_path = 'spec/fixture/game_teams_fixture.csv'

    locations = {
      games: fixture_game_path,
      teams: fixture_team_path,
      game_teams: fixture_game_teams_path
    }
    @teams_data = CSV.read(locations[:teams], headers: true, header_converters: :symbol)
    @game_teams_data = CSV.read(locations[:game_teams], headers: true, header_converters: :symbol)
    @season = Season.new(@teams_data,@game_teams_data)
  end

  it 'should be a class' do
    expect(@season).to be_instance_of(Season)
  end

  describe 'it handles the Season methods' do
    it "#winningest_coach" do
      expect(@season.winningest_coach("20132014")).to eq("Todd McLellan")
      expect(@season.winningest_coach("20142015")).to eq "Alain Vigneault"
    end

    it "#worst_coach" do
      expect(@season.worst_coach("20132014")).to eq("Bob Hartley")
      expect(@season.worst_coach("20142015")).to eq("Ken Hitchcock")
    end

    it "#most_accurate_team" do
      expect(@season.most_accurate_team("20132014")).to eq("New England Revolution")
      expect(@season.most_accurate_team("20142015")).to eq("DC United")
    end

    it "#least_accurate_team" do
      expect(@season.least_accurate_team("20132014")).to eq("Houston Dash")
      expect(@season.least_accurate_team("20142015")).to eq("Portland Timbers")
    end

    it "#most_tackles" do
      expect(@season.most_tackles("20132014")).to eq("Portland Timbers")
      expect(@season.most_tackles("20142015")).to eq("DC United")
    end

    it "#fewest_tackles" do
      expect(@season.fewest_tackles("20132014")).to eq("New England Revolution")
      expect(@season.fewest_tackles("20142015")).to eq("Portland Timbers")
    end

    it '#team_tackles' do
      team_total_tackles = {
        "20"=>18, 
        "28"=>14,
        "30"=>22,
        "24"=>24,
        "15"=>83, 
        "3"=>50, 
        "18"=>24, 
        "4"=>35, 
        "16"=>8, 
        "52"=>28, 
        "6"=>19, 
        "29"=>22, 
        "12"=>28, 
        "13"=>12
      }
      expect(@season.team_tackles("20132014")).to eq(team_total_tackles)
    end

    it '#team_name_from_team_id' do
    # will be renamed and placed in module
      expect(@season.team_name_from_team_id(["16", 3.333])).to eq("New England Revolution")
    end

    it '#season_data' do
    # testing an output on set?
      expect(@season.season_data("20132014")).to be_instance_of Set
    end
  end
end