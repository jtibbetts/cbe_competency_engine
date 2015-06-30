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

    def self.record_of_performance_media_type(base_uri, organization, user)
      uri_generator = UriGenerator.new(base_uri)
      result = ActiveSupport::OrderedHash.new
      result['@context'] = ActiveSupport::OrderedHash.new
      context_prefix = Rails.application.config.context_prefix
      # TODO: Remove Not used
      # icon_prefix = BusinessCenter::Application.config.icon_prefix
      result['@context'] = ActiveSupport::OrderedHash.new
      result['@context']['RecordOfPerformance'] = context_prefix + 'RecordOfPerformance'
      result['@id'] = uri_generator.root_uri
      result['@type'] = 'RecordOfPerformance'
      result['created_at'] = Time.now.iso8601

      program = derive_program(user)

      content_hash = {
          'organization' => {
              'organization_id' => uri_generator.compute_uri(['organization', organization.id]),
              'legal_name' => organization.legal_name,
              'website' => organization.website
          },
          'user' => {
              'user_id' => uri_generator.compute_uri(['user', user.id]),
              'lis_person_name_family' => user.lis_person_name_family,
              'lis_person_name_given' => user.lis_person_name_given,
              'email' => user.email,
              'sourced_id' => user.external_id
          },
          'program' => {
              'program_id' => uri_generator.compute_uri(['program', program.id]),
              'label' => program.label,
              'degree_level' => program.degree_level,
              'courses' => []
          }
      }
      result['content'] = content_hash

      terms = derive_terms(user)
      terms.each do |term|
        course_sections = derive_course_sections(user, term)
        course_sections.each do |course_section|
          course_content_hash = {
              'course_section_id' => uri_generator.compute_uri(['course_section', course_section.id]),
              'label' => course_section.label,
              'title' => course_section.title,
              'competencies' => []
          }
          result['content']['program']['courses'] << course_content_hash

          competencies = derive_competencies(course_section)
          competencies.each do |competency|
            competency_hash = {
                'competency_id' => uri_generator.compute_uri(['competency', competency.id]),
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