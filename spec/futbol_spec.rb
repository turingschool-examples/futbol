require 'spec_helper'

RSpec.describe Futbol do
  before(:each) do
    game_path = './spec/fixtures/games.csv'
    team_path = './spec/fixtures/teams.csv'
    game_teams_path = './spec/fixtures/data/game_teams.csv'
    locations = {
    games: game_path,
    teams: team_path,
    game_teams: game_teams_path
    }

  @futbol = Futbol.new(locations)
  end

  describe "#initialize" do
    it "exists" do
      expect(@futbol).to be_an_instance_of(Futbol)
      require 'pry'; binding.pry
    end
  end





end