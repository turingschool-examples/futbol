require "./spec/spec_helper"

RSpec.describe StatTracker do
    it 'exists' do
        game_path = './data/games.csv'
        team_path = './data/teams.csv'
        game_teams_path = './data/game_teams.csv'

        locations = {
            games: game_path,
            teams: team_path,
            game_teams: game_teams_path
        }

        stat_tracker = StatTracker.new(locations)
        expect(stat_tracker).to be_an_instance_of(StatTracker)
    end

    describe '#game stats' do
        describe '#total_scores' do
            it 'returns the highest total score' do
                game_path = './spec/fixtures/games_fixture.csv'
                #this is looking at the original teams.csv file rn
                team_path = './data/teams.csv'
                game_teams_path = './spec/fixtures/game_teams_fixture.csv'

                locations = {
                    games: game_path,
                    teams: team_path,
                    game_teams: game_teams_path
                }

                stat_tracker = StatTracker.from_csv(locations)
                expect(stat_tracker.highest_total_score).to eq(7)
                expect(stat_tracker.lowest_total_score).to eq(2)
            end

            it 'returns the lowest total score' do
                game_path = './spec/fixtures/games_fixture.csv'
                #this is looking at the original teams.csv file rn
                team_path = './data/teams.csv'
                game_teams_path = './spec/fixtures/game_teams_fixture.csv'

                locations = {
                    games: game_path,
                    teams: team_path,
                    game_teams: game_teams_path
                }

                stat_tracker = StatTracker.from_csv(locations)
                expect(stat_tracker.lowest_total_score).to eq(2)
            end
        end

        describe '#percentage_home_wins' do
            it 'returns the percentage of home wins' do
                game_path = './spec/fixtures/games_fixture.csv'
                team_path = './spec/fixtures/teams_fixture.csv'
                game_teams_path = './spec/fixtures/game_teams_fixture.csv'

                locations = {
                    games: game_path,
                    teams: team_path,
                    game_teams: game_teams_path
                }

                stat_tracker = StatTracker.from_csv(locations)
            
                expect(stat_tracker.percentage_home_wins).to eq(0.55)
            end
        end

        describe '#percentage_visitor_wins' do
            it 'returns the percentage of visitor wins' do
                game_path = './spec/fixtures/games_fixture.csv'
                team_path = './spec/fixtures/teams_fixture.csv'
                game_teams_path = './spec/fixtures/game_teams_fixture.csv'

                locations = {
                    games: game_path,
                    teams: team_path,
                    game_teams: game_teams_path
                }

                stat_tracker = StatTracker.from_csv(locations)

                expect(stat_tracker.percentage_visitor_wins).to eq(0.4)
            end
        end

        describe '#percentage_ties' do
            it 'returns the percentage of ties' do
                game_path = './spec/fixtures/games_fixture.csv'
                team_path = './spec/fixtures/teams_fixture.csv'
                game_teams_path = './spec/fixtures/game_teams_fixture.csv'

                locations = {
                    games: game_path,
                    teams: team_path,
                    game_teams: game_teams_path
                }

                stat_tracker = StatTracker.from_csv(locations)

                expect(stat_tracker.percentage_ties).to eq(0.1)
            end
        end

        describe '#count of teams' do
            it 'returns average goals per season' do
                game_path = './spec/fixtures/games_fixture.csv'
                team_path = './spec/fixtures/teams_fixture.csv'
                game_teams_path = './spec/fixtures/game_teams_fixture.csv'

                locations = {
                    games: game_path,
                    teams: team_path,
                    game_teams: game_teams_path
                }

                stat_tracker = StatTracker.from_csv(locations)
                expect(stat_tracker.count_of_teams).to eq(4)
            end
        end

        describe '#average goals' do
            it 'returns average goals for all seasons' do
                game_path = './spec/fixtures/games_fixture.csv'
                team_path = './spec/fixtures/teams_fixture.csv'
                game_teams_path = './spec/fixtures/game_teams_fixture.csv'

                locations = {
                    games: game_path,
                    teams: team_path,
                    game_teams: game_teams_path
                }

                stat_tracker = StatTracker.from_csv(locations)
                expect(stat_tracker.average_goals_per_game).to eq(4.45)
            end

            it 'returns average goals per season' do
                game_path = './spec/fixtures/games_fixture.csv'
                team_path = './spec/fixtures/teams_fixture.csv'
                game_teams_path = './spec/fixtures/game_teams_fixture.csv'

                locations = {
                    games: game_path,
                    teams: team_path,
                    game_teams: game_teams_path
                }
                stat_tracker = StatTracker.from_csv(locations)
                expect(stat_tracker.average_goals_per_season).to eq({20122013 => 4.56, 20132014 => 4.36})
            end
        end
    end

    describe '#highest and lowest scoring visitor and home team' do
        it 'returns highest scoring visitor' do
            game_path = './spec/fixtures/games_fixture.csv'
            team_path = './data/teams.csv'
            game_teams_path = './spec/fixtures/game_teams_fixture.csv'

            locations = {
                games: game_path,
                teams: team_path,
                game_teams: game_teams_path
            }

            stat_tracker = StatTracker.from_csv(locations)
            expect(stat_tracker.highest_scoring_visitor).to eq("FC Dallas")
        end 
        
        it 'returns highest scoring home team' do
            game_path = './spec/fixtures/games_fixture.csv'
            team_path = './data/teams.csv'
            game_teams_path = './spec/fixtures/game_teams_fixture.csv'

            locations = {
                games: game_path,
                teams: team_path,
                game_teams: game_teams_path
            }

            stat_tracker = StatTracker.from_csv(locations)
            expect(stat_tracker.highest_scoring_home_team).to eq("FC Dallas")
        end

        it 'returns lowest scoring visitor' do
            game_path = './spec/fixtures/games_fixture.csv'
            team_path = './data/teams.csv'
            game_teams_path = './spec/fixtures/game_teams_fixture.csv'

            locations = {
                games: game_path,
                teams: team_path,
                game_teams: game_teams_path
            }

            stat_tracker = StatTracker.from_csv(locations)
            expect(stat_tracker.lowest_scoring_visitor).to eq("Houston Dynamo")
        end

        it 'returns lowest scoring home team' do
            game_path = './spec/fixtures/games_fixture.csv'
            team_path = './data/teams.csv'
            game_teams_path = './spec/fixtures/game_teams_fixture.csv'

            locations = {
                games: game_path,
                teams: team_path,
                game_teams: game_teams_path
            }

            stat_tracker = StatTracker.from_csv(locations)
            expect(stat_tracker.lowest_scoring_home_team).to eq("Sporting Kansas City")
        end
    end 
end

