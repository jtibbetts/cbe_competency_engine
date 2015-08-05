module Jsonldable
  extend ActiveSupport::Concern

  def hydra_link_header
    "<#{@hydra_link_url}>; rel=\"http://www.w3.org/ns/hydra/core#apiDocumentation\""
  end

  def to_jsonld(obj, path, context_name)
    registry = Rails.application.config.tool_consumer_registry.registry
    @purl_base_url = registry['purl_base_url']
    @tc_deployment_url = registry['tc_deployment_url']
    @hydra_link_url = registry['hydra_link_url']

    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Link'] = hydra_link_header
    json_obj = obj.as_json
    # context = "#{@purl_base_url}/ctx/cbe/v1/#{context_name}"
    context = 'http://purl.kinexis.com:8888/ctx/cbe/v1/cbe'
    if json_obj.kind_of?(Array)
      result = {}
      result['@id'] = "#{@tc_deployment_url}#{path}"
      # result['@context'] = context
      result['@graph'] = []
      json_array = json_obj
      json_array.each do |json_obj|
        result['@graph'] << decorate(json_obj, path, context, json_obj['id'])
      end
      result
    else
      result = decorate(json_obj, path, context)
    end

    result_formatted = JSON.pretty_generate(result)
    result_formatted
  end

  private

  def decorate(hash, path, context, id=nil)
    new_hash = {}
    new_hash['@id'] = "#{@tc_deployment_url}#{path}"
    new_hash['@context'] = context
    new_hash = new_hash.merge(hash)
    new_hash.delete('id')
    if id.present?
      new_hash['@id'] += "/#{id}"
    end
    new_hash
  end
end