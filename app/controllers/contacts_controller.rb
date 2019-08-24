class ContactsController < ApplicationController
  before_action :user_authenticated?
  before_action :current_contact, only: [:show, :update, :destroy]

  def index
    if @current_user
      render json: { contacts: @current_user.contacts }, status: :ok
    else
      render json: { error: 'Not Authorized' }, status: :unauthorized
    end
  end

  def show
    if @contact
      render json: { contact: @contact }, status: :ok
    else
      render json: { not_found: "contact not found" }, status: :not_found
    end
  end

  def create
    if @current_user
      @contact = Contact.new(contacts_params)
      @contact.user = @current_user
      if @contact.save
        render json: { contact_created: "contact created successfully", user: @contact }, status: :created
      else
        render json: { error: @contact.errors }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Not Authorized' }, status: :unauthorized
    end
  end

  def update
    if @contact
      if @contact.update_attributes(contacts_params)
        render json: { contact_updated: "contact updated successfully", contact: @contact }, status: :ok
      else
        render json: { error: @contact.errors }, status: :unprocessable_entity  
      end
    else
      render json: { not_found: "contact not found" }, status: :not_found
    end
  end

  def destroy
    if @contact
      if @contact.destroy
        render json: { contact_deleted: "contact was deleted successfully" }, status: :ok
      else
        render json: { error: @contact.errors }, status: :unprocessable_entity  
      end
    else
      render json: { not_found: "contact not found" }, status: :not_found
    end
  end

  private

  def contacts_params
    params.require(:contact).permit(
      :name,
      :email,
      :phone
    )
  end

  def current_contact
    @contact = @current_user.contacts.find_by_id params[:id]
  end

end
