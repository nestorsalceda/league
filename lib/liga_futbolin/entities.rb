module LigaFutbolin

  Result = Struct.new(:opponent, :result_local, :result_visitor) do
    def local_won?
      result_local > result_visitor
    end
  end

  class Team
    attr_reader :name, :results

    def initialize(name)
      @name = name
      @results = []
    end

    def play(opponent, result_local, result_visitor)
      @results << Result.new(opponent, result_local, result_visitor)
    end
  end
end
