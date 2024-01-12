require_relative './spec_helper.rb'

RSpec.describe StatTracker do
    describe '#initialize' do
        it 'exists' do
            game_statistics_instance = GameStatistics.new
            stat_tracker = StatTracker.new(game_statistics_instance)

            expect(stat_tracker).to be_a StatTracker
            expect(stat_tracker.game_statistics).to be_a GameStatistics
        end
    end

    describe '#self.from_csv(location)' do
        it 'can access the location' do
            location = { games: './data/games_sample.csv'}
            stat_tracker = StatTracker.from_csv(location)

            expect(stat_tracker).to be_a StatTracker
            expect(stat_tracker.game_statistics).to be_a GameStatistics
            expect(stat_tracker.game_statistics.games.first.game_id).to eq(2012030221)
            expect(stat_tracker.game_statistics.games.first.season).to eq(20122013)
            expect(stat_tracker.game_statistics.games.first.type).to eq("Postseason")
            expect(stat_tracker.game_statistics.games.first.away_team_id).to eq(3)
            expect(stat_tracker.game_statistics.games.first.home_team_id).to eq(6)
            expect(stat_tracker.game_statistics.games.first.away_goals).to eq(2)
            expect(stat_tracker.game_statistics.games.first.home_goals).to eq(3)
        end
    end

    describe '#highest_total_score' do
        it 'has a highest total score' do
            game_stats = GameStatistics.from_csv('./data/games_sample.csv')
            stat_tracker = StatTracker.new(game_stats)

            expect(stat_tracker.highest_total_score).to eq(5)
        end
    end

    describe '#lowest_total_score' do
        it 'has a lowest total score' do
            game_stats = GameStatistics.from_csv('./data/games_sample.csv')
            stat_tracker = StatTracker.new(game_stats)

            expect(stat_tracker.lowest_total_score).to eq(3)
        end
    end

    describe '#percentage_home_wins' do
        it 'has percentage_home_wins' do
            game_stats = GameStatistics.from_csv('./data/games_sample.csv')
            stat_tracker = StatTracker.new(game_stats)

            expect(stat_tracker.percentage_home_wins).to eq(50)
        end
    end

    describe '#percentage_away_wins' do
        it 'has percentage_away_wins' do
            game_stats = GameStatistics.from_csv('./data/games_sample.csv')
            stat_tracker = StatTracker.new(game_stats)

            expect(stat_tracker.percentage_away_wins).to eq(50)
        end
    end

    describe '#percentage_ties' do
        it 'has percentage_ties' do
            game_stats = GameStatistics.from_csv('./data/games_sample.csv')
            stat_tracker = StatTracker.new(game_stats)

            expect(stat_tracker.percentage_ties).to eq(0)
        end
    end

    describe '#count_of_games_by_season' do
    it 'has count_of_games_by_season' do
        game_stats = GameStatistics.from_csv('./data/games_sample.csv')
        stat_tracker = StatTracker.new(game_stats)

        expect(stat_tracker.count_of_games_by_season).to eq(20122013=>4)
    end
end
end
