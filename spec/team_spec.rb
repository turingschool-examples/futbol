require 'spec_helper'
require './lib/team'
#team_id,franchiseId,teamName,abbreviation,Stadium,link
RSpec.describe Team do

let(:team_data) {{team_id: "1",
                 franchiseId: "23",
                 teamName: "Atlanta United",
                 abbreviation: "ATL",
                 Stadium: "Mercedes-Benz Stadium"
}}
let(:team1) {Team.new(team_data)}

  describe '#initialize' do
    it 'exists' do
    expect(team1).to be_a(Team)
    expect(team1.team_id).to eq("1")
    end
  end
end