require 'oystercard'
RSpec.describe Oystercard do
  let(:station1) { double :station }
  let(:station2) { double :station }
  describe '#top_up' do
    it 'tops up the balance' do
      expect { subject.top_up(1) }.to change { subject.balance }.by(1)
    end
    it 'reaches maximum balance' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect { subject.top_up(1) }.to raise_error "Maximum balance of #{maximum_balance} reached!"
    end
  end
  it 'starts a journey' do
    expect(subject).not_to be_in_journey
  end
  describe '#touch_in' do
    it 'records the station' do
      subject.top_up(10)
      subject.touch_in(station1)
      expect(subject.entry_station).to eq station1
    end
    it 'touches_in' do
      subject.top_up(10)
      subject.touch_in(station1)
      expect(subject).to be_in_journey
    end
    it 'raises error when there are insufficient funds' do
      expect { subject.touch_in(station1) }.to raise_error "Insufficient funds!"
    end
  end
  describe '#touch_out' do
    it 'records station at end of journey' do
      subject.top_up(10)
      subject.touch_in(station1)
      subject.touch_out(station2)
      expect(subject.exit_station).to eq station2
    end
    it 'touches_out' do
      subject.top_up(10)
      subject.touch_in(station1)
      subject.touch_out(station2)
      expect(subject).not_to be_in_journey
    end
    it 'charges on touch_out' do
      minimum_fare = Oystercard::MINIMUM_FARE
      subject.top_up(10)
      subject.touch_in(station1)
      expect { subject.touch_out(station2) }.to change { subject.balance }.by(-minimum_fare)
    end
  end
end
