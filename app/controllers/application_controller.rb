class ApplicationController < ActionController::API
  before_action :user_authenticated?
  attr_reader :current_user

  private

  def user_authenticated?
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: :unauthorized unless @current_user
  end
end
