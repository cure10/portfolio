class EventsController < ApplicationController
  def index
    @events = Event.all
    @event = Event.new
  end

  def new
    @event = Event.new
  end

  def show
    @event = Event.find(params[:user_id])
  end

  def create
    Event.create(event_parameter)
    redirect_to user_events_path
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to blogs_path, notice:"削除しました"
  end

  def edit
    @event = Event.find(params[:user_id])
  end

  def update
    @event = Event.find(params[:user_id])
    if @event.update(event_parameter)
      redirect_to user_events_path, notice: "編集しました"
    else
      render 'edit'
    end
  end

  private

  def event_parameter
    params.require(:event).permit(:title, :body, :start, :user_id)
  end

end