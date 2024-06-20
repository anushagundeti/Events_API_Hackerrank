class EventsController < ApplicationController

  before_action :set_repo, only: [:create, :index_by_repo, :show_by_repo]

  def create
    event = @repo.events.new(event_params)

    if event.save
      render json: { status: 'success', event: event }, status: :created
    else
      render json: { status: 'error', errors: event.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    events = Event.all
    render json: events
  end

  def index_by_repo
    events = @repo.events
    render json: events
  end

  def show
    event = Event.find(params[:id])

    if event
      render json: event
    else
      render json: { status: 'error', message: 'Event not found' }, status: :not_found
    end
  end

  def show_by_repo
    event = @repo.events.find_by(id: params[:id])
    
    if event
      render json: event
    else
      render json: { status: 'error', message: 'Event not found' }, status: :not_found
    end
  end

  private

  def set_repo
    @repo = Repo.find(params[:repo_id])
  end

  def event_params
    params.require(:event).permit(:event_type, :public, :repo_id, :actor_id)
  end
end