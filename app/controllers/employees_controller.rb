class EmployeesController < ApplicationController
  def index
    # @employees = Employee.all
    @employees = Unirest.get(
      "http://localhost:3000/api/v1/employees",
      headers: { 'Authorization' => "Token token=#{ENV['API_KEY']}", 'X-User-Email' => ENV['API_EMAIL'] }
    ).body
    render 'index.html.erb'
  end

  def new
    render 'new.html.erb'
  end

  def create
    @employee = Unirest.post(
      "http://localhost:3000/api/v1/employees",
      headers: { 'Authorization' => "Token token=#{ENV['API_KEY']}", 'X-User-Email' => ENV['API_EMAIL'] },
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
    @employee = Unirest.get(
      "http://localhost:3000/api/v1/employees/#{params[:id]}",
      headers: { 'Authorization' => "Token token=#{ENV['API_KEY']}", 'X-User-Email' => ENV['API_EMAIL'] },
    ).body
    render 'show.html.erb'
  end

  def edit
    @employee = Unirest.get(
      "http://localhost:3000/api/v1/employees/#{params[:id]}",
      headers: { 'Authorization' => "Token token=#{ENV['API_KEY']}", 'X-User-Email' => ENV['API_EMAIL'] },
    ).body
    render 'edit.html.erb'
  end

  def update
    @employee = Unirest.patch(
      "http://localhost:3000/api/v1/employees/#{params[:id]}",
      headers: { 'Authorization' => "Token token=#{ENV['API_KEY']}", 'X-User-Email' => ENV['API_EMAIL'] },
      parameters: {
        firstName: params[:form_first_name],
        last_name: params[:last_name],
        email: params[:email],
        birthdate: params[:birthdate]
      }
    ).body
    redirect_to "/employees/#{@employee['id']}"
  end

  def destroy
    message = Unirest.delete(
      "http://localhost:3000/api/v1/employees/#{params[:id]}",
      headers: { 'Authorization' => "Token token=#{ENV['API_KEY']}", 'X-User-Email' => ENV['API_EMAIL'] }
    ).body
    redirect_to "/employees"
  end
end
