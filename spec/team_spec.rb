require 'csv'
require './lib/team'

RSpec.describe Team do
  before do
    @team_data = "./data/teams_sampl.csv"
    @team_lines = CSV.open @team_data, headers: true, header_converters: :symbol
    teams = []
    @team_lines.each do |line|
      teams << Team.new(line)
    end
    @team1 = teams[0]
    @team2 = teams[1]
    @team3 = teams[2]
  end

it 'exists' do
  expect(@team1).to be_instance_of(Team)
  expect(@team2).to be_instance_of(Team)
  expect(@team3).to be_instance_of(Team)
  end

  it 'has an id' do 
    expect(@team1.id).to eq("1")
    expect(@team2.id).to eq("4")
    expect(@team3.id).to eq("26") 
  end

  it 'has a team_name' do
    expect(@team1.team_name).to eq("Atlanta United")
    expect(@team2.team_name).to eq("Chicago Fire")
    expect(@team3.team_name).to eq("FC Cincinnati")
  end
end

