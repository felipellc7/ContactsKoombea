class UsersController < ApplicationController
  skip_before_action :user_authenticated?, only: [:sign_in, :sign_up, :sign_out]

  def sign_in
    auth = AuthenticateUser.call(user_params[:email], user_params[:password])

    if auth.success?
      render json: { auth_token: auth.result }, status: :ok
    else
      render json: { error: auth.errors }, status: :unauthorized
    end
  end

  def sign_up
    @user = User.new(user_params)
    if @user.save
      render json: { user_created: "user created successfully", user: @user }, status: :created
    else
      render json: { error: @user.errors }, status: :unprocessable_entity
    end
  end

  def sign_out
    render json: { sign_out: "ok" }, status: :ok
  end

  def profile
    if @current_user
      render json: { user: @current_user }, status: :ok
    else
      render json: { error: 'Not Authorized' }, status: :unauthorized
    end
  end

  def update_profile
    if @current_user
      if @current_user.update_attributes(user_params)
        render json: { user_updated: "user updated successfully", user: @current_user }, status: :ok
      else
        render json: { error: @current_user.errors }, status: :unprocessable_entity 
      end
    else
      render json: { error: 'Not Authorized' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password
    )
  end
end
