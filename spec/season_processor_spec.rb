require './lib/season_processor'
require './lib/game_team'
RSpec.describe SeasonProcessor do
  let(:dummy_class) { Class.new { extend SeasonProcessor } }
  let(:row1) { {game_id:"2012030221",
              team_id:"3",
              goals: "1",
              head_coach: "John Tortorella",
              result: "LOSS",
              shots: "8",
              tackles: "44"
              } }
  let(:row2) { {game_id:"2012030221",
              team_id:"6",
              goals: "3",
              head_coach: "Claude Julien",
              result: "WIN",
              shots: "12",
              tackles: "51"
              } }
  let(:game_teams) {[GameTeam.new(row1), GameTeam.new(row2)]}

  it 'returns coach_stats' do
    expect(dummy_class.coach_stats("2012", game_teams)).to eq({"John Tortorella"=>[1.0, 0.0], "Claude Julien"=>[1.0, 1.0]})
  end

  it 'returns coach_stats' do
    expect(dummy_class.coach_stats("2012", game_teams)).to eq({"John Tortorella"=>[1.0, 0.0], "Claude Julien"=>[1.0, 1.0]})
  end

  it 'returns best_coach' do
    coach_stats = dummy_class.coach_stats("2012", game_teams)
    expect(dummy_class.best_coach(coach_stats)).to eq("Claude Julien")
  end

  it 'returns worstest_coach' do
    coach_stats = dummy_class.coach_stats("2012", game_teams)
    expect(dummy_class.worstest_coach(coach_stats)).to eq("John Tortorella")
  end

  it 'returns goal_stats' do
    expect(dummy_class.goal_stats("2012", game_teams)).to eq({"3"=>[8.0, 1.0], "6"=>[12.0, 3.0]})
  end

  it 'returns mostest_accurate_team' do
    goal_stats = dummy_class.goal_stats("2012", game_teams)
    expect(dummy_class.mostest_accurate_team(goal_stats)).to eq("6")
  end

  it 'returns leastest_accurate_team' do
    goal_stats = dummy_class.goal_stats("2012", game_teams)
    expect(dummy_class.leastest_accurate_team(goal_stats)).to eq("3")
  end

  it 'returns tackle_stats' do
    expect(dummy_class.tackle_stats("2012", game_teams)).to eq({"3"=>44, "6"=>51})
  end
end
