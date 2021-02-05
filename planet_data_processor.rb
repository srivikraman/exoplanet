require './planet_analyzer'
require 'net/http'
require 'json'
uri = URI('https://gist.githubusercontent.com/joelbirchler/66cf8045fcbb6515557347c05d789b4a/raw/9a196385b44d4288431eef74896c0512bad3defe/exoplanets')
response = Net::HTTP.get_response(uri)
if response.code == "200"
  parsed_data = JSON.parse(response.body)
  planet_analyzer = PlanetAnalyzer.new(parsed_data)
  planet_analyzer.analyze
  planet_analyzer.print_result
else
  p "Error fetching data, reponse code: #{response.code}"
end