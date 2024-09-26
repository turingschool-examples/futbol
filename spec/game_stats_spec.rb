require 'rspec'
require './lib/game_stats'

describe GameStats do

  let(:gamestats) {GameStats.new('./data/games_sample.csv')}
  
  it 'exists' do
    expect(gamestats).to be_an_instance_of(GameStats)
  end

  it 'attributes' do
    expect(gamestats.games).to be_an(Array)
  end

  it "can show you the highest total score of all games" do
    expect(gamestats.highest_total_score).to eq(6)
  end

  it "can show you the lowest total score of all games" do
    expect(gamestats.lowest_total_score).to eq(1)

  end

  it "can show percentage of home wins" do
    expect(gamestats.percentage_home_wins).to eq(0.51)
  end

  it "can show percentage_visitor_wins" do
    expect(gamestats.percentage_visitor_wins).to eq(0.44)
  end

  it "can show you the percentage of tie games" do
    expect(gamestats.percentage_ties).to eq(0.05)
  end

  it "can return a hash of the number of games per season" do
    expect(gamestats.count_of_games_by_season).to eq({"20122013"=>20, "20132014"=>21, "20142015"=>17, "20152016"=>11, "20162017"=>4})
  end

  it "can return the average goals per game" do
    expect(gamestats.average_goals_per_game).to eq(4.0)
  end

  it "can show average goals per season" do
    expect(gamestats.average_goals_per_season("20122013")).to eq(3.75)
    expect(gamestats.average_goals_per_season("20162017")).to eq(4.75)
  end

  it "can return a hash of average goals by season" do
    expect(gamestats.average_goals_by_season).to eq({"20122013"=>3.75, "20132014"=>4.43, "20142015"=>3.35, "20152016"=>4.36, "20162017"=>4.75})
  end
end
