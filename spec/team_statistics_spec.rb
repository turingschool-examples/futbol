require './lib/stat_tracker.rb'
require './spec/spec_helper.rb'
require './lib/team_statistics.rb'
require 'pry'

RSpec.describe TeamStatistics do
  describe '#TeamStatistics' do
    stat_files = {
          game_teams: './data/game_teams.csv',
          games: './data/games.csv',
          teams: './data/teams.csv'
        }
    new_stat = TeamStatistics.new(stat_files)

    it '#exists' do

      expect(new_stat).to be_a(TeamStatistics)
    end

    it '#can read the team_info' do
      expect(new_stat.team_info("53")).to eq({:abbreviation=>"CCS", :franchiseid=>"28", :link=>"/api/v1/teams/53", :team_id=>"53", :teamname=>"Columbus Crew SC"})
    end

    xit '#can determine the best_season' do
       binding.pry
      expect(new_stat.best_season).to eq([])
    end
  end
end
