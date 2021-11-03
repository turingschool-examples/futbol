require './lib/game_team'

RSpec.require do

  xit 'counts all the teams in the league' do
    expect(@stat_tracker.count_of_teams).to eq(32)
  end

  xit 'counts games by season' do
    expect(@stat_tracker.count_of_games_by_season).to eq({"20122013"=> 9, "20162017" => 1, "20152016" => 2, "20172018" => 1})
  end

end
