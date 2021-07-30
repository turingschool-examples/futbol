require './lib/team'

RSpec.describe Team do

  describe 'initialization' do
    it 'exists and has attributes' do
      team = Team.new({
                      "team_id"
                      })
    end
  end

end

# path = './data/teams.csv'
# => "./data/teams.csv"
# [6] pry(main)> data = CSV.read(path, headers: true)
