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
end
