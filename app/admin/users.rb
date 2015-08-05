ActiveAdmin.register Cbe::User do
  menu :parent => "CBE..."

  permit_params :givenName, :familyName, :name, :email, :external_id

end
