class Oystercard
  attr_reader :balance, :entry_station, :exit_station, :journeys

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 2

  def initialize
    @balance = 0
    @journeys = {}
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
    @exit_station = nil
  end

  def touch_out(station)
    @exit_station = station
    @journeys[@entry_station] = @exit_station
    @entry_station = nil

    deduct(MINIMUM_FARE)
  end

  def in_journey?
    !@entry_station.nil? && @exit_station.nil?
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
# hash = {
#   1 => [entry_station1,exit_station1],
#   entry_station2 => exit_station2
# }
