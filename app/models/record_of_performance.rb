class RecordOfPerformance

  def self.record_of_performance_media_type(organization, user)
    result = o_hash.new
    result['@context'] = o_hash.new
    context_prefix = BusinessCenter::Application.config.context_prefix
    # TODO: Remove Not used
    # icon_prefix = BusinessCenter::Application.config.icon_prefix
    result['@context'] = o_hash.new
    result['@context']['RecordOfPerformance'] = context_prefix + 'RecordOfPerformance'
    result['@id'] = '_' + UUID.generate
    result['@type'] = 'RecordOfPerformance'
    result['created_at'] = Time.now.iso8601
    result['content'] = content_hash

    program = derive_program(user)

    content_hash = {
      'organization' => {
        'organization_id' => organization_path(orgainzation.id),
        'legal_name' => organization.legal_name,
        'website' => organization.website
      },
      'user' => {
        'user_id' => user_path(user.id),
        'lis_person_name_family' => user.lis_person_name_family,
        'lis_person_name_given' => user.lis_person_name_given,
        'email' => user.email,
        'sourced_id' => user.external_id
      },
      'program' => {
        'program_id' => program_path(program.id),
        'label' => program.label,
        'degree_level' => program.degree_level,
        'courses' => []
      }
    }

    course_sections = derive_course_sections(program)
    course_sections.each do |course_section|
      course_content_hash = {
          'course_section_id' => course_section_path(course_section.id),
          'label' => course_section.label,
          'title' => course_section.title,
          'competencies' => []
      }
      result['content']['program']['courses'] << course_content_hash

      competencies = derive_competencies(course_section)
      competencies.each do |competency|
        competency_hash = {
            'competency_id' => competency_path(competency.id),
            'label' => competency.label,
            'statement' => competency.statement,
            'achievement' => derive_achievement(competency, course_section, user)
        }
        course_content_hash['competencies'] << competency_hash
      end
    end

    result
  end

end