require 'spec_helper'
describe LeagueStats do
  before(:each) do
    @dataset = GameTeamData.new
    @dataset.add_game_team
  end

  it 'can import team data' do
    expect(@dataset.game_teams[0].game_id).to eq("2012030221")
  end

  it 'can return team with best offense' do
    expect(@dataset.best_offense).to eq("Reign FC")
  end

  it 'can return team with worst offense' do
    expect(@dataset.worst_offense).to eq("Utah Royals FC")
  end

  it 'can find the highest scoring home team' do
    expect(@dataset.highest_scoring_home_team).to eq('Sporting Kansas City')
  end

  it 'can find highest scoring away team' do
    expect(@dataset.highest_scoring_away_team).to eq('Sporting Kansas City')
  end

  it 'can find winningest coach' do
    expect(@dataset.winningest_coach).to eq('Bruce Boudreau')
  end
  
  it 'can find worst coach' do
    expect(@dataset.worst_coach).to eq('Dave Tippett')
  end
end