def yield_once
  yield
end

def yield_many_times(x)
  0.upto(x.to_i-1) do
    yield
  end
end

# yield_once { puts "TEST"}

# # yield_many_times(5) { puts "Test"}

('a'..'z').each do |n|
  puts "#{n}!"
end

