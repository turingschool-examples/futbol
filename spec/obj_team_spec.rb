require 'csv'
require 'spec_helper.rb'

RSpec.describe Team do
  let(:team) { Team.new(info) }
  let(:info) do { 
      "team_id" => "55",
      "franchiseId" => "94",
      "teamName" => "Turing Coders",
      "abbreviation" => "DIA",
      "Stadium" => "Online at Home",
      "link" => "/api/BE/teams/55"
    }
  end
  
  describe "#initialize" do
    it "exists" do
    expect(team).to be_instance_of(Team)
    end 

  end
end