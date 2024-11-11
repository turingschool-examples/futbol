require_relative 'spec_helper'

RSpec.describe GameTeams do
  context 'can be created externally' do
    before(:all) do
      @objects = []

      CSV.foreach('./spec/fixtures/fixture_game_teams.csv', headers: true, header_converters: :symbol) do |row|
        @objects << GameTeams.new(
          row[:game_id],
          row[:team_id],
          row[:hoa],
          row[:result],
          row[:head_coach],
          row[:goals].to_i,
          row[:shots].to_i,
          row[:tackles].to_i
        )
      end
    end

    describe '#initialize' do
      it 'exists' do
        expect(@objects[0]).to be_an_instance_of(GameTeams)
      end

      it 'has attributes' do
        expect(@objects[0].game_id).to eq("2012030221")
        expect(@objects[0].team_id).to eq("3")
        expect(@objects[0].hoa).to eq("away")
        expect(@objects[0].result).to eq("LOSS")
        expect(@objects[0].head_coach).to eq("John Tortorella")
        expect(@objects[0].goals).to eq(2)
        expect(@objects[0].shots).to eq(8)
        expect(@objects[0].tackles).to eq(44)
      end

      it 'can have different attributes' do
        expect(@objects[1].game_id).to eq("2012030221")
        expect(@objects[1].team_id).to eq("6")
        expect(@objects[1].hoa).to eq("home")
        expect(@objects[1].result).to eq("WIN")
        expect(@objects[1].head_coach).to eq("Claude Julien")
        expect(@objects[1].goals).to eq(3)
        expect(@objects[1].shots).to eq(12)
        expect(@objects[1].tackles).to eq(51)
      end
    end

    describe '#all' do
      it 'returns an array of all of its instances' do
        expect(GameTeams.all.count).to eq(2)
        expect(GameTeams.all).to be_an(Array)
        
        GameTeams.all.each do |object|
          expect(object).to be_an_instance_of(GameTeams)
        end

        GameTeams.reset
      end
    end
  end

  describe '#from_csv' do
    context 'when given a path string, it will create objects using the data in the csv file' do
      before(:all) do
        game_teams_path = './spec/fixtures/fixture_game_teams.csv'
        GameTeams.from_csv(game_teams_path)
      end

      it 'can create itself(s)' do
        expect(GameTeams.all.count).to eq(2)
      end

      it 'still has proper attributes' do
        expect(GameTeams.all[0].game_id).to eq("2012030221")
        expect(GameTeams.all[0].team_id).to eq("3")
        expect(GameTeams.all[0].hoa).to eq("away")
        expect(GameTeams.all[0].result).to eq("LOSS")
        expect(GameTeams.all[0].head_coach).to eq("John Tortorella")
        expect(GameTeams.all[0].goals).to eq(2)
        expect(GameTeams.all[0].shots).to eq(8)
        expect(GameTeams.all[0].tackles).to eq(44)
      end

      it 'can still have different attributes' do
        expect(GameTeams.all[1].game_id).to eq("2012030221")
        expect(GameTeams.all[1].team_id).to eq("6")
        expect(GameTeams.all[1].hoa).to eq("home")
        expect(GameTeams.all[1].result).to eq("WIN")
        expect(GameTeams.all[1].head_coach).to eq("Claude Julien")
        expect(GameTeams.all[1].goals).to eq(3)
        expect(GameTeams.all[1].shots).to eq(12)
        expect(GameTeams.all[1].tackles).to eq(51)

        GameTeams.reset
      end
    end
  end
end