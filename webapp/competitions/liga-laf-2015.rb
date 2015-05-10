require 'league/dsl'

l = League::Competition.new('Liga LAF 2015') do |c|
  teams do
    ["Trilogy A", "Topos A", "Tonel", "Trilogy B", "Topos B", "El rolladero"]
  end

  journey "2/2/2015" do
    match(trilogy_a, topos_a) { result 13, 5 }
    match(tonel, trilogy_b)
    match(topos_b, el_rolladero) { result 9, 13 }
  end

  journey "9/2/2015" do
    match(trilogy_a, topos_a) { result 1, 13}
    match(tonel, trilogy_b)
    match(topos_b, el_rolladero)
  end
end

puts "Nombre: ", l.name
puts "Equipos: ", l.teams

puts "Resultados:"
l.journeys.each do |journey|
  puts
  puts journey.date
  puts "--------------------"
  journey.matches.each do |match|
    puts "#{match.local_team}: #{match.local_result} \t| #{match.visitor_team}: #{match.visitor_result}"
  end
end
