require 'main'
require 'benchmark'
loop do
  realtime = Benchmark.realtime do
    Animal.all.each do |animal|
      animal.step
      animal.save
    end
  end
  sleep_time = 0.2 - realtime
  if sleep_time > 0
    sleep sleep_time
  end
end
