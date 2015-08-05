ActiveAdmin.register Cbe::Workproduct do
  menu :parent => "CBE..."

  permit_params :user_id, :assessment_id, :course_section_id, :attempt, :workproduct_url, :grade, :overall_feedback,
      :faculty_it

end
