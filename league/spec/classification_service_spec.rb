module League
  describe "ClassificationService" do
    context "when checking the leader" do
      before(:each) do
        @leader = Team.new('Trilogy B')
        @last = Team.new('Tonel')

        @match_repository = MatchRepository.new
        @match_repository.put(Match.new(@leader, @last, 13, 1))

        @service = ClassificationService.new(@match_repository)
      end

      it "add 3 points per victory" do
        results = @service.classification

        expect(results[0].points).to eq(3)
      end

      it "puts leader the team with more points" do
        results = @service.classification

        expect(results[0].team).to eq(@leader)
        expect(results[1].team).to eq(@last)
      end

      context "when visitor team wins games" do
        before(:each) do
          @match_repository.put(Match.new(@leader, @last, 1, 13))
          @match_repository.put(Match.new(@leader, @last, 1, 13))
        end

        it "puts leader the team with more points" do
          results = @service.classification

          expect(results[0].team).to eq(@last)
        end

        it "add 3 points per victory" do
          results = @service.classification

          expect(results[0].points).to eq(6)
        end
      end
    end
  end
end
