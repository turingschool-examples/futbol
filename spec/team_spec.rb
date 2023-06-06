require 'rspec'
require './lib/team'
RSpec.describe Team do
  before(:each) do
    @team_data = "./data/teams_sampl.csv"
    @tm = Team.new(@team_data)
  end
  it 'exists' do
  expect(@tm).to be_instance_of(Team)
  end
end

