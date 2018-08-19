class Earch::Rule
  def initialize(rule)
    @rule = rule
  end

  def match?(object)
    @rule.map { |k,v| send(k, parse(v), object )}.all?
  end

  private

  def parse(condition)
    if condition.is_a?(Hash)
      [:type, :match].each do |key|
        raise ArgumentError, "'#{key}' key not found" if condition.send(key).nil?
      end

      return Regexp.new(condition.match) if condition.type == 'regexp'
    end

    condition
  end

  def text(rule, object)
    compare(rule, object.text)
  end

  def user_id(rule, object)
    compare(rule, object.user.id_str)
  end

  def user_name(rule, object)
    compare(rule, object.user)
  end

  def screen_name(rule, object)
    compare(rule, object.screen_name)
  end

  def favorite_count(rule, object)
    compare(rule, object.favorite_count)
  end

  def retweet_count(rule, object)
    compare(rule, object.retweet_count)
  end

  def lang(rule, object)
    compare(rule, object.lang)
  end

  def user_lang(rule, object)
    compare(rule, object.user.lang)
  end

  def source(rule, object)
    compare(rule, object.source.gsub(/<(.+)\">/,"").gsub(/<\/a>/,""))
  end

  def reply(rule, object)
    compare(rule, object.reply?)
  end

  def hashtag(rule, object)
    compare(rule, object.hashtags.map { |h| h.text })
  end

  def mention(rule, object)
    if !rule.nil? && !rule.empty?
      key = rule.first.is_a?(Integer) ? :id : :screen_name
      compare(rule, object.user_mentions.map { |h| h.send(key) })
    end
  end

  def quote(rule, object)
    compare(rule, object.quote?)
  end

  def retweet(rule, object)
    compare(rule, object.retweet?)
  end

  def compare(rule, target)
    case rule
    when Regexp
      rule =~ target
    when Integer
      rule <= target
    when Range
      rule.include?(target)
    when Array
      if target.is_a?(Array)
        !(rule & target).empty?
      else
        rule.include?(target)
      end
    else
      rule == target
    end
  end
end
