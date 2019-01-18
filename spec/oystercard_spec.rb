require 'oystercard'
RSpec.describe Oystercard do
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
      expect { subject.touch_in }.to raise_error "Insufficient funds!"
    end
  end
  describe '#touch_out' do
    it 'charges on touch_out' do
      minimum_fare = Oystercard::MIN_FARE
      subject.top_up(10)
      subject.touch_in
      subject.touch_out
      expect { subject.touch_out }.to change { subject.balance }.by(-minimum_fare)
    end
  end
end
