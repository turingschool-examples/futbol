require './lib/game_manager'

RSpec.describe GameManager do
  describe '#load' do
    it 'length' do
      file_path = './data/fixture_games.csv'
      game_manager = GameManager.new(file_path)

      expect(game_manager.load.length).to eq(40)
    end

    it 'creates game object for every row' do
      file_path = './data/fixture_games.csv'
      game_manager = GameManager.new(file_path)
      game_manager.load

      game_manager.games.each do |game_id, game_object|
        expect(game_object).to be_instance_of(Game)
      end
    end
  end

  describe '#highest_total_score' do
    it 'highest_total_score' do
      file_path = './data/fixture_games.csv'
      game_manager = GameManager.new(file_path)
      game_manager.load

      expect(game_manager.highest_total_score).to eq(5)
    end
  end

  describe '#lowest_total_score' do
    it 'lowest_total_score' do
      file_path = './data/fixture_games.csv'
      game_manager = GameManager.new(file_path)
      game_manager.load

      expect(game_manager.lowest_total_score).to eq(1)
    end
  end

  describe '#percentage_home_wins' do
    it "percentage_home_wins" do
      file_path = './data/fixture_games.csv'
      game_manager = GameManager.new(file_path)
      game_manager.load

      expect(game_manager.percentage_home_wins).to eq(62.5)
    end
  end

  describe '#percentage_visitor_wins' do
    it "percentage_visitor_wins" do
      file_path = './data/fixture_games.csv'
      game_manager = GameManager.new(file_path)
      game_manager.load

      expect(game_manager.percentage_visitor_wins).to eq(32.5)
    end
  end

  describe '#percentage_ties' do
    it "percentage_ties" do
      file_path = './data/fixture_games.csv'
      game_manager = GameManager.new(file_path)
      game_manager.load

      expect(game_manager.percentage_ties).to eq(5.0)
    end
  end

  describe '#count_of_games_by_season' do
    it "count_of_games_by_season" do
      file_path = './data/fixture_games.csv'
      game_manager = GameManager.new(file_path)
      game_manager.load

      expect(game_manager.count_of_games_by_season).to eq({
        "20122013" => 39,
        "20152016" => 1
        })
    end
  end

  describe '#average_goals_per_game' do
    it "average_goals_per_game" do
      file_path = './data/fixture_games.csv'
      game_manager = GameManager.new(file_path)
      game_manager.load

      expect(game_manager.average_goals_per_game).to eq(3.875)
    end
  end

  describe '#average_goals_per_season' do
    it "average_goals_per_season" do
      file_path = './data/fixture_games.csv'
      game_manager = GameManager.new(file_path)
      game_manager.load

      expect(game_manager.average_goals_per_season).to eq({
        "20122013"=>3.871794871794872,
        "20152016"=>4.0})
    end
  end

end
