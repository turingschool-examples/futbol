require './lib/team'

RSpec.describe Team do
  it 'exists and can take a hash' do
    team = Team.new({
      teamname:     'name',
      team_id:      1,
      franchiseid:  2,
      abbreviation: 'LoL',
      stadium:      'Place',
      link:         './a/'
    })

    expect(team).to be_a(Team)
    expect(team.team_id).to eq(1)
    expect(team.team_name).to eq('name')
    expect(team.franchise_id).to eq(2)
    expect(team.abbreviation).to eq('LoL')
    expect(team.stadium).to eq('Place')
    expect(team.link).to eq('./a/')
  end
end
