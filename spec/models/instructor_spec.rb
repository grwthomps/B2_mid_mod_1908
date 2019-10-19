require 'rails_helper'

RSpec.describe Instructor, type: :model do
  describe 'validations' do
    it {should validate_presence_of :name}
  end

  describe 'relationships' do
    it {should have_many :instructor_students}
    it {should have_many(:students).through(:instructor_students)}
  end

  describe 'methods' do
    describe 'average_age' do
      it 'shows the average age of instructor students' do
        instructor_1 = Instructor.create!(name: 'Jerry Gergich')
        student_1 = instructor_1.students.create!(name: 'Andy Dwyer', cohort: 1608, age: 24)
        student_2 = instructor_1.students.create!(name: 'April Ludgate', cohort: 1609, age: 21)

        expect(instructor_1.average_age).to eq(22.5)
      end
    end
  end
end
