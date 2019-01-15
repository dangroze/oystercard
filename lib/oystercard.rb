class Oystercard
  attr_reader :balance
  attr_reader :in_use

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1

  def initialize
    @balance = 0
    @in_use = false
  end

  def top_up(amount)
    maximum_balance = MAXIMUM_BALANCE
    raise "Maximum balance of #{maximum_balance} reached!" if amount + @balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    raise "Insufficient funds!" if balance < MINIMUM_BALANCE
    @in_use = true
  end

  def touch_out
    @in_use = false
  end

  def in_journey?
    @in_use
  end
end
