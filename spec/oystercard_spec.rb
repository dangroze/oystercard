require 'oystercard'
RSpec.describe Oystercard do
  describe '#top_up' do
    it 'tops up the balance' do
      expect { subject.top_up(1)}.to change{ subject.balance }.by(1)
    end
    it 'reaches maximum balance' do
      maximum_balance = Oystercard::MAXIMUM_BALANCE
      subject.top_up(maximum_balance)
      expect { subject.top_up(1) }.to raise_error "Maximum balance of #{maximum_balance} reached!"
    end
  end
  describe '#deduct' do
    it 'deducts money from balance' do
      subject.top_up(5)
      expect { subject.deduct(1) }.to change{ subject.balance }.by(-1)
    end
  end
  it 'starts a journey' do
    expect(subject).not_to be_in_journey
  end
  it '#touches_in' do
    subject.top_up(10)
    subject.touch_in
    expect(subject).to be_in_journey
  end
  it 'raises error when there are insufficient funds' do
    expect { subject.touch_in }.to raise_error "Insufficient funds!"
  end
  it '#touches_out' do
    subject.top_up(10)
    subject.touch_in
    subject.touch_out
    expect(subject).not_to be_in_journey
  end
end
