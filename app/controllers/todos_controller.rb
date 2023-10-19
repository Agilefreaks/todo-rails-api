class TodosController < ApplicationController
  def index
    render json: { message: "Test successful" }
  end
end
