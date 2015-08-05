class OrganizationsController < ApplicationController
  def index
    organizations = Cbe::Organization.all
    render json: to_jsonld(organizations, organizations_url, "Organization")
  end

  def show
    organization = Cbe::Organization.find(params[:id])
    render json: to_jsonld(organization, organization_url, "Organization")
  end
end