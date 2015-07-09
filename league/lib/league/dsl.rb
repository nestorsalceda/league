module League
  class CompetitionBuilder
    attr_reader :competition

    def initialize(competition)
      @competition = competition
    end

    def self.build(name, &block)
      builder = CompetitionBuilder.new(Competition.new(name: name))
      builder.instance_eval &block
      builder.competition
    end

    def group(name, &block)
      @group = Group.new(name: name)
      @competition.add_group(@group)

      instance_eval &block
    end

    def team(name, location, hour, day, &block)
      team = Team.new(name: name, location: location, hour: hour, day: day)
      @group.add_team(team)
      define_singleton_method(team.to_sym) do
        team
      end
    end

    def journey(date, &block)
      @journey = Journey.new(date: Date.parse(date))
      @competition.add_journey(@journey)

      instance_eval &block
    end

    def match(local, visitor, &block)
      match = Match.new(local: local, visitor: visitor)
      @journey.add_match(match)

      if block_given?
        match.instance_eval(&block)
      end
    end
  end
end
