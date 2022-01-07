# require 'spec_helper'
require 'simplecov'
require 'RSpec'
require 'ostruct'
require './lib/statistics/team_statistics'
require './lib/statistics/season_statistics.rb'
# require './lib/statistics/game_teams_manager.rb'

RSpec.describe TeamStatistics do
  before(:each) do
    mock_team_1 = OpenStruct.new({team_id: 1, franchise_id: 23, team_name: "Atlanta United", abbreviation: "ATL",
       stadium: "Mercedes-Benz Stadium", link: "/api/v1/teams/1" })
    mock_team_2 = OpenStruct.new({team_id: 4, franchise_id: 16, team_name: "Chicago Fire", abbreviation: "CHI",
       stadium: "SeatGeek Stadium", link: "/api/v1/teams/4" })
    mock_team_3 = OpenStruct.new({team_id: 26, franchise_id: 14, team_name: "FC Cincinnati", abbreviation: "CIN",
       stadium: "Nippert Stadium", link: "/api/v1/teams/26" })
    mock_team_manager = OpenStruct.new({ data: [mock_team_1, mock_team_2, mock_team_3] })
    @team_statistics = TeamStatistics.new(mock_team_manager)
  end

  describe 'exists' do
    it "exists" do
      expect(@team_statistics).to be_a(TeamStatistics)
    end
  end

  describe '#team_info' do
    it 'can return a hash with key/value pairs for attributes' do
      actual = @team_statistics.team_info(1)
      # team_info method currently returns with rocket syntax. problem?
      expected = {:team_id => 1, :franchise_id => 23, :team_name => "Atlanta United", :abbreviation => "ATL", :link => "/api/v1/teams/1" }
      # expected = {team_id: 1, franchise_id: 23, team_name: "Atlanta United", abbreviation: "ATL", link: "/api/v1/teams/1" }
      expect(actual).to eq(expected)
    end
  end
end
# placeholder name TeamGame doesn't exist yet
# This is for the #win_percentage. Needs game_team_manager
RSpec.describe TeamGame do
  before(:each) do
    mock_game_team_1 = OpenStruct.new({game_id: 2012030221, team_id: 3, HOA: "away", result: "LOSS",
       settled_in: "OT", head_coach: "John Tortorella" })
    mock_game_team_2 = OpenStruct.new({game_id: 2012030222, team_id: 3, HOA: "home", result: "WIN",
       settled_in: "REG", head_coach: "John Tortorella" })
    mock_game_team_3 = OpenStruct.new({game_id: 2012030221, team_id: 4, HOA: "away", result: "LOSS",
       settled_in: "OT", head_coach: "John Tortorella" })
    mock_game_team_manager = OpenStruct.new({ data: [mock_team_1, mock_team_2, mock_team_3] })
    @game_team_statistics = SeasonStatistics.new(mock_game_team_manager)
  end

  describe 'exists' do
    it "exists" do
      expect(@game_team_statistics).to be_a(TeamGame)
    end
  end

  describe '#win_percentage' do
    it 'can return the win percentage of all games for a given team' do
      actual = @game_team_statistics.win_percentage(3)
      expected = 50
      expect(actual).to eq(expected)
    end
  end
end
