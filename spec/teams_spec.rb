require "./lib/stat_tracker.rb"

describe Teams do
  before :each do
    @teams =   Teams.new(
    { team_id: "1",
         franchiseId: "23",
         teamName: "Atlanta United",
         abbreviation: "ATL",
         Stadium: "Mercedes-Benz Stadium",
         link: "/api/v1/teams/1" })
       end

  it 'exists' do
    expect(@teams).to be_instance_of(Teams)
  end

end
