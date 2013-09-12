class RegistrationsController < Devise::RegistrationsController
  def update
    @user = User.find(current_user.id)

    successfully_updated = if needs_password?(@user, params)
      @user.update_with_password(params[:user].permit(:name, :email, :password, :password_confirmation, :current_password))
    else
      # remove the virtual current_password attribute update_without_password
      # doesn't know how to ignore it
      params[:user].delete(:current_password)
      @user.update_without_password(params[:user].permit(:name, :email, :password, :password_confirmation, :current_password))
    end

    if successfully_updated
      set_flash_message :notice, :updated

      sign_in @user, :bypass => true
      redirect_to current_user
    else
      render "edit"
    end
  end

  private

  def needs_password?(user, params)
    user.email != params[:user][:email] || params[:user][:password].present?
  end
end