require 'twing_earch/rule'

class Earch
  class Rules
    attr_reader :rules

    def initialize(rules)
      @rules = rules.map { |rule| Rule.new(rule) }
    end

    def match?(object)
      rules.find { |rule| rule.match?(object) }
    end
  end
end
