require './spec/spec_helper'


describe GameStatistics do
    before(:all) do
        GameStatistics.set_gamecsv('./data/games.csv')
    end

    describe '#self.highest_total_score' do
        it 'can return the highest scored game' do
            expect(GameStatistics.highest_total_score).to eq 11
        end
    end

    describe '#self.lowest_total_score' do
        it 'can return the lowest scored game' do
            expect(GameStatistics.lowest_total_score).to eq 0 
        end
    end

    describe '#self.percentage_home_wins' do
        it 'can return the percentage of games won by the home team' do
            expect(GameStatistics.percentage_home_wins).to eq 0.44
        end
    end

    describe '#percentage_visitor_wins' do
        it 'can return the percentage of games won by the visiting team' do
            expect(GameStatistics.percentage_visitor_wins).to eq 0.36
        end
    end

    describe '#percentage_ties' do
        it 'can return the percentage of games that tied' do
            expect(GameStatistics.percentage_ties).to eq 0.20
        end
    end

    describe '#count_of_games_by_season' do
        it 'can list every game in a season' do
            expect(GameStatistics.count_of_games_by_season).to eq(
                {
                "20122013"=>806,
                "20162017"=>1317,
                "20142015"=>1319,
                "20152016"=>1321,
                "20132014"=>1323,
                "20172018"=>1355
                }
            )
        end
    end

    describe '#average_goals_per_game' do
        it 'can average the goals per game' do
            expect(GameStatistics.average_goals_per_game).to eq(4.22)
        end
    end

    describe '#average_goals_by_season' do
        it 'can average the goals by season' do
            expect(GameStatistics.average_goals_by_season).to eq({
                "20122013"=>4.12,
                "20162017"=>4.23,
                "20142015"=>4.14,
                "20152016"=>4.16,
                "20132014"=>4.19,
                "20172018"=>4.44
                })
        end
    end
end