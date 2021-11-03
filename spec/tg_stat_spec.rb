require 'simplecov'
SimpleCov.start
SimpleCov.command_name 'Team Game(TG) Stat Class Tests'
require './lib/tg_stat'
require './lib/stat_tracker'
require './lib/creator'

RSpec.describe TGStat do
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
  let(:tg_stat1) { TGStat.new(game_team_data[0]) }
  let(:tg_stat9) { TGStat.new(game_team_data[9]) }
  
  describe '#initialize' do
    it 'exists' do
      expect(tg_stat1).to be_instance_of(TGStat)
    end

    it 'has attributes' do
      expected = {
                  game_id:    '2012030221',
                  team_id:    '3',
                  hoa:        'away',
                  result:     'LOSS',
                  settled_in: 'OT',
                  head_coach: 'John Tortorella',
                  goals:      2,
                  shots:      8,
                  tackles:    44,
                  pim:        8,
                  ppo:        3,
                  ppg:        0,
                  fowp:       44.8,
                  giveaways:  17,
                  takeaways:  7
                  }

      expect(tg_stat1).to have_attributes(expected)

      expected = {
                  game_id:    '2012030225',
                  team_id:    '6',
                  hoa:        'home',
                  result:     'WIN',
                  settled_in: 'REG',
                  head_coach: 'Claude Julien',
                  goals:      3,
                  shots:      8,
                  tackles:    35,
                  pim:        11,
                  ppo:        3,
                  ppg:        1,
                  fowp:       49.1,
                  giveaways:  12,
                  takeaways:  9
                  }

      expect(tg_stat9).to have_attributes(expected)
    end
  end
end