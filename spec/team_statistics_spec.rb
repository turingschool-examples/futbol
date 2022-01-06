require 'RSpec'
require 'ostruct'
require './lib/team_statistics'

RSpec.describe TeamStatistics do
  before(:each) do
    mock_team_1 = OpenStruct.new({team_id: 1, franchise_id: 23, team_name: "Atlanta United", abbreviation: "ATL", stadium: "Mercedes-Benz Stadium", link: "/api/v1/teams/1" })
    mock_team_2 = OpenStruct.new({team_id: 4, franchise_id: 16, team_name: "Chicago Fire", abbreviation: "CHI", stadium: "SeatGeek Stadium", link: "/api/v1/teams/4" })
    mock_team_3 = OpenStruct.new({team_id: 26, franchise_id: 14, team_name: "FC Cincinnati", abbreviation: "CIN", stadium: "Nippert Stadium", link: "/api/v1/teams/26" })
    mock_team_manager = OpenStruct.new({ data: [mock_team_1, mock_team_2, mock_team_3] })
    @team_statistics = TeamStatistics.new(mock_team_manager)
  end

  it "exists" do
    # require "pry"; binding.pry
    expect(@team_statistics).to be_a(TeamStatistics)
  end



end
