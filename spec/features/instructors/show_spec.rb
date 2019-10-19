require 'rails_helper'

RSpec.describe 'Instructor show page', type: :feature do
  it 'can show specific instructor with attributes' do
    instructor_1 = Instructor.create!(name: 'Jerry Gergich')
    instructor_2 = Instructor.create!(name: 'Ann Perkins')
    student_1 = instructor_1.students.create!(name: 'Andy Dwyer', cohort: 1608, age: 24)
    student_2 = instructor_1.students.create!(name: 'April Ludgate', cohort: 1609, age: 21)
    student_3 = instructor_2.students.create!(name: 'Leslie Knope', cohort: 1610, age: 28)

    visit '/students'

    within "#student-#{student_1.id}" do
      click_link 'Jerry Gergich'
    end

    expect(current_path).to eq("/instructors/#{instructor_1.id}")

    expect(page).to have_content(instructor_1.name)
    expect(page).to_not have_content(instructor_2.name)

    within "#students" do
      expect(page).to have_content(student_1.name)
      expect(page).to have_content(student_2.name)
    end

    expect(page).to_not have_content(student_3.name)

    expect(page).to have_content('Average Student Age: 22.5')
  end
end
