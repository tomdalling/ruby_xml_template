require_relative 'rxt'

rxt_path = File.join(File.dirname(__FILE__), 'weather.rxt')
template = RXT::Template.from_file(rxt_path)
puts template.render(
  time: Time.now,
  description: 'Bright & sunny.',
  temp: 18.3,
  wind_vel: 14,
  wind_direction: 'SSE',
)
