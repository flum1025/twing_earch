require 'twing_earch/version'
require 'twing_earch/earch'

Twing.on_init do |app|
  app.cli.initializer.add(:earch, '--earch', 'start earch') do
    app.receivers.add(Earch)
  end
end
