module My
  class InvitesController < My::BaseController
    def create
      @invite = InvitationMailer.invite(params[:email], params[:full_name], @user).deliver_later
      redirect_to root_path, notice: "Your invite to #{params[:full_name]} (#{params[:email]}) was successfully sent!"
    end
  end
end
