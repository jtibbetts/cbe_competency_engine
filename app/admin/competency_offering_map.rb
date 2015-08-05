ActiveAdmin.register Cbe::CompetencyOfferingMap do
  menu :parent => "CBE..."

  permit_params :course_offering_id, :competency_id, :sequence_number

end
