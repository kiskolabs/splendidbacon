class Magic::AccountsController < Magic::BaseController
  def edit
    navigation :account
  end
  
  def new
    navigation :create_admin
    @admin = Admin.new
  end
end
