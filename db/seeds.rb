# This file should contain all the record creation needed to seed the database with its default values.
puts "Reseeding #{Rails.env}"
Lti2Tc::DeploymentRequest.delete_all
Lti2Tc::ToolConsumerProfile.delete_all
Lti2Tc::Resource.delete_all
Lti2Tc::Tool.delete_all
Lti2Tc::Link.delete_all
GradeItem.delete_all
GradeResult.delete_all
Lti2Tc::ToolSetting.delete_all

Cbe::Organization.delete_all
Cbe::User.delete_all
Cbe::Program.delete_all
Cbe::Term.delete_all
Cbe::CourseOffering.delete_all
Cbe::CourseSection.delete_all
Cbe::Competency.delete_all
Cbe::CompetencyScore.delete_all
Cbe::CourseSectionMember.delete_all
Cbe::AchievementLevel.delete_all

Cbe::Organization.create(
    legal_name: 'IMS Learning Institute, LLC',
    label: 'IMSLearningInst',
    description: 'IMS Institute for Educational Standards',
    website: 'ili.imsglobal.org'
)

donat = Cbe::User.create(
    lis_person_name_given: 'Roberta',
    lis_person_name_family: 'Donat',
    lis_person_name_full: 'Roberta Donat',
    email: 'rdonat@gmail.com',
    external_id: 'RD3321'
)

arne = Cbe::User.create(
    lis_person_name_given: 'Tom',
    lis_person_name_family: 'Arne',
    lis_person_name_full: 'Tom Arne',
    email: 'tarne@hotmail.com',
    external_id: 'RD5421'
)

mbaProg = Cbe::Program.create(
    label: 'Master of Business Admin FP',
    degree_level: 'MBA',
    version: '31.1'
)

termFall2013 = Cbe::Term.create(
    start_date: Date.new(2013, 9, 3),
    end_date: Date.new(2014, 1, 2),
    description: 'Fall Quarter 2013'
)

termWinter2014 = Cbe::Term.create(
    start_date: Date.new(2014, 1, 15),
    end_date: Date.new(2014, 5, 22),
    description: 'Winter Quarter 2014'
)

mba6004 = Cbe::CourseOffering.create(
    program_id: mbaProg.id,
    label: 'MBA-FP 6004',
    title: 'Foundational Skills for Business Leaders',
    version: '2A'
)

mba6006 = Cbe::CourseOffering.create(
    program_id: mbaProg.id,
    label: 'MBA-FP 6006',
    title: 'Leading Innovation in the Global Enterprise',
    version: '2A'
)

mba6008 = Cbe::CourseOffering.create(
    program_id: mbaProg.id,
    label: 'MBA-FP 6008',
    title: 'Global Economic Environment',
    version: '2A'
)

mba6012 = Cbe::CourseOffering.create(
    program_id: mbaProg.id,
    label: 'MBA-FP 6012',
    title: 'Integrated Global Marketing',
    version: '2B'
)

Cbe::CourseSection.create(
    course_offering_id: mba6004.id,
    term_id: termFall2013.id,
    label: "#{mba6004.label} Section 1",
    section_number: "1"
)

Cbe::CourseSection.create(
    course_offering_id: mba6004.id,
    term_id: termFall2013.id,
    label: "#{mba6004.label} Section 2",
    section_number: "2"
)

Cbe::CourseSection.create(
    course_offering_id: mba6006.id,
    term_id: termFall2013.id,
    label: "#{mba6006.label} Section 1",
    section_number: "1"
)

Cbe::CourseSection.create(
    course_offering_id: mba6008.id,
    term_id: termFall2013.id,
    label: "#{mba6008.label} Section 1",
    section_number: "1"
)

Cbe::CourseSection.create(
    course_offering_id: mba6012.id,
    term_id: termFall2013.id,
    label: "#{mba6012.label} Section 1",
    section_number: "1"
)

Cbe::CourseSection.create(
    course_offering_id: mba6004.id,
    term_id: termWinter2014.id,
    label: "#{mba6004.label} Section 1",
    section_number: "1"
)

Cbe::CourseSection.create(
    course_offering_id: mba6004.id,
    term_id: termWinter2014.id,
    label: "#{mba6004.label} Section 2",
    section_number: "2"
)

Cbe::CourseSection.create(
    course_offering_id: mba6006.id,
    term_id: termWinter2014.id,
    label: "#{mba6006.label} Section 1",
    section_number: "1"
)

Cbe::CourseSection.create(
    course_offering_id: mba6008.id,
    term_id: termWinter2014.id,
    label: "#{mba6008.label} Section 1",
    section_number: "1"
)

Cbe::CourseSection.create(
    course_offering_id: mba6012.id,
    term_id: termWinter2014.id,
    label: "#{mba6012.label} Section 1",
    section_number: "1"
)

competency_by_course_offering = {}
competency_by_course_offering[mba6004] = []
competency_by_course_offering[mba6006] = []
competency_by_course_offering[mba6008] = []
competency_by_course_offering[mba6012] = []


