# frozen_string_literal: true

class KarafkaApp < Karafka::App
  setup do |config|
    config.kafka = { 'bootstrap.servers': '127.0.0.1:9092' }
    config.client_id = 'actioncable_poc'
  end

  # Comment out this part if you are not using instrumentation and/or you are not
  # interested in logging events for certain environments. Since instrumentation
  # notifications add extra boilerplate, if you want to achieve max performance,
  # listen to only what you really need for given environment.
  Karafka.monitor.subscribe(Karafka::Instrumentation::LoggerListener.new)
  # Karafka.monitor.subscribe(Karafka::Instrumentation::ProctitleListener.new)

  # This logger prints the producer development info using the Karafka logger.
  # It is similar to the consumer logger listener but producer oriented.
  Karafka.producer.monitor.subscribe(
    WaterDrop::Instrumentation::LoggerListener.new(Karafka.logger)
  )

  consumer_groups.draw do
    consumer_group :batched_group do
      topic :books do
        config(partitions: 1)
        consumer BooksConsumer
      end
    end
  end
=begin
  routes.draw do
    active_job_topic :default do
      # Expire jobs after 1 day
      config(partitions: 5, 'retention.ms': 86_400_000)
    end

    topic :books do
      # Uncomment this if you want Karafka to manage your topics configuration
      # Managing topics configuration via routing will allow you to ensure config consistency
      # across multiple environments
      #
      # config(partitions: 2, 'cleanup.policy': 'compact')
      consumer BooksConsumer
    end
  end
=end
end

Karafka::Web.enable!