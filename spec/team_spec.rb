require 'csv'
require './lib/team.rb' 
require './lib/stat_tracker'

RSpec.describe Team do

  let(:team){Team.new(info)}
  let(:info){{
    "team_id"=>"1",
    "franchiseId"=>"23",
    "teamName"=>"Atlanta United",
    "abbreviation"=>"ATL",
    "Stadium"=>"Mercedes-Benz Stadium",
    "link"=>"/api/v1/teams/1"
  }} 
  let(:team_2){Team.new(info_2)}
  let(:info_2){{
    "team_id"=>"4",
    "franchiseId"=>"16",
    "teamName"=>"Chicago Fire",
    "abbreviation"=>"CHI",
    "Stadium"=>"SeatGeek Stadium",
    "link"=>"/api/v1/teams/4"
  }} 

    it "exists as a Game object" do 

      expect(team).to be_an_instance_of(Team)

    end 

    it "returns a team object with these attributes" do 
      expect(team.team_id).to eq("1")
      expect(team.franchise_id).to eq("23")
      expect(team.team_name).to eq("Atlanta United")
      expect(team.abbreviation).to eq("ATL")
      expect(team.stadium).to eq("Mercedes-Benz Stadium")
      expect(team.link).to eq("/api/v1/teams/1")
    end

    it "works with multiple teams" do 
  
      expect(team_2.team_id).to eq("4")
      expect(team_2.franchise_id).to eq("16")
      expect(team_2.team_name).to eq("Chicago Fire")
      expect(team_2.abbreviation).to eq("CHI")
      expect(team_2.stadium).to eq("SeatGeek Stadium")
      expect(team_2.link).to eq("/api/v1/teams/4")

    end



    # it "pushes the information to a new array after creating the team" do



    # end

      

  end