require 'rails_helper'

RSpec.describe 'Student index page', type: :feature do
  it 'can show all students with attributes' do
    instructor = Instructor.create!(name: 'Jerry Gergich')
    student_1 = instructor.students.create!(name: 'Andy Dwyer', cohort: 1608, age: 24)
    student_2 = instructor.students.create!(name: 'Leslie Knope', cohort: 1610, age: 28)

    visit '/students'

    within "#student-#{student_1.id}" do
      expect(page).to have_content(student_1.name)
      expect(page).to have_content(student_1.cohort)
      expect(page).to have_content(instructor.name)

      expect(page).to_not have_content(student_2.name)
      expect(page).to_not have_content(student_2.cohort)
    end

    within "#student-#{student_2.id}" do
      expect(page).to have_content(student_2.name)
      expect(page).to have_content(student_2.cohort)
      expect(page).to have_content(instructor.name)

      expect(page).to_not have_content(student_1.name)
      expect(page).to_not have_content(student_1.cohort)
    end
  end

  it 'has links for instructor names' do
    instructor_1 = Instructor.create!(name: 'Jerry Gergich')
    instructor_2 = Instructor.create!(name: 'Ann Perkins')
    student_1 = instructor_1.students.create!(name: 'Andy Dwyer', cohort: 1608, age: 24)
    student_2 = instructor_2.students.create!(name: 'Leslie Knope', cohort: 1610, age: 28)

    visit '/students'

    within "#student-#{student_1.id}" do
      expect(page).to have_link(instructor_1.name)
    end

    within "#student-#{student_2.id}" do
      expect(page).to have_link(instructor_2.name)
    end
  end
end
