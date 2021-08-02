require 'spec_helper'

RSpec.describe SeasonManager do
  before(:each) do
    game_path = './data/season_game_sample.csv'
    team_path = './data/teams.csv'
    game_teams_path = './data/season_game_teams_sample.csv'

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

  it 'gets games for given season' do
    expect(@season_manager.games_in_season('20122013')[0]).to be_a(Game)
    expect(@season_manager.games_in_season('20122013').count).to eq(10)
  end

  it 'can extract game id' do
    result = [
      '2012030221',
      '2012030222',
      '2012030223',
      '2012030224',
      '2012030225',
      '2012030311',
      '2012030312',
      '2012030313',
      '2012030314',
      '2012030231'
      ]
    expect(@season_manager.game_id_by_season('20122013')).to eq(result)
  end

  it 'can extract team ids' do
    result = ['3', '6', '5', '17', '16']
    expect(@season_manager.team_id_by_season('20122013')).to eq(result)
  end
end



# result = {
#           '20122013' => ['2012030221', '2012020251', '2012020640'],
#           '20132014' => ['2013020396', '2013020117', '2013020654'],
#           '20142015' => ['2014020739', '2014020816', '2014020888', '2014020423'],
#           '20152016' => ['2015021171', '2015020424'],
#           '20162017' => ['2016020026', '2016020921', '2016020921'],
#           '20172018' => ['2017021175', '2017020766', '2017020997', '2017021018']
#           }
