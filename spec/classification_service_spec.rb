require_relative '../lib/liga_futbolin'

module LigaFutbolin
  describe "ClassificationService" do
    it "puts leader the team with more victories" do
      leader = Team.new('Trilogy B')
      last = Team.new('Tonel')

      leader.play(last, 13, 1)

      service = ClassificationService.new(last, leader)

      results = service.classification

      expect(results[0].team).to eq(leader)
      expect(results[1].team).to eq(last)
    end
  end
end
