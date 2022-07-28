require './lib/stat_tracker'

RSpec.describe Game do
  before :each do
    game_path = './data/games_dummy.csv'
    team_path = './data/teams_dummy.csv'
    game_teams_path = './data/game_teams_dummy.csv'

    locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
    }

    stat_tracker = StatTracker.from_csv(locations)

    @game = stat_tracker.games[0]
  end

  it 'exists' do

   expect(@game).to be_an(Game)
   expect(@game.game_id).to eq(2012030221)
 end

 it 'has a total score' do
   expect(@game.total_scores_per_game).to eq(5)
 end

 it 'has a lowest total score' do
   expect(@game.lowest_total_score).to eq(3)
 end

 it 'show highest_total_score' do
  expect(@game.highest_total_score).to eq(3)
 end
end
