class FrontApi::V1::Auction::StandardsController < FrontApi::BaseController
  before_action do
    self.class.serialization_scope :current_front_api_v1_user
  end

  def create
    result = Auctions::Standard::Create.new(auction_params, current_front_api_v1_user).execute
    result.success { |auction| render json: auction, status: :created }
    result.locked { |errors| render json: errors, status: :locked }
    result.invalid { |errors| render json: errors, status: :unprocessable_entity }
    result.invalid_api { |errors| render json: errors, status: :service_unavailable }
  end

  def index
    result = Auctions::Standard::Index.new(search_params, current_front_api_v1_user).auction_list_objects
    result.success { |auction_list_objects| render json: auction_list_objects, status: :ok }
  end

  def show
    result = Auctions::Standard::Show.new(params, current_front_api_v1_user).call
    result.success { |auction| render json: auction, status: :ok }
    result.not_found { |errors| render json: errors, status: :not_found }
    result.not_allowed { |errors| render json: errors, status: :forbidden }
  end

  def update
    result = Auctions::Standard::Update.new(auction_params, current_front_api_v1_user).call
    result.success { |auction| render json: auction, status: :ok }
    result.locked { |errors| render json: errors, status: :locked }
    result.unauthorized { |errors| render json: errors, status: :unauthorized }
    result.not_found { |errors| render json: errors, status: :not_found }
    result.not_allowed { |errors| render json: errors, status: :forbidden }
    result.invalid { |errors| render json: errors, status: :unprocessable_entity }
  end

  def renew
    result = Auctions::Standard::Renew.new(auction_params, current_front_api_v1_user).call
    result.success { render json: {}, status: :ok }
    result.not_found { |errors| render json: errors, status: :not_found }
    result.invalid_duration { |errors| render json: errors, status: :unprocessable_entity }
    result.not_published { |errors| render json: errors, status: :forbidden }
    result.unauthorized { |errors| render json: errors, status: :unauthorized }
    result.locked { |errors| render json: errors, status: :locked }
    result.invalid_api { |errors| render json: errors, status: :service_unavailable }
  end

  def archive
    result = Auctions::Standard::Archive.new(auction_params, current_front_api_v1_user).call
    result.success { |auction| render json: auction, status: :ok }
    result.unauthorized { |errors| render json: errors, status: :unauthorized }
    result.not_found { |errors| render json: errors, status: :not_found }
    result.not_allowed { |errors| render json: errors, status: :forbidden }
    result.invalid { |errors| render json: errors, status: :unprocessable_entity }
  end

  private

  def search_params
    params.permit(:query, :category)
  end

  def auction_params
    params.permit(:id, :status)
  end
end
