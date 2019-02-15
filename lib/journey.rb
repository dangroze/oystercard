require_relative 'station'
require_relative 'journey'

class Journey
  attr_reader :journey, :journey_list

  MIN_FARE = 1
  PENALTY_FARE = 6

  def initialize
    @journey = {}
    @journey_list = []
  end

  def add_entry_station(entry_station)
    @journey[:entry] = entry_station
  end

  def add_exit_station(exit_station)
    @journey[:exit] = exit_station
  end

  def add_to_journey_list
    @journey_list << @journey
  end

  def complete?
    !!@journey[:entry] && !!@journey[:exit]
  end

  def fare
    complete? ? MIN_FARE : PENALTY_FARE
  end

end
