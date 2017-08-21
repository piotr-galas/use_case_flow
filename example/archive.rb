# frozen_string_literal: true

require use_case_flow

module Auctions
  module Standard
    class Archive
      def initialize(params, user)
        @params = params
        @user = user
      end

      def call
        return Failure.new(:not_found, errors: :not_found) if auction.nil?
        return Failure.new(:unauthorized, errors: :not_authorized) unless authorized?
        return Failure.new(:not_allowed, errors: :it_is_not_published_auction) unless auction.published?
        archive_auction
        Success.new(auction)
      end

      private

      def authorized?
        auction.user == @user && @user.verified_success?
      end

      def auction
        @auction ||= Auction.find_by(id: @params[:id])
      end

      def archive_auction
        if auction.update(status: :archived)
          auction.proposals.pending.each do |proposal|
            Account::Proposals::Update.new({ id: proposal.id, update_action: 'end_auction' }, auction.user).execute
          end
        end
      end
    end
  end
end