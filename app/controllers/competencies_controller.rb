class CompetenciesController < ApplicationController
  def index
    competencies = Cbe::Competency.all
    render json: to_jsonld(competencies, competencies_path, "Competency")
  end

  def show
    competency = Cbe::Competency.find(params[:id])
    render json: to_jsonld(competency, competency_path, "Competency")
  end
end