require_relative 'station'

class Journey
  attr_reader :journey_h, :journeys

  def initialize
    @journey_h = {}
    @journeys = []
  end

  def add_entry_station(entry_station)
    @journey_h[:entry] = entry_station.name
  end

  def add_exit_station(exit_station)
    @journey_h[:exit] = exit_station.name
  end

  def add_to_journey_list
    @journeys << @journey_h
  end

end
