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
  describe '#add_to_journey_list' do
    it 'adds the journey to the list' do
      expect(subject.add_to_journey_list).to include(subject.journey_h)
    end
  end
  describe '#complete?' do
    it 'checks if a journey is complete' do
      subject.add_entry_station(@entry_station)
      subject.add_exit_station(@exit_station)
      expect(subject).to be_complete
    end
  end
  describe '#fare' do
    it 'returns the minimum fare' do
      subject.add_entry_station(@entry_station)
      subject.add_exit_station(@exit_station)
      expect(subject.fare).to eq Journey::MIN_FARE
    end
    it 'returns a penalty fare if not touched_in' do
      subject.add_exit_station(@exit_station)
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
    it 'returns a penalty fare in not touched_out' do
      subject.add_entry_station(@entry_station)
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
  end
end
