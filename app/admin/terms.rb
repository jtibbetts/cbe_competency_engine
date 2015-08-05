ActiveAdmin.register Cbe::Term do
  menu :parent => "CBE..."

  permit_params :start_date, :end_date, :description
end
