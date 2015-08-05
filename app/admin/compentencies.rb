ActiveAdmin.register Cbe::Competency do
  menu :parent => "CBE..."

  permit_params :parent_competency_id, :statement, :label, :title, :reference_hierarchy_level, :aggregate, :display,
      :calculation_method, :sequence_number

end
