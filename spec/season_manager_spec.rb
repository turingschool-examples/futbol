require 'spec_helper'

RSpec.describe SeasonManager do
  before(:each) do
    game_path = './data/games_sample.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/game_teams_sample.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

    @stat_tracker = StatTracker.from_csv(locations)
    @season_manager = @stat_tracker.season_manager
  end

  it 'exists' do
    expect(@season_manager).to be_a(SeasonManager)
  end

  it 'can extract game id' do
    result = {
              '20122013' => ['2012030221', '2012020251', '2012020640'],
              '20132014' => ['2013020396', '2013020117', '2013020654'],
              '20142015' => ['2014020739', '2014020816', '2014020888', '2014020423'],
              '20152016' => ['2015021171', '2015020424'],
              '20162017' => ['2016020026', '2016020921', '2016020921'],
              '20172018' => ['2017021175', '2017020766', '2017020997', '2017021018']
              }
    expect(@season_manager.game_id_by_season).to eq(result)
  end
end
