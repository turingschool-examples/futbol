require 'csv'
require 'spec_helper.rb'

RSpec.describe Team do
  let(:team) { Team.new(info) }
  let(:info) do { 
      "game_id" => 99009900,
      "season" => "00110011",
      "type" => "A Good Place",
      "date_time" => "04/20/23",
      "away_team_id" => "99",
      "home_team_id" => "01",
      "away_goals" => 23,
      "home_goals" => 18,
      "venue" => "The Moon",
      "venue_link" => "/api/BE/spaceship/null"
    }
  end
  
  describe "#initialize" do
    it "exists" do
    expect(game.game_id).to be_a(Integer)
    end 


  end
end