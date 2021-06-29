class EventsController < ApplicationController
  def index
    start_date = params.fetch(:start_time, Date.today).to_date
    #ひと月分だけの表示、この後の為に残しておきます。
    #@events = Event.where(start_time: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week)
    @user = current_user
    @events = Event.where(user_id: @user)
    @event = Event.new
  end
  def new
    @event = Event.new
  end
  def create
    @event = Event.new
    if Event.create!(event_parameter)
      redirect_to user_events_path
    else
      start_date = params.fetch(:start_time, Date.today).to_date
      @user = current_user
      @events = Event.where(user_id: @user)
      @event = Event.new
      render :index
    end
  end
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to user_events_path
  end
  def edit
    @event = Event.find(params[:id])
  end
  def update
    @event = Event.find(params[:id])
    if @event.update(event_parameter)
      redirect_to user_events_path, notice: "栽培予定を編集しました"
    else
      render :edit, notice: "栽培予定の編集に失敗しました"
    end
  end

  private
  def event_parameter
    params.require(:event).permit(:title, :body, :start_time, :user_id)
  end
end