require_relative 'station'

class Oystercard
  attr_reader :balance, :journey, :journey_list

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 2

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journey_list = []
    @journey = {}
  end

  def top_up(amount)
    if amount + @balance > MAX_BALANCE
      raise "Maximum balance of #{MAX_BALANCE} reached!"
    end

    @balance += amount
  end

  def touch_in(entry_station)
    raise "Insufficient funds!" if balance < MIN_BALANCE
    
    @journey[:entry] = entry_station.name
  end

  def touch_out(exit_station)
    @journey[:exit] = exit_station.name
    deduct(MIN_FARE)
    add_to_journey_list
  end

  def add_to_journey_list
    @journey_list << @journey
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
