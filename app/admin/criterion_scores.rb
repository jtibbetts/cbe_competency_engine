ActiveAdmin.register Cbe::CriterionScore do
  menu :parent => "CBE..."

  permit_params :competency_id, :user_id, :course_section_id, :criterion_id, :attempt, :faculty_judgement, :numeric_score,
      :feedback, :timestamp, :faculty_id

end
