Ruby XML Template (RXT) DSL
---------------------------

This repo contains code to accompany the article: [How To Make A DSL, Hygienically](http://www.rubypigeon.com/posts/how-to-make-a-dsl-hygienically/)

RXT is Ruby DSL for XML templates.
It turns this:

    xml version: '1.0', encoding: 'UTF-8'

    weather at: @time.iso8601 do
      description @description
      temperature "#{@temp} C"
      wind do
        velocity "#{@wind_vel} kts"
        direction @wind_direction
      end
    end

Into this:

    <?xml version="1.0" encoding="UTF-8"?>
    <weather at="2016-11-29T22:54:15+11:00">
      <description>Bright &amp; sunny.</description>
      <temperature>18.3 C</temperature>
      <wind>
        <velocity>14 kts</velocity>
        <direction>SSE</direction>
      </wind>
    </weather>


Running The Code
----------------

First install the dependencies:

    bundle install

Then you can run the DSL with:

    bundle exec ruby run.rb

Or run the tests with

    bundle exec rspec rxt_spec.rb


