ActiveAdmin.register Cbe::Rubric do
  menu :parent => "CBE..."

  permit_params :criterion_id, :assessment_id, :criterion_position, :criterion_weight

end
