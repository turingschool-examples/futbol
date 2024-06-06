require 'spec_helper.rb'

RSpec.configure do |config|
  config.formatter = :documentation
end

describe LeagueStatistics do
  
  describe "class methods" do
    it "can count the total number of teams" do
      path = "./data/teams.csv"
      teams = Teams.create_teams_data_objects(path)

      expect(teams.count).to be 32
      expect(teams).to be_all Teams
    end


  end
end