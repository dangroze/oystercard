require 'oystercard'
RSpec.describe Oystercard do
  before(:each) do
    @entry_station = Station.new("Bow", 2)
    @exit_station = Station.new("Aldgate", 1)
  end
  it 'initializes an empty array' do
    expect(subject.journey_list).to eq []
  end
  it 'initializes an empty hash' do
    expect(subject.journey).to eq({})
  end

  describe '#top_up' do
    it 'tops up the balance' do
      expect { subject.top_up(1) }.to change { subject.balance }.by(1)
    end
    it 'reaches maximum balance' do
      maximum_balance = Oystercard::MAX_BALANCE
      subject.top_up(maximum_balance)
      expect { subject.top_up(1) }.to raise_error "Maximum balance of #{maximum_balance} reached!"
    end
  end
  describe '#touch_in' do
    it 'raises error when there are insufficient funds' do
      expect { subject.touch_in(@entry_station) }.to raise_error "Insufficient funds!"
    end
    it 'stores the station' do
      subject.top_up(10)
      subject.touch_in(@entry_station)
      expect(subject.journey[:entry]).to eq(@entry_station.name)
    end
  end
  describe '#touch_out' do
    it 'stores the station' do
      subject.top_up(10)
      subject.touch_in(@entry_station)
      subject.touch_out(@exit_station)
      expect(subject.journey[:exit]).to eq(@exit_station.name)
    end
    it 'charges on touch_out' do
      minimum_fare = Oystercard::MIN_FARE
      subject.top_up(10)
      subject.touch_in(@entry_station)
      subject.touch_out(@exit_station)
      expect { subject.touch_out(@exit_station) }.to change { subject.balance }.by(-minimum_fare)
    end
    it 'adds to journey list' do
      subject.top_up(10)
      subject.touch_in(@entry_station)
      subject.touch_out(@exit_station)
      allow(subject).to receive(:touch_out).and_return(subject.add_to_journey_list)
    end
  end
  describe '#add_to_journey_list' do
    it 'stores entry & exit stations as one journey' do
      subject.top_up(10)
      subject.touch_in(@entry_station)
      subject.touch_out(@exit_station)
      expect(subject.journey_list).to include(subject.journey)
    end
  end
end
