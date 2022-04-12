require './lib/stat_tracker'
require './lib/team'

RSpec.describe Team do
  it "exists" do

    team1 = Team.new(1,23,"Atlanta United","ATL","Mercedes-Benz Stadium","/api/v1/teams/1")
    team2 = Team.new(4,16,"Chicago Fire","CHI","SeatGeek Stadium","/api/v1/teams/4")
    team3 = Team.new(26,14,"FC Cincinnati","CIN","Nippert Stadium","/api/v1/teams/26")

    expect(team1).to be_a(Team)
    expect(team2).to be_a(Team)
    expect(team3).to be_a(Team)

  end

  it "has an ID" do

    team1 = Team.new(1,23,"Atlanta United","ATL","Mercedes-Benz Stadium","/api/v1/teams/1")
    team2 = Team.new(4,16,"Chicago Fire","CHI","SeatGeek Stadium","/api/v1/teams/4")
    team3 = Team.new(26,14,"FC Cincinnati","CIN","Nippert Stadium","/api/v1/teams/26")

    expect(team1.team_id).to eq(1)
    expect(team2.team_id).to eq(4)
    expect(team3.team_id).to eq(26)
  end

  it "has a franchise Id" do
    team1 = Team.new(1,23,"Atlanta United","ATL","Mercedes-Benz Stadium","/api/v1/teams/1")
    team2 = Team.new(4,16,"Chicago Fire","CHI","SeatGeek Stadium","/api/v1/teams/4")
    team3 = Team.new(26,14,"FC Cincinnati","CIN","Nippert Stadium","/api/v1/teams/26")

    expect(team1.franchiseid).to eq(23)
    expect(team2.franchiseid).to eq(16)
    expect(team3.franchiseid).to eq(14)

  end

  it "has a team_name" do
    team1 = Team.new(1,23,"Atlanta United","ATL","Mercedes-Benz Stadium","/api/v1/teams/1")
    team2 = Team.new(4,16,"Chicago Fire","CHI","SeatGeek Stadium","/api/v1/teams/4")
    team3 = Team.new(26,14,"FC Cincinnati","CIN","Nippert Stadium","/api/v1/teams/26")

    expect(team1.team_name).to eq("Atlanta United")
    expect(team2.team_name).to eq("Chicago Fire")
    expect(team3.team_name).to eq("FC Cincinnati")
  end

  it "has abbreviation" do
    team1 = Team.new(1,23,"Atlanta United","ATL","Mercedes-Benz Stadium","/api/v1/teams/1")
    team2 = Team.new(4,16,"Chicago Fire","CHI","SeatGeek Stadium","/api/v1/teams/4")
    team3 = Team.new(26,14,"FC Cincinnati","CIN","Nippert Stadium","/api/v1/teams/26")

    expect(team1.abbreviation).to eq("ATL")
    expect(team2.abbreviation).to eq("CHI")
    expect(team3.abbreviation).to eq("CIN")
  end

  it "has stadium" do
    team1 = Team.new(1,23,"Atlanta United","ATL","Mercedes-Benz Stadium","/api/v1/teams/1")
    team2 = Team.new(4,16,"Chicago Fire","CHI","SeatGeek Stadium","/api/v1/teams/4")
    team3 = Team.new(26,14,"FC Cincinnati","CIN","Nippert Stadium","/api/v1/teams/26")

    expect(team1.stadium).to eq("Mercedes-Benz Stadium")
    expect(team2.stadium).to eq("SeatGeek Stadium")
    expect(team3.stadium).to eq("Nippert Stadium")

  end

  it "has a link" do
    team1 = Team.new(1,23,"Atlanta United","ATL","Mercedes-Benz Stadium","/api/v1/teams/1")
    team2 = Team.new(4,16,"Chicago Fire","CHI","SeatGeek Stadium","/api/v1/teams/4")
    team3 = Team.new(26,14,"FC Cincinnati","CIN","Nippert Stadium","/api/v1/teams/26")

    expect(team1.link).to eq("/api/v1/teams/1")
    expect(team2.link).to eq("/api/v1/teams/4")
    expect(team3.link).to eq("/api/v1/teams/26")
  end
end
