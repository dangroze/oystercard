require_relative 'station'

class Journey
  attr_reader :journey_h

  def initialize
    @journey_h = {}
  end

  def add_entry_station(entry_station)
    @journey_h[:entry] = entry_station.name
  end

  def add_exit_station(exit_station)
    @journey_h[:exit] = exit_station.name
  end
  
end
