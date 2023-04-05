class AuthorsController < ApplicationController
  before_action :authenticate_request

  def index
    @authors = Author.all
    render json: @authors, status: :ok
  end

  def show
    render json: @author, status: :ok
  end

  def create
    @author = Author.new(author_params)
    if @author.save
      render json: @author, status: :created
    else
      render json: { errors: @author.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    unless @author.update(author_params)
      render json: { errors: @author.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def destroy
    @author.destroy
  end

  private
  def author_params
    params.permit(:firstname, :lastname , :email)
  end

  def set_author
    @author = Author.find(params[:id])
  end


end
