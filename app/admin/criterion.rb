ActiveAdmin.register Cbe::Criterion, as: "Cbe Criteria" do
  menu :parent => "CBE..."

  permit_params :competency_id, :rubric_id, :criterion, :weight, :criterion_text, :criterion_weight
end
