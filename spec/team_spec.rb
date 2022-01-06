require_relative 'spec_helper'
require 'RSpec'
require './lib/team'

RSpec.describe Team do
  before(:each) do
    @base_row = [:team_id, :franchise_id, :team_name, :abbreviation, :stadium, :link]
  end

  describe '#initialize' do
    it "exists" do
      team_1 = Team.new(@base_row)
      expect(team_1).to be_a(Team)
    end
  end
end
