class Planet
  attr_accessor :type_flag, :host_star_temp_k, :planet_identifier, :discovery_year, :radius_jpt

  def initialize(planet_data)
    @type_flag = planet_data["TypeFlag"]
    @host_star_temp_k = planet_data["HostStarTempK"]
    @planet_identifier = planet_data["PlanetIdentifier"]
    @discovery_year = planet_data["DiscoveryYear"]
    @radius_jpt = planet_data["RadiusJpt"]
  end

  def orphan?
    @type_flag == 3
  end

  def radius_size
    if @radius_jpt < 1
      "small"
    elsif @radius_jpt < 2
      "medium"
    else
      "large"
    end
  end

  def hotter_than?(current_temperature)
    current_temperature == nil ? true : @host_star_temp_k >= current_temperature
  end

  def host_star_temp_valid?
    @host_star_temp_k != nil && @host_star_temp_k != ""
  end

  def discovery_year_valid?
    @discovery_year != nil && @discovery_year != ""
  end

  def radius_jpt_valid?
    @radius_jpt != nil && @radius_jpt != "" && @radius_jpt > 0
  end
end