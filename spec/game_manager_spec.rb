require'csv'
require'rspec'
require'./lib/game_manager.rb'


RSpec.describe GameManager do
  before(:each) do
    GameManager.from_csv_path('./data/games.csv')
  end

  it '#highest_total_score' do
    expect(GameManager.highest_total_score).to eq 11
  end
 
  it '#lowest_total_score' do
    expect(GameManager.lowest_total_score).to eq 0
  end

  it "#percentage_home_wins" do
    expect(GameManager.percentage_home_wins).to eq 0.44
  end

  it "#percentage_visitor_wins" do
    expect(GameManager.percentage_visitor_wins).to eq 0.36
  end

  it "#percentage_ties" do
    expect(GameManager.percentage_ties).to eq 0.20
  end

  it "#count_of_games_by_season" do
    expected = {
      "20122013"=>806,
      "20162017"=>1317,
      "20142015"=>1319,
      "20152016"=>1321,
      "20132014"=>1323,
      "20172018"=>1355
    }
    expect(GameManager.count_of_games_by_season).to eq expected
  end
end



# Method	/Description	/Return Value
# highest_total_score	/Highest sum of the winning and losing teams’ scores/	Integer
# lowest_total_score	/Lowest sum of the winning and losing teams’ scores	/Integer
# percentage_home_wins/	Percentage of games that a home team has won (rounded to the nearest 100th)/	Float
# percentage_visitor_wins	/Percentage of games that a visitor has won (rounded to the nearest 100th)/	Float
# percentage_ties	Percentage /of games that has resulted in a tie (rounded to the nearest 100th)/	Float
# count_of_games_by_season/	A hash with season names (e.g. 20122013) as keys and counts of games as values/	Hash
# average_goals_per_game/	Average number of goals scored in a game across all seasons including both home and away goals /(rounded to the nearest 100th)	Float
# average_goals_by_season	/Average number of goals scored in a game organized in a hash with season names (e.g. 20122013) as keys and a float representing the average number of goals in a game for that season as values /(rounded to the nearest 100th)
