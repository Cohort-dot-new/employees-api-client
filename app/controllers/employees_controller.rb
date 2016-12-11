class EmployeesController < ApplicationController
  HEADERS = { 'Authorization' => "Token token=#{ENV['API_KEY']}", 'X-User-Email' => ENV['API_EMAIL'] }

  def index
    # @employees = Employee.all
    @employees = Unirest.get(
      "#{ENV['API_BASE_URL']}/employees",
      headers: HEADERS
    ).body
    render 'index.html.erb'
  end

  def new
    render 'new.html.erb'
  end

  def create
    @employee = Unirest.post(
      "#{ENV['API_BASE_URL']}/employees",
      headers: HEADERS,
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
      "#{ENV['API_BASE_URL']}/employees/#{params[:id]}",
      headers: HEADERS,
    ).body
    render 'show.html.erb'
  end

  def edit
    @employee = Unirest.get(
      "#{ENV['API_BASE_URL']}/employees/#{params[:id]}",
      headers: HEADERS,
    ).body
    render 'edit.html.erb'
  end

  def update
    @employee = Unirest.patch(
      "#{ENV['API_BASE_URL']}/employees/#{params[:id]}",
      headers: HEADERS,
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
      "#{ENV['API_BASE_URL']}/employees/#{params[:id]}",
      headers: HEADERS
    ).body
    redirect_to "/employees"
  end
end
