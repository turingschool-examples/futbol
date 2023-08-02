require 'spec_helper'

RSpec.describe LeagueStats do
  before(:each) do
    @ls = LeagueStats.new
  end

  describe "#initialize" do
    it "exists" do
      expect(@ls).to be_a LeagueStats
    end
  end
end