require 'simplecov'
SimpleCov.start
require './lib/stat_tracker'

describe StatTracker do
  before(:each) do

    game_path = './data/games_test.csv'
    team_path = './data/teams_test.csv'
    game_teams_path = './data/game_teams_test.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    @stat_tracker = StatTracker.from_csv(locations)
  end

  it 'finds highest scoring game' do
    expect(@stat_tracker.highest_total_score).to eq(12)
  end

  it 'finds lowest scoring game' do
    expect(@stat_tracker.lowest_total_score).to eq(1)
  end








































































#SAI
  context 'Games: Percentages' do
    it 'returns a percentage of how many wins were home wins' do
        expect(@stat_tracker.percentage_home_wins).to eq(44.44)
    end
    it 'returns a percentage of how many wins were away wins' do
        expect(@stat_tracker.percentage_visitor_wins).to eq(55.56)
    end
    it 'returns a percentage of how many ties there were' do
        expect(@stat_tracker.percentage_ties).to eq(0.00)
    end
  end
  context "Season: Accuracy Ratios" do
    it 'can separate game ids by season' do
      expect(@stat_tracker.games_by_season('20122013')).to eq(['2012030221', '2012030225', '2012030314'])
    end
    it 'returns the name of the team with the best shot to goal ratio' do
      expect(@stat_tracker.most_accurate_team("20122013")).to eq("Houston Dynamo")
    end
    it 'returns the name of the team with the worst shot to goal ratio' do
      expect(@stat_tracker.least_accurate_team("20122013")).to eq("Sporting Kansas City")
    end
  end


























































































#COLIN
it 'find the average goals per game' do
  # require 'pry'; bind!ing.pry
  expect(@stat_tracker.average_goals_per_game).to eq(4.78)
end

it 'finds the average goals by season' do
  expect(@stat_tracker.average_goals_by_season).to eq({"20122013"=>3.33, "20132014"=>4.0, "20152016"=>4.0, "20142015"=>8.5})
end

it 'counts games per season' do
  expect(@stat_tracker.count_of_games_by_season).to eq ({"20122013"=>3, "20132014"=>2, "20152016"=>2, "20142015"=>2})
end



























































































#THIAGO
  it 'can return name of coach with best win percentage based on season' do #.(season) not implemented yet
    expect(@stat_tracker.winningest_coach).to eq("Claude Julien")
  end
  it 'can return name of coach with worst win percentage based on season' do #.(season) not implemented yet
    expect(@stat_tracker.worst_coach).to eq("John Tortorella")
  end


















# Ensuring this line stays on 325










































































#STEPHEN

  it 'counts the total number of teams in the data' do
    expect(@stat_tracker.count_of_teams).to eq(9)
  end

  it 'can name the team with the best offense' do
    expect(@stat_tracker.best_offense).to eq("FC Dallas")
  end

  it 'can name the team with the worst offense' do
    expect(@stat_tracker.worst_offense).to eq("Houston Dynamo")
  end





























































































end
