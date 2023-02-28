require 'csv'
require './lib/total_scores'

RSpec.describe 'total_scores' do
  it 'can test highest score' do
    expect(highest_total_score).to eq(11)
  end

  it 'can test lowest score' do
    expect(lowest_total_score).to eq(0)
  end
end