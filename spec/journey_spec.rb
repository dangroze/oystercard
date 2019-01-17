require 'journey'

RSpec.describe Journey do
  before(:each) do
    @entry_station = Station.new("Bow", 2)
    @exit_station = Station.new("Aldgate", 1)
  end
  it 'initializes an empty hash' do
    expect(subject.journey_h).to eq({})
  end
  describe '#add_entry_station' do
    it 'adds an entry station to the hash' do
      subject.add_entry_station(@entry_station)
      expect(subject.journey_h[:entry]).to eq(@entry_station.name)
    end
  end
  describe '#add_exit_station' do
    it 'adds an exit station to the hash' do
      subject.add_exit_station(@exit_station)
      expect(subject.journey_h[:exit]).to eq(@exit_station.name)
    end
  end
end
