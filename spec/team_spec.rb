require './lib/team'


RSpec.describe Team do

  it 'exists and can take a hash' do
    team = Team.new({
      teamname: 'name',
      team_id: 1
      })

    expect(team).to be_a(Team)
    expect(team.team_id).to eq(1)
    expect(team.team_name).to eq('name')
  end

end
