require_relative 'station'

class Oystercard
  attr_reader :balance, :entry_station, :journeys

  DEFAULT_BALANCE = 0
  MAX_BALANCE = 90
  MIN_BALANCE = 1
  MIN_FARE = 2

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journeys = []
  end

  def top_up(amount)
    if amount + @balance > MAX_BALANCE
      raise "Maximum balance of #{MAX_BALANCE} reached!"
    end

    @balance += amount
  end

  def touch_in(entry_station)
    raise "Insufficient funds!" if balance < MIN_BALANCE

    @entry_station = entry_station
  end

  def touch_out(exit_station)
    journey_log(@entry_station, exit_station)
    @entry_station = nil
    deduct(MIN_FARE)
  end

  def journey_log(entry_station, exit_station)
    journey = {
      entry_station: entry_station,
      exit_station: exit_station
    }
    @journeys << journey
  end

  def in_journey?
    !@entry_station.nil?
  end

  private

  def deduct(amount)
    @balance -= amount
  end
end
