require './lib/game_team_manager'
require './lib/stat_tracker'
require './lib/team_manager'

RSpec.describe GameTeamManager do # reorginize according to postion in actual class
  before(:each) do
    file_path = './data/fixture_game_teams.csv'
    @game_team_manager = GameTeamManager.new(file_path)
  end

  describe '#load' do
    it 'length' do
      expect(@game_team_manager.game_teams.length).to eq(39)
    end

    it 'creates game object for every row' do
      @game_team_manager.game_teams.each do |game_id, team_hash|
        expect(team_hash[:home]).to be_instance_of(GameTeam)
        expect(team_hash[:away]).to be_instance_of(GameTeam)
      end
    end
  end

  describe 'helper methods for best_offense and worse_offense' do
    it 'counts total games for all seasons' do
      expect(@game_team_manager.total_games_all_seasons("3")).to eq(5)
    end

    it 'counts total goals for all seasons' do
      expect(@game_team_manager.total_goals_all_seasons("3")).to eq(8)
    end

    it 'calculates average goals for all seasons' do
      expect(@game_team_manager.average_goals_all_seasons("3")).to eq(1.60)
    end
  end

  describe 'best and worst offense methods' do
    it 'returns best_offense team string' do
      expect(@game_team_manager.best_offense).to eq("9")
    end

    it 'returns worst_offense team string' do
      expect(@game_team_manager.worst_offense).to eq("5")
    end
  end

  describe 'highest/lowest scoring home and away' do
    it 'returns highest scoring visitor name' do
      expect(@game_team_manager.highest_scoring_visitor).to eq("6")
    end

    it 'returns highest scoring home name' do
      expect(@game_team_manager.highest_scoring_home_team).to eq("9")
    end

    it 'returns lowest scoring visitor name' do
      expect(@game_team_manager.lowest_scoring_visitor).to eq("5")
    end

    it 'returns lowest scoring home name' do
      expect(@game_team_manager.lowest_scoring_home_team).to eq("5")
    end
  end

  describe '#home and away teams' do
    it 'returns home teams' do
      @game_team_manager.home_teams.each do |team|
        expect(team.hoa).to eq("home")
      end
    end

    it 'returns away teams' do
      @game_team_manager.away_teams.each do |team|
        expect(team.hoa).to eq("away")
      end
    end
  end

  describe '#home and away games' do
    it 'returns home games' do
      @game_team_manager.home_games_per_team("3").each do |game|
        expect(game.team_id).to eq("3")
        expect(game.hoa).to eq("home")
      end
    end

    it 'returns away games' do
      @game_team_manager.away_games_per_team("3").each do |game|
        expect(game.team_id).to eq("3")
        expect(game.hoa).to eq("away")
      end
    end
  end

  describe '#average_win_percentage(team_id)' do
    it 'calculates average for all games for a team' do
      expect(@game_team_manager.average_win_percentage("26")).to eq(0.50)
      expect(@game_team_manager.average_win_percentage("3")).to eq(0.00)
      expect(@game_team_manager.average_win_percentage("6")).to eq(1.00)
    end
  end

  describe '#all_games_by_team(team_id)' do
    it 'returns array of all games by team' do
      games = @game_team_manager.all_games_by_team("3")
      games.each do |game_team|
        expect(game_team.team_id).to eq("3")
        expect(game_team).to be_instance_of(GameTeam)
      end
    end
  end

  describe '#most_goals_scored(team_id)' do
    it 'returns most goals in a single game' do
      expect(@game_team_manager.most_goals_scored("3")).to eq(2)
      expect(@game_team_manager.most_goals_scored("6")).to eq(4)
    end
  end

  describe '#fewest_goals_scored(team_id)' do
    it 'returns least goals in a single game' do
      expect(@game_team_manager.fewest_goals_scored("5")).to eq(0)
      expect(@game_team_manager.fewest_goals_scored("6")).to eq(1)
    end
  end

  describe '#opponents_list(team_id)' do
    it 'lists opponents' do
      list = @game_team_manager.opponents_list("6")
      expect(list).to eq({"3"=>{:games=>5, :wins=>0}, "5"=>{:games=>4, :wins=>0}})
    end
  end

  describe '#favorite_opponent(team_id)' do
    it 'returns opponent with lowest win percentage against team' do
      expect(@game_team_manager.favorite_opponent("6")).to eq("3")
    end
  end

  describe '#rival(team_id)' do
    it 'returns opponent with highest win percentage against team' do
      expect(@game_team_manager.rival("3")).to eq("6")
    end
  end
end
