require 'simplecov'
SimpleCov.start
SimpleCov.command_name 'Game Class Tests'
require './lib/game'

RSpec.describe Game do
  let!(:stat_tracker) do
    game_path = './spec/fixtures/spec_games.csv'
    team_path = './spec/fixtures/spec_teams.csv'
    game_teams_path = './spec/fixtures/spec_game_teams.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }
    StatTracker.from_csv(locations)
  end
  let!(:game_team_data){stat_tracker.game_team_data}
  let!(:game_data){stat_tracker.game_data}
  let(:tg_stat0) { TGStat.new(game_team_data[0]) }
  let(:tg_stat1) { TGStat.new(game_team_data[1]) }
  let(:tg_stat8) { TGStat.new(game_team_data[8]) }
  let(:tg_stat9) { TGStat.new(game_team_data[9]) }
  let(:stats_hash) { Creator.stat_obj_creator(game_team_data) }
  let(:game1) { Game.new(game_data[0], tg_stat1, tg_stat0) }
  let(:game10) { Game.new(game_data[9], tg_stat9, tg_stat8) }

  describe '#initialize' do
    it 'exists' do
      expect(game1).to be_instance_of(Game)
    end
    it 'has attributes' do
      expected = {
                   game_id: '2012030221',
                   season: '20122013',
                   type: 'Postseason',
                   date_time: '5/16/13',
                   away_team_id: '3',
                   home_team_id: '6',
                   away_goals: 2,
                   home_goals: 3,
                   venue: 'Toyota Stadium',
                   venue_link: '/api/v1/venues/null'
                  }

      expect(game1).to have_attributes(expected)

      expected = {
                   game_id: '2012030231',
                   season: '20122013',
                   type: 'Postseason',
                   date_time: '5/16/13',
                   away_team_id: '17',
                   home_team_id: '16',
                   away_goals: 1,
                   home_goals: 2,
                   venue: 'Gillette Stadium',
                   venue_link: '/api/v1/venues/null'
                  }

      expect(game10).to have_attributes(expected)

      expect(game1.home_team_stat).to eq(tg_stat1)
      expect(game1.away_team_stat).to eq(tg_stat0)
      expect(game10.home_team_stat).to eq(tg_stat9)
      expect(game10.away_team_stat).to eq(tg_stat8)
    end
  end
end
