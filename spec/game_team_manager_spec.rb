require './lib/game_team_manager'
require './lib/stat_tracker'
require './lib/team_manager'

RSpec.describe GameTeamManager do
  describe '#load' do
    it 'length' do
      file_path = './data/fixture_game_teams.csv'
      game_team_manager = GameTeamManager.new(file_path)

      expect(game_team_manager.load.length).to eq(78)
      expect(game_team_manager.game_teams.length).to eq(39)
    end

    it 'creates game object for every row' do
      file_path = './data/fixture_game_teams.csv'
      game_team_manager = GameTeamManager.new(file_path)
      game_team_manager.load

      game_team_manager.game_teams.each do |game_id, team_hash|
        expect(team_hash[:home]).to be_instance_of(GameTeam)
        expect(team_hash[:away]).to be_instance_of(GameTeam)
      end
    end
  end

  describe 'helper methods for best_offense and worse_offense' do
    file_path = './data/fixture_game_teams.csv'
    game_team_manager = GameTeamManager.new(file_path)
    game_team_manager.load

    it 'counts total games for all seasons' do
      expect(game_team_manager.total_games_all_seasons("3")).to eq(5)
    end
    it 'counts total goals for all seasons' do
      expect(game_team_manager.total_goals_all_seasons("3")).to eq(8)
    end
    it 'calculates average goals for all seasons' do
      expect(game_team_manager.average_goals_all_seasons("3")).to eq(1.60)
    end
  end

  describe 'best and worst offense methods' do
    file_path = './data/fixture_game_teams.csv'
    game_team_manager = GameTeamManager.new(file_path)
    game_team_manager.load
    teams_by_id = {
      "3" => "Houston Dynamo",
      "6" => "FC Dallas",
      "5" => "Sporting Kansas City",
      "17" => "LA Galaxy"
    }

    it 'returns best_offense team string' do
      expect(game_team_manager.best_offense(teams_by_id)).to eq("FC Dallas")
    end

    it 'returns worst_offense team string' do
      expect(game_team_manager.worst_offense(teams_by_id)).to eq("Sporting Kansas City")
    end
  end


  ##### DOUBLE CHECK THESE EXPECTATIONS WITH FIXTURE FILES
  describe 'highest/lowest scoring home and away' do
    game_teams_path = './data/fixture_game_teams.csv'
    game_team_manager = GameTeamManager.new(game_teams_path)
    game_team_manager.load
    teams_path = './data/teams.csv'
    team_manager = TeamManager.new(teams_path)
    teams_by_id = team_manager.teams_by_id

    it 'returns highest scoring visitor name' do
      expect(game_team_manager.highest_scoring_visitor(teams_by_id)).to eq("FC Dallas")
    end

    it 'returns highest scoring home name' do
      expect(game_team_manager.highest_scoring_home_team(teams_by_id)).to eq("New York City FC")
    end

    it 'returns lowest scoring visitor name' do
      expect(game_team_manager.lowest_scoring_visitor(teams_by_id)).to eq("Sporting Kansas City")
    end

    it 'returns lowest scoring home name' do
      expect(game_team_manager.lowest_scoring_home_team(teams_by_id)).to eq("Sporting Kansas City")
    end
  end

  describe '#home and away teams' do
    it 'returns home teams' do
      file_path = './data/fixture_game_teams.csv'
      game_team_manager = GameTeamManager.new(file_path)
      game_team_manager.load

      game_team_manager.home_teams.each do |team|
        expect(team.hoa).to eq("home")
      end
    end

    it 'returns away teams' do
      file_path = './data/fixture_game_teams.csv'
      game_team_manager = GameTeamManager.new(file_path)
      game_team_manager.load

      game_team_manager.away_teams.each do |team|
        expect(team.hoa).to eq("away")
      end
    end
  end

  describe '#home and away games' do
    it 'returns home games' do
      file_path = './data/fixture_game_teams.csv'
      game_team_manager = GameTeamManager.new(file_path)
      game_team_manager.load

      game_team_manager.home_games("3").each do |game|
        expect(game.team_id).to eq("3")
        expect(game.hoa).to eq("home")
      end
    end

    it 'returns away games' do
      file_path = './data/fixture_game_teams.csv'
      game_team_manager = GameTeamManager.new(file_path)
      game_team_manager.load

      game_team_manager.away_games("3").each do |game|
        expect(game.team_id).to eq("3")
        expect(game.hoa).to eq("away")
      end
    end
  end

  describe '#average_win_percentage(team_id)' do
    it 'calculates average for all games for a team' do
      file_path = './data/fixture_game_teams.csv'
      game_team_manager = GameTeamManager.new(file_path)
      game_team_manager.load

      expect(game_team_manager.average_win_percentage("26")).to eq(0.50)
      expect(game_team_manager.average_win_percentage("3")).to eq(0.00)
      expect(game_team_manager.average_win_percentage("6")).to eq(1.00)
    end
  end

  describe '#all_games_by_team(team_id)' do
    it 'returns array of all games by team' do
      file_path = './data/fixture_game_teams.csv'
      game_team_manager = GameTeamManager.new(file_path)
      game_team_manager.load
      games = game_team_manager.all_games_by_team("3")
      games.each do |game_team|
        expect(game_team.team_id).to eq("3")
        expect(game_team).to be_instance_of(GameTeam)
      end
    end
  end

  describe '#most_goals_scored(team_id)' do
    it 'returns most goals in a single game' do
      file_path = './data/fixture_game_teams.csv'
      game_team_manager = GameTeamManager.new(file_path)
      game_team_manager.load

      expect(game_team_manager.most_goals_scored("3")).to eq(2)
      expect(game_team_manager.most_goals_scored("6")).to eq(4)
    end
  end

  describe '#fewest_goals_scored(team_id)' do
    it 'returns least goals in a single game' do
      file_path = './data/fixture_game_teams.csv'
      game_team_manager = GameTeamManager.new(file_path)
      game_team_manager.load

      expect(game_team_manager.fewest_goals_scored("5")).to eq(0)
      expect(game_team_manager.fewest_goals_scored("6")).to eq(1)
    end
  end

  describe '#opponents_list(team_id)' do
    it 'lists opponents' do
      file_path = './data/fixture_game_teams.csv'
      game_team_manager = GameTeamManager.new(file_path)
      game_team_manager.load
      list = game_team_manager.opponents_list("6")
      expect(list).to eq({"3"=>{:games=>5, :wins=>0}, "5"=>{:games=>4, :wins=>0}})
    end
  end

  describe '#favorite_opponent(team_id)' do
    xit 'returns opponent with lowest win percentage against team' do
      file_path = './data/fixture_game_teams.csv'
      game_team_manager = GameTeamManager.new(file_path)
      game_team_manager.load

      expect(game_team_manager.favorite_opponent("6")).to eq("Houston Dynamo")
    end
  end
end
