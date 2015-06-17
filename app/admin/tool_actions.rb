ActiveAdmin.register_page 'Tool Actions' do

  menu :label => 'Tool Actions', :parent => 'LMS...'

  content :title => proc{ I18n.t('active_admin.dashboard') } do

    if params.has_key? 'lti_errormsg'
      div :style => "color: red" do
        span params['lti_errormsg']
      end
    end

    method = params['method']
    tool_id = params['tool_id']

    tool = Lti2Tc::Tool.find(tool_id) unless tool_id.nil?

    if method == 'toggle'
      tool = Lti2Tc::Tool.find( tool_id )
      toggle = params['toggle']
      if toggle
        tool.is_enabled = toggle == 'true'
        tool.save
      end
    elsif method == 'reregister'
      tool = Lti2Tc::Tool.find(tool_id) unless tool_id.nil?

      tool_consumer_registry = Rails.application.config.tool_consumer_registry

      deployment_request = Lti2Tc::DeploymentRequest.where(:reg_key => tool.key).first
      deployment_request.reg_key = tool.key
      deployment_request.save
      tool.registration_return_url = "#{tool_consumer_registry.tc_deployment_url}/admin/tool_actions"
      tool.save
      tool_consumer_profile = Lti2Tc::ToolConsumerProfile.new
      tool_consumer_profile_wrapper = tool_consumer_registry.tool_consumer_profile_wrapper
      tc_deployment_url = tool_consumer_registry.tc_deployment_url
      html_body = Lti2Tc::ToolRegistration::reregister_tool current_admin_user, deployment_request,
                      tool, tool_consumer_profile, tool_consumer_profile_wrapper, tc_deployment_url,
                      "#{tc_deployment_url}/admin/tool_actions"
      render :inline => html_body
    end

    tools = Lti2Tc::Tool.order("product_name").all
    tools.each do |tool|
      if tool.is_enabled
       tool.toggle_label = 'YES [disable now]'
      else
       tool.toggle_label = 'NO [enable now]'
      end
      if tool.status != 'reregistering'
       tool.new_tool_proxy_url = 'NO'
      else
       # deployment_request = Lti2Tc::DeploymentRequest.find(tool.new_deployment_request_id)
       tool.new_tool_proxy_url = "<a href=\"/lti2_tc/reregister_continue?tool_id=#{tool.id}\">ACCEPT NOW</a>"
      end
    end
    request['tools'] = tools

    render "tool_actions"

  end # content
end
