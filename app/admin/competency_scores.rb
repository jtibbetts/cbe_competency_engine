ActiveAdmin.register Cbe::CompetencyScore do
  menu :parent => "CBE..."

  permit_params :competency_id, :course_section_id, :user_id, :label, :final_score, :override_explanation, :computed_score,
      :completion_date, :start_date, :comment

end
