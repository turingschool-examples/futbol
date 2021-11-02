require 'simplecov'
SimpleCov.start
SimpleCov.command_name 'Unit Tests'
require './lib/creator'
require './lib/stat_tracker'

RSpec.describe Creator do
  # let(:league){double("league")}
  let!(:stat_tracker) do
    game_path = './spec/fixtures/spec_games.csv'
    team_path = './spec/fixtures/spec_teams.csv'
    game_teams_path = './spec/fixtures/spec_game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    StatTracker.from_csv(locations)
  end
  let!(:game_data){stat_tracker.game_data}
  let!(:team_data){stat_tracker.team_data}
  let!(:game_team_data){stat_tracker.game_team_data}
  let(:creator) { Creator.create_objects(game_data, team_data, game_team_data) }
  let(:league) {creator.league}
  describe '#initialize' do
    it "exists" do
      expect(creator).to be_a(Creator)
    end

    it "is an attribute" do
      expect(creator.league).to eq(league)
    end

  end

  describe  '#stat_obj_creator' do
    it "creates objects" do
      expect(creator.stat_obj_creator(game_team_data)).to be_a Array
    end
  end
  # describe "#league" do
  #   it "creates league object" do
  #   expect(creator.league).to be_a(League)
  #   end
  # end

end
