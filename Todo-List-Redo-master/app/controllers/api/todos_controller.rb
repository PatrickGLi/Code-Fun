class Api::TodosController < ApplicationController
  def index
    @todos = Todo.all

    render json: @todos
  end

  def create
    @todo = Todo.create!(todo_params)

    render json: @todo
  end

  def show
    @todo = Todo.find(params[:id])

    render json: @todo
  end

  def update
    @todo = Todo.update!(params[:id], todo_params)

    render json: @todo
  end

  def destroy
    @todo = Todo.destroy!(params[:id])

    render json: @todo
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :body, :done)
  end
end
