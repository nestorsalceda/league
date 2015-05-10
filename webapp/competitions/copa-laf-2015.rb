League::CompetitionBuilder.build('Copa LAF 2015') do
  group "A" do
    ["Topos B", "Tonel" , "Trilogy A"]
  end

  group "B" do
    ["Migas", "Topos A" , "Trilogy B"]
  end

  journey "9/5/2015" do
    match(topos_b, tonel)
    match(trilogy_b, migas)
  end

  journey "16/5/2015" do
    match(tonel, trilogy_a)
    match(topos_a, trilogy_b)
  end

  journey "23/5/2015" do
    match(trilogy_a, topos_b)
    match(migas, topos_a)
  end

  journey "29/5/2015" do
#    title "Semifinales"
  end

  journey "5/6/2015" do
#    title "Comida de amistad + final"
  end
end
