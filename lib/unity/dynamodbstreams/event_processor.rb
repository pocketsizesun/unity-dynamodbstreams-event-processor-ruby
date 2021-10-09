# frozen_string_literal: true

require_relative 'event_processor/version'
require 'aws-sdk-dynamodbstreams'

module Unity
  module DynamoDBStreams
    class EventProcessor
      HOOK_TYPES = {
        'INSERT' => :insert,
        'REMOVE' => :remove,
        'MODIFY' => :update
      }.freeze

      def self.table_handlers
        @table_handlers ||= {}
      end

      def initialize(&block)
        @table_handlers = {}
        instance_exec(&block) if block_given?
      end

      def table(table_name, &block)
        @table_handlers[table_name] ||= TableHandler.new
        @table_handlers[table_name].instance_exec(&block)
      end

      def parse(str)
        @event_parser.call(str)
      end

      def process(event)
        event_source_arn_split = event.event_source_arn.split(':', 6)
        table_name = event_source_arn_split[5].split('/').at(1)
        return unless @table_handlers.key?(table_name)

        hook_type = HOOK_TYPES[event.event_name]
        return if hook_type.nil?

        @table_handlers[table_name].each(hook_type) do |handler|
          handler.call(event)
        end

        true
      end

      class TableHandler
        def initialize
          @handlers = { insert: [], remove: [], update: [] }
        end

        def on(type, handler = nil, &block)
          @handlers[type] << handler || block
        end

        def on_insert(handler = nil, &block)
          on(:insert, handler || block)
        end

        def on_remove(handler = nil, &block)
          on(:remove, handler || block)
        end

        def on_update(handler = nil, &block)
          on(:update, handler || block)
        end

        def each(type, &block)
          @handlers[type].each(&block)
        end
      end
    end
  end
end
