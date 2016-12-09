class EmployeesController < ApplicationController
  def index
    # @employees = Employee.all
    @employees = Unirest.get("http://localhost:3000/api/v1/employees").body
    render 'index.html.erb'
  end

  def show
    # @employee = Employee.find_by(id: params[:id])
    @employee = Unirest.get("http://localhost:3000/api/v1/employees/#{params[:id]}").body
    render 'show.html.erb'
  end
end
