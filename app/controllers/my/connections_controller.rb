module My
  class ConnectionsController < My::BaseController
    before_action :prepare_friend, only: [:create, :accept, :reject, :destroy]

    def index
      @user = UserDecorator.new(@user)
      @friends = current_user.friends.map { |u| UserDecorator.new(u) }
      @requests = current_user.pending_friends.map { |p| UserDecorator.new(p) }
    end

    def create
      @connection = current_user.connections.build(friend: @friend)
      if @connection.save
        redirect_to :back, notice: 'Connection has been requested'
      else
        redirect_to :back, alert: 'Connection already requested.'
      end
    end

    def accept
      connection = Connection.find_by(friend_id: current_user.id, user_id: @friend.id)
      if connection.pending?
        connection.accept!
        redirect_to my_connections_path, notice: 'Connection accepted.'
      else
        redirect_to my_connections_path, alert: 'Connection is already accepted.'
      end
    end

    def reject
      connection = Connection.find_by(friend_id: current_user.id, user_id: @friend.id)
      if connection.pending?
        connection.reject!
        redirect_to my_connections_path, notice: 'Connection rejected.'
      else
        redirect_to my_connections_path, alert: 'Connection is already rejected.'
      end
    end

    def destroy
      @connection = current_user.connections.accepted.find_by(friend: @friend) ||
                    current_user.passive_connections.accepted.find_by(user: @friend)
      if @connection&.destroy
        redirect_to my_connections_path, notice: 'Connection Removed'
      else
        redirect_to my_connections_path, alert: 'Connection is already disconnected.'
      end
    end

    private

    def prepare_friend
      @friend = User.find(params[:id])
    end

  end
end
