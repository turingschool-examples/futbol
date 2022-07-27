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


    it 'show percentage of tie games' do
      expect(@stat_tracker.percentage_ties).to eq(0.0)
    end

    it 'shows the percentage_home_wins' do
      expect(@stat_tracker.percentage_home_wins).to eq(0.56)
    end

    it 'can calculate percentage visitor wins' do
      expect(@stat_tracker.percentage_visitor_wins).to eq(0.44)
    end

    it 'can return the count of games per season' do

     expect(@stat_tracker.count_of_games_by_season).to eq({20122013=>5, 20142015=>4})
    end

    it 'can count the total teams' do
      expect(@stat_tracker.count_of_teams).to eq(3)
    end

    it 'can return a hash of team and goal data' do
      expect(@stat_tracker.teams_and_goals).to be_an(Hash)
      expect(@stat_tracker.teams_and_goals[3][:total_goals]).to eq(8)
    end


    it 'can return the team with the worst offense' do
      expect(@stat_tracker.worst_offense).to eq("Sporting Kansas City")
    end

    it 'can return the team with the best offense' do
      expect(@stat_tracker.best_offense).to eq("FC Dallas")
    end
      
    it 'can show the highest scoring home team' do
      expect(@stat_tracker.highest_scoring_home_team).to eq('FC Dallas')
    end

    it 'can show the lowest scoring home team' do
      expect(@stat_tracker.lowest_scoring_home_team).to eq('Sporting Kansas City')
    end

    it 'can show the highest scoring visiting team' do
      expect(@stat_tracker.highest_scoring_visitor).to eq('FC Dallas')
    end
  end
end
