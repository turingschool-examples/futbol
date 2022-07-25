require './lib/stat_tracker'
require_relative '../data/teams.csv'
# require 'pry'; binding.pry

RSpec.describe StatTracker do
  
  it '1. exists' do
    stat_tracker = StatTracker.new("filepath")

    expect(stat_tracker).to be_an_instance_of StatTracker
  end

  it '2. can load filepath' do
    team_path = './data/teams.csv'
    location = {teams: team_path}
    stat_tracker = StatTracker.new(location)

    expect(stat_tracker[0]).to eq "team_id,franchiseId,teamName,abbreviation,Stadium,link"
  end
end