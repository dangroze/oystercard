require 'oystercard'
RSpec.describe Oystercard do
  let(:station1) { double :station }
  let(:station2) { double :station }
  it 'initializes an empty array' do
    expect(subject.journeys).to eq []
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
  it 'starts a journey' do
    expect(subject).not_to be_in_journey
  end
  describe '#touch_in' do
    it 'raises error when there are insufficient funds' do
      expect { subject.touch_in(station1) }.to raise_error "Insufficient funds!"
    end
    it 'records the station' do
      subject.top_up(10)
      subject.touch_in(station1)
      expect(subject.entry_station).to eq station1
    end
  end
  describe '#touch_out' do
    it 'charges on touch_out' do
      minimum_fare = Oystercard::MIN_FARE
      subject.top_up(10)
      subject.touch_in(station1)
      expect { subject.touch_out(station2) }.to change { subject.balance }.by(-minimum_fare)
    end
    it "forgets the entry station" do
      subject.top_up(10)
      subject.touch_in(station1)
      subject.touch_out(station2)
      expect(subject.entry_station).to be_nil
    end
  end
  describe "#journey_log" do
  it "has no journeys by default" do
    expect(subject.journeys).to be_empty
  end
  it "has the entry station" do
    subject.top_up(10)
    subject.touch_in(station1)
    subject.touch_out(station2)
    expect(subject.journeys[0][:entry_station]).to eq(station1)
  end
  it "has the exit station" do
    subject.top_up(10)
    subject.touch_in(station1)
    subject.touch_out(station2)
    expect(subject.journeys[0][:exit_station]).to eq(station2)
  end
  it "stores entry & exit stations as one journey" do
    subject.top_up(10)
    subject.touch_in(station1)
    subject.touch_out(station2)
    expect(subject.journeys[0]).to include(:entry_station, :exit_station)
  end
end
end
