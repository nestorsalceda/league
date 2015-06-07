module League
  describe "ClassificationService" do
    let(:a_team) { 'Irrelevant Team' }
    let(:other_team) { 'Other Team' }
    let(:teams) { [a_team, other_team] }

    before(:each) do
        @service = ClassificationService.new
    end

    it "has same length that teams playing" do
        classification = @service.calculate_classification(teams, [])

        expect(classification.length).to eq(teams.length)
    end

    context "when counting points" do
      it "adds 3 points for victory" do
        matches = [Match.new(a_team, other_team, 13, 1)]

        classification = @service.calculate_classification(teams, matches)

        expect(classification[0].team).to eq(a_team)
        expect(classification[0].points).to eq(3)
      end

      context "when visitor wins" do
        it "adds 3 points for victory" do
          matches = [Match.new(other_team, a_team, 1, 13)]

          classification = @service.calculate_classification(teams, matches)

          expect(classification[0].team).to eq(a_team)
          expect(classification[0].points).to eq(3)
        end
      end

      context "when a match has not been played" do
        it "keeps classification as is" do
          matches = [Match.new(a_team, other_team,)]

          classification = @service.calculate_classification(teams, matches)

          expect(classification[0].points).to eq(0)
          expect(classification[1].points).to eq(0)
        end
      end
    end

    context 'when ordering result' do
      it "orders by points first" do
        matches = [Match.new(other_team, a_team, 13, 1)]

        classification = @service.calculate_classification(teams, matches)

        expect(classification[0].team).to eq(other_team)
        expect(classification[1].team).to eq(a_team)
      end

      it "orders by played games" do
        team_without_games = "team without games"
        teams = [a_team, other_team, team_without_games]
        matches = [Match.new(a_team, other_team, 13, 1)]

        classification = @service.calculate_classification(teams, matches)

        expect(classification[0].team).to eq(a_team)
        expect(classification[1].team).to eq(other_team)
        expect(classification[2].team).to eq(team_without_games)
      end
    end

    context "when counting played games" do
      before(:each) do
        matches = [Match.new(other_team, a_team, 13, 1)]
        @classification = @service.calculate_classification(teams, matches)
      end

      it "increases played games for local team" do
        expect(@classification[0].played_games).to eq(1)
      end

      it "increases played games for visitor team" do
        expect(@classification[1].played_games).to eq(1)
      end
    end

    context "when counting score" do
      before(:each) do
        matches = [Match.new(other_team, a_team, 13, 1)]
        @classification = @service.calculate_classification(teams, matches)
      end

      it "adds scored results to local team" do
        expect(@classification[0].scored).to eq(13)
      end

      it "adds against results to local team" do
        expect(@classification[0].against).to eq(1)
      end

      it "adds scored results to visitor team" do
        expect(@classification[1].scored).to eq(1)
      end

      it "adds against results to visitor team" do
        expect(@classification[1].against).to eq(13)
      end
    end

    it "counts won games" do
      matches = [Match.new(other_team, a_team, 13, 1)]

      classification = @service.calculate_classification(teams, matches)

      expect(classification[0].won_games).to eq(1)
    end
  end
end

