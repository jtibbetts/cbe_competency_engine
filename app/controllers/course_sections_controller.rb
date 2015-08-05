class CourseSectionsController < ApplicationController
  def index
    course_sections = Cbe::CourseSection.all
    render json: to_jsonld(course_sections, users_url, "CourseSection")
  end

  def show
    course_section = Cbe::CourseSection.find(params[:id])
    render json: to_jsonld(course_section, course_section_url, "CourseSection")
  end
end