require 'journey'

RSpec.describe Journey do
  let (:station1) {double :station, zone: 1}
  let (:station2) {double :station, zone: 2}
  it 'initializes an empty hash' do
    expect(subject.journey).to eq({})
  end
  describe '#add_entry_station' do
    it 'adds an entry station to the hash' do
      subject.add_entry_station(station1)
      expect(subject.journey[:entry]).to eq(station1)
    end
  end
  describe '#add_exit_station' do
    it 'adds an exit station to the hash' do
      subject.add_exit_station(station2)
      expect(subject.journey[:exit]).to eq(station2)
    end
  end
  describe '#add_to_journey_list' do
    it 'adds the journey to the list' do
      expect(subject.add_to_journey_list).to include(subject.journey)
    end
  end
  describe '#complete?' do
    it 'checks if a journey is complete' do
      subject.add_entry_station(station1)
      subject.add_exit_station(station2)
      expect(subject).to be_complete
    end
  end
  describe '#fare' do
    it 'returns the minimum fare' do
      subject.add_entry_station(station1)
      subject.add_exit_station(station2)
      expect(subject.fare).to eq Journey::MIN_FARE
    end
    it 'returns a penalty fare if not touched_in' do
      subject.add_exit_station(station2)
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
    it 'returns a penalty fare in not touched_out' do
      subject.add_entry_station(station1)
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end
  end
end
