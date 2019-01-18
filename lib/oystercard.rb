require_relative 'station'

class Oystercard
  attr_reader :balance

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 2

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(amount)
    if amount + @balance > MAX_BALANCE
      raise "Maximum balance of #{MAX_BALANCE} reached!"
    end

    @balance += amount
  end

  def touch_in
    raise "Insufficient funds!" if balance < MIN_BALANCE

  end

  def touch_out
    deduct(MIN_FARE)
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
