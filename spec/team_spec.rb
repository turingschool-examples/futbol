require './lib/team'

RSpec.describe Team do

  describe 'initialization' do
    it 'exists and has attributes' do
      team = Team.new({
        "team_id"      => "1",
        "franchiseId"  => "23",
        "teamName"     => "Atlanta United",
        "abbreviation" => "ATL",
        "link"         => "/api/v1/teams/1",
        "Stadium"      =>  "Mercedes-Benz Stadium"
      })
      expect(team).to be_a(Team)
      expect(team.team_id).to eq("1")
    end
  end

end

# path = './data/teams.csv'
# => "./data/teams.csv"
# [6] pry(main)> data = CSV.read(path, headers: true)
