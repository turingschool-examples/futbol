require "./lib/game_team"

RSpec.describe GameTeam do

  it 'exists and has readable attributes' do
    info = {
        game_id: "2012030221",
        team_id: "3",
        result: "LOSS",
        head_coach: "John Tortorella",
        goals: "2",
        shots: "8",
        tackles: "44"
            }
    game_team = GameTeam.new(info)
    expect(game_team).to be_a(GameTeam)
    expect(game_team.game_id).to eq("2012030221")
    expect(game_team.team_id).to eq("3")
    expect(game_team.result).to eq("LOSS")
    expect(game_team.head_coach).to eq("John Tortorella")
    expect(game_team.goals).to eq("2")
    expect(game_team.shots).to eq("8")
    expect(game_team.tackles).to eq("44")
  end
end
