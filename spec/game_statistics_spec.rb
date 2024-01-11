require './spec/spec_helper.rb'

RSpec.describe GameStatistics do 
    describe '#initialize' do 
    it 'exists' do 
        games = [
          Game.new({ game_id: "2012030221", season: "20122013", away_team_id: "3", home_team_id: "6", away_goals: 2, home_goals: 3 }),
          Game.new({ game_id: "2012030222", season: "20122013", away_team_id: "3", home_team_id: "6", away_goals: 2, home_goals: 3 }),
          Game.new({ game_id: "2012030223", season: "20122013", away_team_id: "6", home_team_id: "3", away_goals: 2, home_goals: 1 }),
          Game.new({ game_id: "2012030224", season: "20122013", away_team_id: "6", home_team_id: "3", away_goals: 3, home_goals: 2 })
        ]
        game_stats = GameStatistics.new(games)

        expect(game_stats).to be_a GameStatistics
    end
end

describe '.from_csv(filepath)' do 
    it 'has access to the data from the file path' do 
        game_stats = GameStatistics.from_csv('./data/games_sample.csv')

        expect(game_stats.games).to be_a Array
        expect(game_stats.games.first).to be_a Game
        expect(game_stats.games.size).to eq(4)
        expect(game_stats.games.first.game_id).to eq("2012030221")
        expect(game_stats.games.first.season).to eq("20122013")
        expect(game_stats.games.first.away_team_id).to eq('3')
        expect(game_stats.games.first.home_team_id).to eq('6')
        expect(game_stats.games.first.away_goals).to eq(2)
        expect(game_stats.games.first.home_goals).to eq(3)
    end
end

describe '#highest_total_score' do 
    it 'collects the highest score' do 
        games = [
          Game.new({ game_id: "2012030221", season: "20122013", away_team_id: "3", home_team_id: "6", away_goals: 2, home_goals: 3 }),
          Game.new({ game_id: "2012030222", season: "20122013", away_team_id: "3", home_team_id: "6", away_goals: 2, home_goals: 3 }),
          Game.new({ game_id: "2012030223", season: "20122013", away_team_id: "6", home_team_id: "3", away_goals: 2, home_goals: 1 }),
          Game.new({ game_id: "2012030224", season: "20122013", away_team_id: "6", home_team_id: "3", away_goals: 3, home_goals: 2 })
        ]
        game_stats = GameStatistics.new(games)
        
        expect(game_stats.highest_total_score).to eq(5)
    end
end

describe '#lowest_total_score' do 
    it 'collects the lowest score' do 
        games = [
          Game.new({ game_id: "2012030221", season: "20122013", away_team_id: "3", home_team_id: "6", away_goals: 2, home_goals: 3 }),
          Game.new({ game_id: "2012030222", season: "20122013", away_team_id: "3", home_team_id: "6", away_goals: 2, home_goals: 3 }),
          Game.new({ game_id: "2012030223", season: "20122013", away_team_id: "6", home_team_id: "3", away_goals: 2, home_goals: 1 }),
          Game.new({ game_id: "2012030224", season: "20122013", away_team_id: "6", home_team_id: "3", away_goals: 3, home_goals: 2 })
        ]
        game_stats = GameStatistics.new(games)

        expect(game_stats.lowest_total_score).to eq(3)
    end
end

describe '#percentage_home_wins' do 
    it 'gives a percent of home wins' do 
        games = [
          Game.new({ game_id: "2012030221", season: "20122013", away_team_id: "3", home_team_id: "6", away_goals: 2, home_goals: 3 }),
          Game.new({ game_id: "2012030222", season: "20122013", away_team_id: "3", home_team_id: "6", away_goals: 2, home_goals: 3 }),
          Game.new({ game_id: "2012030223", season: "20122013", away_team_id: "6", home_team_id: "3", away_goals: 2, home_goals: 1 }),
          Game.new({ game_id: "2012030224", season: "20122013", away_team_id: "6", home_team_id: "3", away_goals: 3, home_goals: 2 })
        ]
        game_stats = GameStatistics.new(games)
        
        expect(game_stats.percentage_home_wins).to eq(50.0)
    end
end

describe '#percentage_away_wins' do 
    it 'gives a percent of away wins' do 
        games = [
          Game.new({ game_id: "2012030221", season: "20122013", away_team_id: "3", home_team_id: "6", away_goals: 2, home_goals: 3 }),
          Game.new({ game_id: "2012030222", season: "20122013", away_team_id: "3", home_team_id: "6", away_goals: 2, home_goals: 3 }),
          Game.new({ game_id: "2012030223", season: "20122013", away_team_id: "6", home_team_id: "3", away_goals: 2, home_goals: 1 }),
          Game.new({ game_id: "2012030224", season: "20122013", away_team_id: "6", home_team_id: "3", away_goals: 3, home_goals: 2 })
        ]
        game_stats = GameStatistics.new(games)
        
        expect(game_stats.percentage_away_wins).to eq(50.0)
    end 
end 
end