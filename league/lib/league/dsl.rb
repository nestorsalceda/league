module League
  class CompetitionBuilder
    attr_reader :competition

    def initialize(competition)
      @competition = competition
    end

    def self.build(name, &block)
      builder = CompetitionBuilder.new(Competition.new(name))
      builder.instance_eval &block
      builder.competition
    end

    def group(name, &block)
      group = Group.new(name)
      teams = yield

      teams.each do |team|
        group.add_team(team)
        name = team.gsub(' ', '_').downcase
        define_singleton_method(name.to_sym) do
          team
        end
      end

      @competition.add_group(group)
    end

    def journey(date, &block)
      @journey = Journey.new(date)
      @competition.add_journey(@journey)

      instance_eval &block
    end

    def match(local, visitor, &block)
      match = Match.new(local, visitor)
      @journey.add_match(match)

      if block_given?
        match.instance_eval(&block)
      end
    end
  end
end
