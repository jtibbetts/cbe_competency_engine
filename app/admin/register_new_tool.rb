ActiveAdmin.register_page "Register New Tool" do
  menu :label => "Register New Tool", :parent => "LMS..."

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    if params.has_key? "lti_errormsg"
      div :style => "color: red" do
        span params['lti_errormsg']
      end
    end

    method = request.method
    if method == "GET"
      deployment_request = Lti2Tc::DeploymentRequest.new
      deployment_request.save
      session['lti2_tc_deployment_request_id'] = deployment_request.id
      render "register_new_tool"
    else
      deployment_request_id = session['lti2_tc_deployment_request_id']
      deployment_request = Lti2Tc::DeploymentRequest.find(deployment_request_id)
      deployment_request.partner_url = params['registration_url']
      deployment_request.save
      # session.delete 'deployment_request'

      tool_consumer_registry = Rails.application.config.tool_consumer_registry

      html_body = Lti2Tc::ToolRegistration.register_tool current_admin_user, deployment_request,
                          tool_consumer_registry.tool_consumer_profile_wrapper, tool_consumer_registry.tc_deployment_url

      render :inline => html_body

    end

  end # content

end
