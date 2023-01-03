require_relative 'spec_helper'

RSpec.describe StatTracker do
    let(:game_path) {'./data/games.csv'}
    let(:team_path) {'./data/teams.csv'}
    let(:game_teams_path) {'./data/game_teams.csv'}
    let(:locations) do
        {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
        }
    end
    it 'exists' do
        expect(StatTracker.from_csv(locations)).to be_an_instance_of(StatTracker)
    end

end