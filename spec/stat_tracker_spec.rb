require 'spec_helper'

RSpec.describe StatTracker do
   before(:each) do
      game_path = './data/games_fixture.csv'
      team_path = './data/teams_fixture.csv'
      game_teams_path = './data/game_teams_fixture.csv'

      locations = {
         games: game_path,
         teams: team_path,
         game_teams: game_teams_path
      }

      @stat_tracker = StatTracker.from_csv(locations)
   end

   it 'exists' do
      expect(@stat_tracker).to be_a StatTracker
   end

   describe '#read_games_csv' do
      it 'create game objects' do
         location = './data/games_fixture.csv'

         expect(@stat_tracker.read_games_csv(location)[0]).to be_a Game
      end

      it 'can identify attributes of game csv' do
         location = './data/games_fixture.csv'

         expect(@stat_tracker.read_games_csv(location)[0].game_id).to eq("2012030221")
         expect(@stat_tracker.read_games_csv(location)[0].season).to eq("20122013")
         expect(@stat_tracker.read_games_csv(location)[0].away_team_id).to eq(3)
         expect(@stat_tracker.read_games_csv(location)[0].home_team_id).to eq(6)
         expect(@stat_tracker.read_games_csv(location)[0].away_goals).to eq(2)
         expect(@stat_tracker.read_games_csv(location)[0].home_goals).to eq(3)
      end
   end

   describe '#read_teams_csv' do
      it 'create teams objects' do
         location = './data/teams_fixture.csv'

         expect(@stat_tracker.read_teams_csv(location)[0]).to be_a Team
         expect(@stat_tracker.read_teams_csv(location)[0].team_id).to eq(1)
         expect(@stat_tracker.read_teams_csv(location)[0].team_name).to eq("Atlanta United")
      end
   end

   describe '#read_game_teams_csv' do
      it 'create game_team objects' do
         location = './data/game_teams_fixture.csv'
         game_team_0 = @stat_tracker.read_game_teams_csv(location)[0]

         expect(@stat_tracker.read_game_teams_csv(location)[0]).to be_a GameTeam
         expect(game_team_0.game_id).to eq("2012030221")
         expect(game_team_0.team_id).to eq(3)
         expect(game_team_0.hoa).to eq("away")
         expect(game_team_0.result).to eq("LOSS")
         expect(game_team_0.head_coach).to eq("John Tortorella")
         expect(game_team_0.goals).to eq(2)
         expect(game_team_0.shots).to eq(8)
         expect(game_team_0.tackles).to eq(44)
      end
   end

   describe '#highest_total_score' do
      it 'returns highest sum of winning and losing team score' do
         expect(@stat_tracker.highest_total_score).to eq(5)
      end
   end

   describe '#lowest_total_score' do
      it 'returns lowest sum of winning and losing team score' do
         expect(@stat_tracker.lowest_total_score).to eq(1)
      end
   end

   describe '#percentage_home_wins' do
      it 'returns percentage of games that a home team has won' do
         expect(@stat_tracker.percentage_home_wins).to eq(70.0)
      end
   end

   describe '#calculate_percentage' do
      it 'calculates percentages' do
         expect(@stat_tracker.calculate_percentage(20 , 30)).to eq (66.67)
      end
   end

   describe '#percentage_visitor_wins' do
      it 'returns percentage of games that a visitor has won' do
         expect(@stat_tracker.percentage_visitor_wins).to eq(25.0)
      end
   end

   describe '#percentage_ties' do
      it 'returns percentage of games that has resulted in a tie' do
         expect(@stat_tracker.percentage_ties).to eq(5.0)
      end
   end

   describe '#count_of_games_by_season' do
      it 'returns hash with season names as keys and counts of games as values' do
            expect(@stat_tracker.count_of_games_by_season).to eq({
               "20122013" => 20
            })
      end
   end

   describe '#average_goals_per_game' do
      it 'average of goals scored in a game across all seasons including both home and away goals' do
         expect(@stat_tracker.average_goals_per_game).to eq (3.75)
      end
   end
end