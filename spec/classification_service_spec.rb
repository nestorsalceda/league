require_relative '../lib/liga_futbolin'

module LigaFutbolin
  describe "ClassificationService" do
    context "when checking the leader" do
      before(:each) do
        @leader = Team.new('Trilogy B')
        @last = Team.new('Tonel')
        @leader.play(@last, 13, 1)

        @service = ClassificationService.new(@last, @leader)
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
    end
  end
end
