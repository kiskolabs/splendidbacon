class Magic::AccountsController < Magic::BaseController
  def edit
    navigation :account
  end
  
  def new
    navigation :create_admin
    @admin = Admin.new
  end
  
  def create
    @admin = Admin.new(params[:admin])
    if @admin.save
      redirect_to magic_root_path, :notice => "Admin '#{@admin.email}' created."
    else
      render :action => :new
    end
  end
  
  def update
    @admin = current_admin
    if @admin.update_attributes(params[:admin])
      redirect_to magic_root_path, :notice => "Updated your account details."
    else
      render :action => :edit
    end
  end
end
