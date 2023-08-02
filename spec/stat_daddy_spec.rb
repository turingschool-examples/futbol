require 'spec_helper'

RSpec.describe StatDaddy do
  before(:each) do
    @game_path = './data/games.csv'
    @teams_path = './data/teams.csv'
    @game_teams_path = './data/game_teams.csv'
    @games_fixture_path = './data/games_fixture.csv'
    @game_teams_fixture_path = './data/games_teams_fixture.csv'
    @locations = {
      games: @game_path,
      teams: @teams_path,
      game_teams: @game_teams_path,
    }
    @stat_daddy = StatDaddy.new(@locations)
  end
  describe "#initialize" do
    it "exists" do
      expect(@stat_daddy).to be_a StatDaddy
    end
  end
end