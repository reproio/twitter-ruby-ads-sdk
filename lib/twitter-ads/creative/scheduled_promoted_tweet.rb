# frozen_string_literal: true

# Unofficial implemenation for the scheduled_promoted_tweets endpoint.
module TwitterAds
  module Creative

    class ScheduledPromotedTweet

      include TwitterAds::DSL
      include TwitterAds::Resource
      include TwitterAds::Persistence

      attr_reader :account

      property :id, read_only: true
      property :created_at, type: :time, read_only: true
      property :updated_at, type: :time, read_only: true
      property :deleted, type: :bool, read_only: true

      property :line_item_id
      property :scheduled_tweet_id

      RESOURCE_COLLECTION  = "/#{TwitterAds::API_VERSION}/" +
                             'accounts/%{account_id}/scheduled_promoted_tweets'.freeze # @api private
      RESOURCE             = "/#{TwitterAds::API_VERSION}/" +
                             'accounts/%{account_id}/scheduled_promoted_tweets/%{id}'.freeze # @api private

      def initialize(account)
        @account = account
        self
      end

      # Saves or updates the current object instance depending on the presence of `object.id`.
      #
      # @example
      #   object.save
      #
      # @return [self] Returns the instance refreshed from the API.
      #
      def save
        validate

        if @id
          raise TwitterAds::NotFound.new(nil, 'Method PUT not allowed.', 404)
        else
          super
        end
      end

      private

      def validate
        details = []

        unless @line_item_id
          details << { code: 'MISSING_PARAMETER',
                       message: '"line_item_id" is a required parameter',
                       parameter: 'line_item_id' }
        end

        unless @scheduled_tweet_id
          details << { code: 'MISSING_PARAMETER',
                       message: '"tweet_id" is a required parameter',
                       parameter: 'tweet_id' }
        end

        raise TwitterAds::ClientError.new(nil, details, 400) unless details.empty?
      end

    end

  end
end
