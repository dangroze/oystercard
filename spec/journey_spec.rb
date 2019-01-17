require 'journey'

RSpec.describe Journey do
  it 'initializes an empty hash' do
    expect(subject.journey).to eq({})
  end
end
