class EmployeesController < ApplicationController
  def index
    # @employees = Employee.all
    @employees = Unirest.get("http://localhost:3000/api/v1/employees").body
    render 'index.html.erb'
  end

  def new
    render 'new.html.erb'
  end

  def create
    @employee = Unirest.post(
      "http://localhost:3000/api/v1/employees",
      parameters: {
        first_name: params[:first_name],
        last_name: params[:last_name],
        email: params[:email],
        birthdate: params[:birthdate]
      }
    ).body
    redirect_to "/employees/#{@employee["id"]}"
  end


  def show
    # @employee = Employee.find_by(id: params[:id])
    @employee = Unirest.get("http://localhost:3000/api/v1/employees/#{params[:id]}").body
    render 'show.html.erb'
  end
end
