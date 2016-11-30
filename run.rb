require_relative 'rxt'

template = RXT::Template.from_file('weather.rxt')
puts template.render(
  time: Time.now,
  description: 'Bright & sunny.',
  temp: 18.3,
  wind_vel: 14,
  wind_direction: 'SSE',
)
