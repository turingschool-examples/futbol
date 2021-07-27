require './lib/stat_tracker'


RSpec.describe StatTracker do
  context '#initialize' do
    it 'exists' do
      game_path = './data/test_games.csv'
      team_path = './data/test_teams.csv'
      game_teams_path = './data/test_game_teams.csv'

      locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

      stat_tracker = StatTracker.new(locations)

      expect(stat_tracker).to be_a StatTracker
    end

    it 'accepts data' do
      game_path = './data/test_games.csv'
      team_path = './data/test_teams.csv'
      game_teams_path = './data/test_game_teams.csv'

      locations = {
        games: game_path,
        teams: team_path,
        game_teams: game_teams_path
      }

      stat_tracker = StatTracker.from_csv(locations)
      expect(stat_tracker.games[0].game_id).to eq(2012030221)
      expect(stat_tracker.teams[0].team_id).to eq(1)
      expect(stat_tracker.game_teams[0].game_id).to eq(2012030221)
      expect(stat_tracker).to be_a(StatTracker)
    end
  end

  context "Game stat methods" do
    it '#highest_total_score' do
      game_path = './data/test_games.csv'
      team_path = './data/test_teams.csv'
      game_teams_path = './data/test_game_teams.csv'

      locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

      stat_tracker = StatTracker.from_csv(locations)

      expect(stat_tracker.highest_total_score).to eq(5)
    end

    it '#lowest_total_score' do
      game_path = './data/test_games.csv'
      team_path = './data/test_teams.csv'
      game_teams_path = './data/test_game_teams.csv'

      locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

      stat_tracker = StatTracker.from_csv(locations)

      expect(stat_tracker.lowest_total_score).to eq(1)
    end
  end

  context 'league stats methods' do
    it '#count_of_teams' do
      game_path = './data/test_games.csv'
      team_path = './data/test_teams.csv'
      game_teams_path = './data/test_game_teams.csv'

      locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

      stat_tracker = StatTracker.from_csv(locations)

      expect(stat_tracker.count_of_teams).to eq(10)
    end

    it '#games_by_team_id' do
      game_path = './data/test_games.csv'
      team_path = './data/test_teams.csv'
      game_teams_path = './data/test_game_teams.csv'

      locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

      stat_tracker = StatTracker.from_csv(locations)
      # expected = {

      # }
      expect(stat_tracker.games_by_team_id).to be_a Hash
    end

    it '#goals_per_team' do
      game_path = './data/test_games.csv'
      team_path = './data/test_teams.csv'
      game_teams_path = './data/test_game_teams.csv'

      locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

      stat_tracker = StatTracker.from_csv(locations)

      expect(stat_tracker.goals_per_team).to eq({
        3 => [2, 2, 1, 2, 1], 
        6 => [3, 3, 2, 3, 3]
      })
    end

    it '#team_name_by_team_id' do
      game_path = './data/test_games.csv'
      team_path = './data/test_teams.csv'
      game_teams_path = './data/test_game_teams.csv'

      locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

      stat_tracker = StatTracker.from_csv(locations)

      expect(stat_tracker.team_name_by_team_id(1)).to eq("Atlanta United")
    end

    it '#best_offense' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'

      locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

      stat_tracker = StatTracker.from_csv(locations)

      expect(stat_tracker.best_offense).to eq("Reign FC")
    end

    it '#worst_offense' do
      game_path = './data/games.csv'
      team_path = './data/teams.csv'
      game_teams_path = './data/game_teams.csv'

      locations = {
      games: game_path,
      teams: team_path,
      game_teams: game_teams_path
      }

      stat_tracker = StatTracker.from_csv(locations)

      expect(stat_tracker.worst_offense).to eq("Utah Royals FC")
    end
  end
end
