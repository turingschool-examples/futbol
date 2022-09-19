require 'spec_helper'

RSpec.describe Season do
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
    @season = Season.new(@teams_data,@game_teams_data)
  end

  it 'should be a class' do
    expect(@season).to be_instance_of Season
  end

  describe 'it handles the Season methods' do
    it "#winningest_coach" do
      expect(@season.winningest_coach("20132014")).to eq "Claude Julien"
      expect(@season.winningest_coach("20142015")).to eq "Alain Vigneault"
    end

    it "#worst_coach" do
      expect(@season.worst_coach("20132014")).to eq "Peter Laviolette"
      expect(@season.worst_coach("20142015")).to eq("Craig MacTavish").or(eq("Ted Nolan"))
    end

    it "#most_accurate_team" do
      expect(@season.most_accurate_team("20132014")).to eq "Real Salt Lake"
      expect(@season.most_accurate_team("20142015")).to eq "Toronto FC"
    end

    it "#least_accurate_team" do
      expect(@season.least_accurate_team("20132014")).to eq "New York City FC"
      expect(@season.least_accurate_team("20142015")).to eq "Columbus Crew SC"
    end

    it "#most_tackles" do
      expect(@season.most_tackles("20132014")).to eq "FC Cincinnati"
      expect(@season.most_tackles("20142015")).to eq "Seattle Sounders FC"
    end

    it "#fewest_tackles" do
      expect(@season.fewest_tackles("20132014")).to eq "Atlanta United"
      expect(@season.fewest_tackles("20142015")).to eq "Orlando City SC"
    end
  end

end