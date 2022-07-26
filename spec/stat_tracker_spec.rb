require './lib/stat_tracker'

RSpec.describe StatTracker do
  context 'Iteration 1' do
    before :each do
      game_path = './data/games_dummy.csv'
      team_path = './data/teams_dummy.csv'
      game_teams_path = './data/game_teams_dummy.csv'

      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }

      @stat_tracker = StatTracker.from_csv(locations)
    end

    it 'exists' do

      expect(@stat_tracker).to be_an_instance_of(StatTracker)
    end

    it 'has data' do

      expect(@stat_tracker.games).to be_an_instance_of(CSV::Table)
      expect(@stat_tracker.teams).to be_an_instance_of(CSV::Table)
      expect(@stat_tracker.game_teams).to be_an_instance_of(CSV::Table)
    end

    it 'has a total score' do

      expect(@stat_tracker.total_scores_per_game).to eq(34)
    end

    it 'has a lowest total score' do

      expect(@stat_tracker.lowest_total_score).to eq(1)
    end

    it 'show highest_total_score' do

     expect(@stat_tracker.highest_total_score).to eq(5)
    end

    it 'can return the number average_goals_per_game' do
      expect(@stat_tracker.average_goals_per_game).to eq(3.78)
    end

    it 'shows the percentage_home_wins' do
      expect(@stat_tracker.percentage_home_wins).to eq(0.56)
    end

    it 'can return the count of games per season' do

     expect(@stat_tracker.count_of_games_by_season).to eq({20122013=>5, 20142015=>4})
    end
  end
end
