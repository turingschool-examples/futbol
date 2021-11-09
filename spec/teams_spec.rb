require 'csv' 
require 'rspec'
require './lib/teams.rb'

describe Teams do 
	team_file = CSV.read('./data/teams.csv', headers: true, header_converters: :symbol)
  team_array = team_file.map do |row|
  Teams.new(row)
	end 

  before(:each) do 
  	@teams = team_array
  end

   it 'exists' do 
		expect(@teams).to be_an(Array)
  	expect(@teams.sample).to be_an_instance_of(Teams)
  end

  it 'has attributes' do 
		expect(@teams.first.team_id).to eq("1")
    expect(@teams.first.franchise_id).to eq("23")
    expect(@teams.first.teamname).to eq("Atlanta United")
    expect(@teams.first.abbreviation).to eq("ATL")
    expect(@teams.first.stadium).to eq("Mercedes-Benz Stadium")
    expect(@teams.first.link).to eq("/api/v1/teams/1")
	end
end
