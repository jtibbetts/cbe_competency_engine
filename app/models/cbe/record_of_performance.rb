module Cbe
  class UriGenerator
    def initialize(init_base_uri)
      @base_uri = init_base_uri
      @root_uri = "#{@base_uri}/#{UUID.generate}"
    end

    def root_uri
      @root_uri
    end

    def compute_uri(path_array)
      final_uri = @root_uri
      while path_array.length > 0
        case path_array.length
          when 1
            final_uri += "/#{path_array.shift}"
          when 2
            final_uri += "/#{path_array.shift}/#{path_array.shift.to_s}"
        end
      end
      final_uri
    end
  end

  class RecordOfPerformance

    def self.record_of_performance_media_type(tcp_wrapper, base_uri, organization, user)
      uri_generator = UriGenerator.new(base_uri)
      result = ActiveSupport::OrderedHash.new
      context = {}
      result['@context'] = context
      context['@vocab'] = 'http://purl.kinexis.com:8888/ctx/cbe/v1/record_of_performance/'
      context['schema'] = 'http://schema.org/'
      result['@id'] = uri_generator.root_uri
      result['@type'] = 'RecordOfPerformance'

      result['created_at'] = Time.now.iso8601

      result['tool_consumer_profile'] = {
        '@id' => tcp_wrapper.root['@id'],
        'lti_version' => tcp_wrapper.first_at('lti_version'),
        'product_name' => tcp_wrapper.first_at('product_instance.product_info.product_name.default_value'),
        'service_provider_name' => tcp_wrapper.first_at('product_instance.service_provider.service_provider_name.default_value')
      }

      result['user'] = {
          '@id' => uri_generator.compute_uri(['user', user.id]),
          'schema:familyName' => user.familyName,
          'schema:givenName' => user.givenName,
          'email' => user.email,
          'sourced_id' => user.external_id
      }

      result['organization'] = {
          '@id' => uri_generator.compute_uri(['organization', organization.id]),
          'legal_name' => organization.legal_name,
          'schema:url' => organization.website
      }

      program = derive_program(user)

      result['program'] = {
          '@id' => uri_generator.compute_uri(['program', program.id]),
          'schema:alternateName' => program.label,
          'schema:name' => program.degree_level,
          'courses' => []
      }


      terms = derive_terms(user)
      terms.each do |term|
        course_sections = derive_course_sections(user, term)
        course_sections.each do |course_section|
          course_content_hash = {
              '@id' => uri_generator.compute_uri(['course_section', course_section.id]),
              'schema:alternateName' => course_section.label,
              'title' => course_section.title,
              'competencies' => []
          }
          result['program']['courses'] << course_content_hash

          competencies = derive_competencies(course_section)
          competencies.each do |competency|
            competency_hash = {
                '@id' => uri_generator.compute_uri(['competency', competency.id]),
                'label' => competency.label,
                'statement' => competency.statement,
                'achievement' => derive_achievement(competency, course_section, user).label
            }
            course_content_hash['competencies'] << competency_hash
          end
        end

      end

      JSON.pretty_generate(result)
    end

    private

    def self.derive_achievement(competency, course_section, user)
      competency_score = Cbe::CompetencyScore.where(competency_id: competency.id, course_section_id: course_section.id, user_id: user.id).first
      Cbe::AchievementLevel.order(start_of_range: :desc).where("start_of_range <= #{competency_score.final_score}").first
    end

    def self.derive_competencies(course_section)
      competency_ids = Cbe::CompetencyOfferingMap.where(course_offering_id: course_section.course_offering.id).pluck(:competency_id)
      Cbe::Competency.where('id in (?)', competency_ids)
    end

    def self.derive_course_sections(user, term)
      course_section_ids = Cbe::CourseSectionMember.where(user_id: user.id).pluck(:course_section_id)
      course_sections = Cbe::CourseSection.where('id in (?)', course_section_ids)
      course_sections.where(term_id: term.id)
    end

    # Lengthy...derives program from most frequently used program within a course for a user
    def self.derive_program(user)
      course_section_ids=Cbe::CourseSectionMember.where(user_id: user.id).pluck(:course_section_id)
      course_offering_ids=Cbe::CourseSection.where('id in (?)', course_section_ids).pluck(:course_offering_id)
      programs=Cbe::CourseOffering.where('id in (?)', course_offering_ids)
      max_used_program_id = programs.maximum(:program_id)
      Cbe::Program.find(max_used_program_id)
    end

    def self.derive_terms(user)
      course_section_ids=Cbe::CourseSectionMember.where(user_id: user.id).pluck(:course_section_id)
      term_ids = Cbe::CourseSection.where('id in (?)', course_section_ids).distinct(:term_id).pluck(:term_id)
      Cbe::Term.where('id in (?)', term_ids)
    end
  end
end