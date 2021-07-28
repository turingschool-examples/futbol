require './lib/team'


RSpec.describe Team do

  it 'exists and can take a hash' do
    team = Team.new({
      team_name: 'name',
      team_id: 1
      })

    expect(team).to be_a(Team)
    expect(team.id).to eq(1)
    expect(team.name).to eq('name')
  end

end
