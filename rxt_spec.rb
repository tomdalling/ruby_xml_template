require_relative 'rxt'
require 'time'

RSpec.describe RXT do
  it 'is a template DSL for generating XML' do
    template = RXT::Template.new(<<-'END_TEMPLATE')
      xml version: '1.0', encoding: 'UTF-8'

      weather at: @time.iso8601 do
        description @description
        temperature "#{@temp} C"
        wind do
          velocity "#{@wind_vel} kts"
          direction @wind_direction
        end
      end
    END_TEMPLATE

    input = {
      time: Time.new(2016, 11, 30, 1, 2, 3, '+11:00'),
      description: 'Bright & sunny.',
      temp: 18.3,
      wind_vel: 14,
      wind_direction: 'SSE',
    }

    expected_output = <<~END_OUTPUT
      <?xml version="1.0" encoding="UTF-8"?>
      <weather at="2016-11-30T01:02:03+11:00">
        <description>Bright &amp; sunny.</description>
        <temperature>18.3 C</temperature>
        <wind>
          <velocity>14 kts</velocity>
          <direction>SSE</direction>
        </wind>
      </weather>
    END_OUTPUT

    expect(template.render(input)).to eq(expected_output)
  end
end
