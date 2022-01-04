# frozen_string_literal: true

require './lib/season_statistics'
require 'RSpec'

RSpec.describe SeasonStatistics do
  before(:each) do
    @season_statistics = SeasonStatistics.new
  end

  it 'will read in data' do
    expect(@season_statistics.game_data).to eq(3)
  end
end
