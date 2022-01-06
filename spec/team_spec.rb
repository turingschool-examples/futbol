require 'RSpec'
require 'ostruct'
require './lib/team'

RSpec.describe Team do
  before(:each) do
    @base_row = [nil, nil, nil, nil, nil, nil]
  end

  describe '#initialize' do
    it "exists" do
      team_1 = Team.new(@base_row)
      expect(team_1).to be_a(Team)
    end
  end
end
