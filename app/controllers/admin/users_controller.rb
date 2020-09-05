module Admin
  class UsersController < Admin::BaseController
    before_action :set_user, only: [:show, :edit, :update, :destroy]

    def index
      @q = User.ransack(params[:q])
      @users = @q.result

      @pagy, @users = pagy(@users)
    end

    def show
    end

    def new
      @user = User.new
      @roles = Role.all
    end

    def edit
      @roles = Role.all
    end

    def create
      @user = User.new(user_params)
      roles = params[:user][:role_ids].reject(&:empty?) if params[:user][:role_ids].present?
      roles&.each do |role|
        role = Role.find(role)
        @user.add_role(role.name)
      end

      respond_to do |format|
        if @user.save
          format.html { redirect_to admin_users_url, notice: 'User was successfully created.' }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render(partial: "shared/partials/errors", locals: { object: @user }, status: :bad_request) }
        end
      end
    end

    def update
      roles = params[:user][:role_ids].reject(&:empty?).map(&:to_i) if params[:user][:role_ids].present?
      remove_roles = @user&.role_ids&.select { |role_id| !roles.include?(role_id) }

      respond_to do |format|
        if @user.update(user_params(params[:user][:password].present?))
          # remove role
          remove_roles&.each do |role|
            role = Role.find(role)
            @user.remove_role(role.name)
          end
          # add role
          roles&.each do |role|
            role = Role.find(role)
            @user.add_role(role.name)
          end
          format.html { redirect_to admin_users_url, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render(partial: "shared/partials/errors", locals: { object: @user }, status: :bad_request) }
        end
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params(password = true)
      if password
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      else
        params.require(:user).permit(:name, :email)
      end
    end
  end
end
