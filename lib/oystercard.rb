class Oystercard
  attr_reader :balance
  attr_reader :entry_station

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 2

  def initialize
    @balance = 0
  end

  def top_up(amount)
    maximum_balance = MAXIMUM_BALANCE
    if amount + @balance > MAXIMUM_BALANCE
      raise "Maximum balance of #{maximum_balance} reached!"
    end

    @balance += amount
  end

  def touch_in(station)
    raise "Insufficient funds!" if balance < MINIMUM_BALANCE

    @entry_station = station
  end

  def touch_out
    @entry_station = nil
    deduct(MINIMUM_FARE)
  end

  def in_journey?
    @entry_station.nil? ? false : true
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
