require "./lib/team.rb"

RSpec.describe Team do
  before (:each) do
    @team1 = Team.new({name: "Astros", wins: 61, losses: 47, head_coach: "Billy Joe Bob"})
  end

  it "can initialize" do 
    expect(@team1).to be_an_instance_of(Team)
  end

  it "has readable attributes" do
    expect(@team1.name).to eq "Astros"
    expect(@team1.wins).to eq 61
    expect(@team1.losses).to eq 47
    expect(@team1.head_coach).to eq "Billy Joe Bob"
  end
end