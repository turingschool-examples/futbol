require "./lib/team.rb"
require './lib/stat_tracker.rb'
# require './runner.rb'

RSpec.describe Team do
  team_path = './data/teams_dummy.csv'
  let(:data) {CSV.parse(File.read(team_path), headers: true)}

  it 'exists' do
    team = Team.new(data)
    expect(team).to be_instance_of(Team)
  end
end
