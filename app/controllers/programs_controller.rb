class ProgramsController < ApplicationController
  def index
    programs = Cbe::Program.all
    render json: to_jsonld(programs, programs_url, "Program")
  end

  def show
    program = Cbe::Program.find(params[:id])
    render json: to_jsonld(program, program_url, "Program")
  end
end