League::CompetitionBuilder.build('Copa LAF 2015') do
  group "A" do
    team("Topos B", "", "", "", "")
    team("Tonel", "", "", "", "")
    team("Trilogy A", "41.644023,-0.896292", "639021358", "20:00", "Viernes")
  end

  group "B" do
     team("Migas", "", "", "", "")
     team("Topos A", "", "", "", "")
     team("Trilogy B", "41.644023,-0.896292", "639021358", "22:00", "Sábado")
  end

  journey "9/5/2015" do
    match(topos_b, tonel)
    match(trilogy_b, migas) { result(6, 13) }
  end

  journey "16/5/2015" do
    match(tonel, trilogy_a)
    match(topos_a, trilogy_b) { result(13, 4) }
  end

  journey "23/5/2015" do
    match(trilogy_a, topos_b) { result(13, 12) }
    match(migas, topos_a) { result(13, 9) }
  end

  journey "6/6/2015" do
    match(migas, topos_b) { result(10, 13) }
    match(trilogy_a, topos_a) { result(13, 6) }
  end

  journey "13/6/2015" do
    match(trilogy_a, topos_b) { result(9, 13) }
  end
end
