require_relative './spec_helper.rb'

RSpec.describe StatTracker do
    let(:game_statistics) { GameStatistics.from_csv('./data/games_sample.csv') }
    let(:league_statistics) { LeagueStatistics.from_csv('./data/game_teams_sample.csv', './data/teams_sample.csv') }
    let(:season_statistics) { SeasonStatistics.from_csv('./data/games_sample.csv', './data/game_teams_sample.csv', './data/teams_sample.csv') }
    let(:stat_tracker) { StatTracker.new(game_statistics,league_statistics,season_statistics) }

    describe '#initialize' do
        it 'exists' do
            expect(stat_tracker).to be_a StatTracker
            expect(stat_tracker.game_statistics).to be_a GameStatistics
            expect(stat_tracker.league_statistics).to be_a LeagueStatistics
            expect(stat_tracker.season_statistics).to be_a SeasonStatistics
        end
    end

    describe '#self.from_csv(location)' do
        it 'can access the location' do
            location = { games: './data/games_sample.csv',
                        teams: './data/teams_sample.csv',
                        game_teams: './data/game_teams_sample.csv' }
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
            expect(stat_tracker.highest_total_score).to eq(5)
        end
    end

    describe '#lowest_total_score' do
        it 'has a lowest total score' do
            expect(stat_tracker.lowest_total_score).to eq(3)
        end
    end

    describe '#percentage_home_wins' do
        it 'has percentage_home_wins' do
            expect(stat_tracker.percentage_home_wins).to eq(75)
        end
    end

    describe '#percentage_away_wins' do
        it 'has percentage_away_wins' do
            expect(stat_tracker.percentage_away_wins).to eq(25)
        end
    end

    describe '#percentage_ties' do
        it 'has percentage_ties' do
            expect(stat_tracker.percentage_ties).to eq(0)
        end
    end

    describe '#count_of_games_by_season' do
        it 'has count_of_games_by_season' do
            expect(stat_tracker.count_of_games_by_season).to eq(20122013=>4)
        end
    end

    describe '#average_goals_per_game' do
        it 'averages goals per game' do
            expect(stat_tracker.average_goals_per_game).to eq(4.0)
        end
    end

    describe '#average_goals_by_season' do
        it 'averages goals by season' do
            expect(stat_tracker.average_goals_by_season).to eq({20122013=>4.0})
        end
    end

    describe '#count_of_teams' do
        it 'counts all teams' do
            expect(stat_tracker.count_of_teams).to eq(6)
        end
    end

    describe '#best_offense' do
        it 'returns the best offense' do
            expect(stat_tracker.best_offense).to eq('FC Dallas')
        end
    end

    describe '#worst_offense' do
        it 'returns the worst offense' do
            expect(stat_tracker.worst_offense).to eq('LA Galaxy')
        end
    end

    describe '#highest_scoring_visitor' do
        it 'returns the highest scoring visitor' do
            expect(stat_tracker.highest_scoring_visitor).to eq('Houston Dynamo')
        end
    end

    describe '#lowest_scoring_visitor' do
        it 'returns the lowest scoring visitor' do
            expect(stat_tracker.lowest_scoring_visitor).to eq('LA Galaxy')
        end
    end

    describe '#highest_scoring_home_team' do
        it 'returns the name of home team with the highest average number of goals scored per game' do
            expect(stat_tracker.highest_scoring_home_team).to eq('FC Dallas')
        end
    end

    describe '#lowest_scoring_home_team' do
        it 'returns the name of home team with the lowest average number of goals scored per game' do
            expect(stat_tracker.lowest_scoring_home_team).to eq('New England Revolution')
        end
    end

    describe '#worst_coach' do
        it 'returns the name of worst coach who has the wost win percentage for the season' do
            expect(stat_tracker.worst_coach(20122013)).to eq("John Tortorella")
        end
    end

    describe '#winningest_coach' do
        it 'returns the name of worst coach who has the wost win percentage for the season' do
            expect(stat_tracker.winningest_coach(20122013)).to eq("Claude Julien")
        end
    end

    describe '#most_accurate_team' do
        it 'returns the name of team with the best ratio of shots to goals for the season' do
            expect(stat_tracker.most_accurate_team(20122013)).to eq("FC Dallas")
        end
    end

    describe '#least_accurate_team' do
        it 'returns the name of team with the worst ratio of shots to goals for the season' do
            expect(stat_tracker.least_accurate_team(20122013)).to eq("New England Revolution")
        end
    end

    describe '#most_tackles' do
        it 'returns the name of team with the most tackles in the season' do
            expect(stat_tracker.most_tackles(20122013)).to eq("FC Dallas")
        end
    end

    describe '#fewest_tackles' do
        it 'returns the name of team with the most tackles in the season' do
            expect(stat_tracker.fewest_tackles(20122013)).to eq("New England Revolution")
        end
    end
end
# putting this here to see if it detects a change
