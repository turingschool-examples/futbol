require './spec_helper/spec_helper.rb'

RSpec.describe StatTracker do
  describe '#initialize' do
    let(:locations) do
      {
        games: './data/games.csv',
        teams: './data/teams.csv',
        game_teams: './data/game_teams.csv'
      }
    end

    before do
      @stat_tracker = StatTracker.from_csv(locations)
    end

    it 'should initialize an instant of StatTracker' do
      expect(@stat_tracker).to be_instance_of StatTracker
    end

    it 'has games attributes' do
      expected_result = [
        :@id,
        :@season,
        :@type,
        :@date_time,
        :@away_team_id,
        :@home_team_id,
        :@away_goals,
        :@home_goals,
        :@venue,
        :@venue_link
      ]
      # require 'pry'; binding.pry
      expect(@stat_tracker.games).to be_an Array
      expect(@stat_tracker.games.first.instance_variables).to eq(expected_result)
    end
  end
end
