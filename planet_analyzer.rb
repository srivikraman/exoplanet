require 'pp'
require './planet'
class PlanetAnalyzer
  attr_accessor :no_of_orphan_planet, :hottest_temp, :hottest_planets, :map_year_size
  def initialize(planets_data)
    @no_of_orphan_planet = 0
    @hottest_planets = []
    @hottest_temp = nil
    @map_year_size = {}
    @planets = parsed_planets_data(planets_data)
  end

  def analyze
    @planets.each do |planet|
      orphan_couner(planet)
      process_hottest_planet(planet)
      planet_size_mapper(planet)
    end
  end

  def print_result
    p "-----------------Result Data-----------------"
    p "No of orphan planet: #{@no_of_orphan_planet}"
    p "Hottest temperature value #{@hottest_temp} exist in planets #{@hottest_planets.join(',')}"
    p "Planet size by years"
    pp @map_year_size
  end

  private
  def orphan_couner(planet)
    @no_of_orphan_planet += 1 if planet.orphan?
  end

  def process_hottest_planet(planet)
    return if !(planet.host_star_temp_valid? && planet.hotter_than?(@hottest_temp))
    if @hottest_temp == planet.host_star_temp_k
      @hottest_planets << planet.planet_identifier
    else
      @hottest_planets = [planet.planet_identifier]
      @hottest_temp = planet.host_star_temp_k
    end
  end

  def planet_size_mapper(planet)
    year = planet.discovery_year
    return if !(planet.discovery_year_valid? && planet.radius_jpt_valid?)
    @map_year_size[year] = empty_size if @map_year_size[year] == nil
    @map_year_size[year][planet.radius_size] += 1
  end

  def empty_size
    {"small" => 0, "medium" => 0, "large" => 0}
  end

  def parsed_planets_data(planets_data)
    planets = []
    planets_data.each do |planet|
      planets << Planet.new(planet)
    end
    planets
  end
end