class UserController < ApplicationController
	load_and_authorize_resource

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Successfully created User." 
      redirect_to root_path
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

def update
  if params[:user][:password].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
          sign_in @user, :bypass => true
          format.html { redirect_to user_path, notice: 'user was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
end
def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "Successfully deleted User."
      redirect_to root_path
    end
end 

  # check if we need password to update user data
  # ie if password or email was changed
  # extend this as needed
def needs_password?(user, params)
  user.email != params[:user][:email] ||
    params[:user][:password].present? ||
    params[:user][:password_confirmation].present?
end

  private 
    def user_params
      params.require(:user).permit(:username, :first_name, :last_name,:email, :password, :password_confirmation,:current_password, roles: [])
     end
end