competency_by_course_offering[mba6004] << Cbe::Competency.create(
    statement: 'Examine the use of critical, strategic, and ethical thinking in decision-making'
)

competency_by_course_offering[mba6004] << Cbe::Competency.create(
    statement: 'Integrate the Internet, collaboration, and virtual environment strategies into general business management planning and decision-making.'
)

competency_by_course_offering[mba6004] << Cbe::Competency.create(
    statement: 'Integrate business strategies into general business management planning and decision-making.'
)

competency_by_course_offering[mba6004] << Cbe::Competency.create(
    statement: 'Analyze relevant global business concerns for the future.'
)

competency_by_course_offering[mba6004] << Cbe::Competency.create(
    statement: 'Communicate in a manner that is professional and consistent with expectations for members of the business professions.'
)

competency_by_course_offering[mba6006] << Cbe::Competency.create(
    statement: 'Analyze contemporary leadership models and practices from the perspective of innovation in a global environment.'
)

competency_by_course_offering[mba6006] << Cbe::Competency.create(
    statement: 'Assess the behaviors that drive innovation and how leaders can use those behaviors to create innovative organizations.'
)

competency_by_course_offering[mba6006] << Cbe::Competency.create(
    statement: 'Assess what leaders of innovation do to shape organizational culture and processes.'
)

competency_by_course_offering[mba6006] << Cbe::Competency.create(
    statement: 'Communicate in a manner that is professional and consistent with expectations for members of the business professions.'
)

competency_by_course_offering[mba6008] << Cbe::Competency.create(
    statement: 'Apply the theories, models, and practices of economic theory to create value for the firm.'
)

competency_by_course_offering[mba6008] << Cbe::Competency.create(
    statement: 'Assess the impact of ethical and regulatory considerations on economic decisions'
)

competency_by_course_offering[mba6008] << Cbe::Competency.create(
    statement: 'Analyze the macroeconomic environment of corporate operations'
)

competency_by_course_offering[mba6008] << Cbe::Competency.create(
    statement: 'Analyze the microeconomic environment of corporate operations'
)

competency_by_course_offering[mba6008] << Cbe::Competency.create(
    statement: 'Communicate in a manner that is professional and consistent with expectations for members of the business professions.ply collaborative techniques to the virtual environment.'
)

competency_by_course_offering[mba6012] << Cbe::Competency.create(
    statement: 'Apply theories, models, and practices of marketing'
)

competency_by_course_offering[mba6012] << Cbe::Competency.create(
    statement: 'Integrate fundamental principles and applications of marketing to address business problems.'
)

competency_by_course_offering[mba6012] << Cbe::Competency.create(
    statement: 'Develop innovative and sustainable solutions to strategic marketing challenges'
)

competency_by_course_offering[mba6012] << Cbe::Competency.create(
    statement: 'Integrate marketing analyses into general business management planning and decision making'
)

competency_by_course_offering[mba6012] << Cbe::Competency.create(
    statement: 'Communicate in a manner that is professional and consistent with expectations for members of the business professions'
)

competency_by_course_offering.each_pair do |course_offering, competencies|
  competencies.each do |competency|
    Cbe::CompetencyOfferingMap.create(
        competency_id: competency.id,
        course_offering_id: course_offering.id,
        sequence_number: 1
    )
  end
end

fall_courses = Cbe::CourseSection.where(term_id: termFall2013.id, section_number: 1, course_offering_id: mba6004.id..mba6008.id)
fall_courses.each do |course_section|
  Cbe::CourseSectionMember.create(
      course_section_id: course_section.id,
      user_id: arne.id,
      role:   'learner'
  )

  Cbe::CourseSectionMember.create(
      course_section_id: course_section.id,
      user_id: donat.id,
      role:   'instructor'
  )
end


winter_courses = Cbe::CourseSection.where(term_id: termWinter2014.id, section_number: 1, course_offering_id: mba6008.id..mba6012.id)
winter_courses.each do |course_section|
  Cbe::CourseSectionMember.create(
      course_section_id: course_section.id,
      user_id: arne.id,
      role:   'learner'
  )

  Cbe::CourseSectionMember.create(
      course_section_id: course_section.id,
      user_id: donat.id,
      role:   'instructor'
  )
end

competencies = Cbe::Competency.all
course_sections = Cbe::CourseSection.all
competencies.each do |competency|
  course_sections.each do |course_section|
    Cbe::CompetencyScore.create(
      user_id: arne.id,
      competency_id: competency.id,
      course_section_id: course_section.id,
      final_score: (60.0 + (rand * 40.0))
    )
  end
end

Cbe::AchievementLevel.create(
  label: 'Distinguished',
  start_of_range: 90
)

Cbe::AchievementLevel.create(
    label: 'Proficient',
    start_of_range: 80
)

Cbe::AchievementLevel.create(
    label: 'Basic',
    start_of_range: 70
)

Cbe::AchievementLevel.create(
    label: 'Failed',
    start_of_range: 0
)
