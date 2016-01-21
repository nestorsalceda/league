League::CompetitionBuilder.build('Segunda División') do
  group "D" do
    team("Trilogy", "", "21:00", "Viernes")
    team("Rolladero", "", "20:00", "Sabado")
    team("Alambique de la Sabina", "", "18:00", "Viernes")
    team("Atrio", "", "18:00", "Sabado")
  end

  journey "5/12/2015" do
    match(trilogy, rolladero) { result(13, 10) }
    match(alambique_de_la_sabina, atrio) { result(10, 13) }
  end

  journey "12/12/2015" do
    match(alambique_de_la_sabina, rolladero) { result(13, 12) }
    match(trilogy, atrio) { result(13, 2) }
  end

  journey "19/12/2015" do
    match(alambique_de_la_sabina, trilogy) { result(10, 13) }
    match(atrio, rolladero) { result(8, 13) }
  end

  journey "16/1/2016" do
    match(atrio, alambique_de_la_sabina)
    match(rolladero, trilogy)
  end

  journey "23/1/2016" do
    match(rolladero, alambique_de_la_sabina)
    match(atrio, trilogy)
  end

  journey "30/1/2016" do
    match(trilogy, alambique_de_la_sabina)
    match(rolladero, atrio)
  end
end
