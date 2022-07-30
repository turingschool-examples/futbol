require './spec_helper'
require_relative '../lib/stat_tracker'
require_relative '../lib/season_statistics'

RSpec.describe SeasonStatistics do 
    before(:all) do 
        game_path = './data/games.csv'
        team_path = './data/teams.csv'
        game_teams_path = './data/game_teams.csv'

    locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
    }

        stat_tracker = StatTracker.from_csv(locations)
        @season_statistics = SeasonStatistics.new(stat_tracker.data)
    end

    describe '.SeasonStatistics Instantiation' do
        it 'is instance of class' do
          expect(@season_statistics).to be_an_instance_of(described_class)
        end
      end
    describe '.season_game_id_verification' do 
        it 'verifies the season exists in the game id' do 
            expect(@season_statistics.season_game_id_verification).to eq true
        end
    end
    describe '.winningest_coach' do 
      it 'returns the winningest coach' do
        expect(@season_statistics.winningest_coach("20132014")).to eq "Claude Julien"
        expect(@season_statistics.winningest_coach("20142015")).to eq "Alain Vigneault"
      end
    end 




end


