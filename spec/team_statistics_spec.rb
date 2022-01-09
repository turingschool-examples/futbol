require './lib/stat_tracker.rb'
require './spec/spec_helper.rb'
require './lib/team_statistics.rb'
require 'pry'

RSpec.describe TeamStatistics do
  describe '#TeamStatistics' do
    stat_files = {
          game_stats: './data/dummy_game_teams.csv',
          games: './data/dummy_games.csv',
          teams: './data/dummy_teams.csv'
        }
    new_stat = TeamStatistics.new(stat_files)

    it '#exists' do

      expect(new_stat).to be_a(TeamStatistics)
    end

    it '#can read the team_info' do
      expect(new_stat.team_info).to eq({:abbreviation=>"CCS", :franchiseid=>"28", :link=>"/api/v1/teams/53", :team_id=>"53", :teamname=>"Columbus Crew SC"})
    end
  end
end
