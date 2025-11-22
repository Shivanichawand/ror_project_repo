class PublicationsController < ApplicationController
  before_action :authorize_request
  before_action :set_publication, only: [:show, :update, :destroy]

  def index
    render json: current_user.publications, status: :ok
  end

  def show
    render json: @publication, status: :ok
  end

  def create
    pub = current_user.publications.new(pub_params)
    if pub.save
      render json: pub, status: :created
    else
      render json: { errors: pub.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @publication.update(pub_params)
      render json: @publication, status: :ok
    else
      render json: { errors: @publication.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @publication.destroy
    render json: { message: 'Deleted' }, status: :ok
  end

  private

  def set_publication
    @publication = current_user.publications.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { errors: ['Not found'] }, status: :not_found
  end

  def pub_params
    params.require(:publication).permit(:title, :content, :status)
  end
end
