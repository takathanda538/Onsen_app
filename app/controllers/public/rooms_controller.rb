class Public::RoomsController < ApplicationController

  before_action :authenticate_customer!

  def create
    @room = Room.create
    @current_entry = Entry.create(customer_id: current_customer.id, room_id: @room.id)
    @another_entry = Entry.create(join_room_params)
    redirect_to room_path(@room.id)
  end

  def index
    # ログインユーザー所属ルームID取得
    current_entries = current_customer.entries
    my_room_id = []
    current_entries.each do |entry|
      my_room_id << entry.room.id
    end
    # 自分のroom_idでuser_idが自分じゃないのを取得
    @another_entries = Entry.where(room_id: my_room_id).where.not(customer_id: current_customer.id)
    @rooms = current_customer.rooms.includes(:messages).order("messages.created_at desc")
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(customer_id: current_customer.id, room_id: @room.id).present?
      @messages = @room.messages.includes(:customer).order("created_at desc")
      @message = Message.new
      @entries = @room.entries
    else
      redirect_back(fallback_location: root_path)
    end
  end

  private

   def join_room_params
     params.require(:entry).permit(:customer_id, :room_id).merge(room_id: @room.id)
   end

end
