require 'csv' 
require 'rspec'
require './lib/team.rb'

describe Team do 
	team_file = CSV.read('./data/game_teams_sample.csv', headers: true, header_converters: :symbol)
  team_array = team_file.map do |row|
  Team.new(row)
	end 

  before(:each) do 
  	@team = team_array
  end

  it 'exists' do 
		expect(@team).to be_an(Array)
  	expect(@team.sample).to be_an_instance_of(Team)
  end

	it 'has attributes' do 
		expect(@team.first.game_id).to eq("2012030221")
    expect(@team.first.team_id).to eq("3")
    expect(@team.first.hoa).to eq("5/16/13")
    expect(@team.first.result).to eq("LOSS")
    expect(@team.first.settled_in).to eq("OT")
    expect(@team.first.head_coach).to eq("John Tortorella")
    expect(@team.first.goals).to eq("2")
    expect(@team.first.shots).to eq("8")
    expect(@team.first.tackles).to eq("44")
    expect(@team.first.pim).to eq("8")
    expect(@team.first.power_play_opps).to eq("Toyota Stadium")
    expect(@team.first.power_play_goals).to eq("Toyota Stadium")
    expect(@team.first.face_off_win_percentage).to eq("Toyota Stadium")
    expect(@team.first.giveaways).to eq("17")
    expect(@team.first.takeaways).to eq("7")
	end
end

