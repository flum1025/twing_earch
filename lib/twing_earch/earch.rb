require 'twing/modules/base'

class Earch < Twing::Modules::Base
  require 'twing_earch/notify'
  require 'twing_earch/rules'

  attr_reader :notify, :rules

  def initialize(*args)
    p 1
    super
    @notify = Notify.new(setting.slack)
    @rules = Rules.new(setting.rules || {})
  end

  def on_message(object)
    case object
    when Twitter::Tweet
      logger.debug("Tweet #{object.id}")
      execute(object)
    end
  end

  private

  def execute(object)
    notify.notify(object) if rules.match?(object)
  end
end
