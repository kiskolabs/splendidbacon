class Magic::UsersController < Magic::BaseController
  def index
    @users = User.real.paginate :page => params[:page], :per_page => 50
  end
  
  def show
    @user = User.find(params[:id])
  end
end
