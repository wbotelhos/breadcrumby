# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Breadcrumby::Extension, '.breadcrumby' do
  context 'when object has no path option' do
    let!(:school) { create :school, name: 'School 1' }

    it 'returns itself' do
      expect(school.breadcrumby).to eq [school]
    end
  end

  context 'when object has an empty path option' do
    let!(:school) { create :school }

    before { School.class_eval { breadcrumby path: [] } }

    it 'returns itself' do
      expect(school.breadcrumby).to eq [school]
    end
  end

  context 'when object has a nil path option' do
    let!(:school) { create :school }

    before { School.class_eval { breadcrumby path: nil } }

    it 'returns itself' do
      expect(school.breadcrumby).to eq [school]
    end
  end

  context 'when object is the second level' do
    let!(:course) { create :course }

    context 'and has one item on path option' do
      before { Course.class_eval { breadcrumby path: [:school] } }

      it 'returns itself and the parents' do
        expect(course.breadcrumby).to eq [course, course.school]
      end
    end

    context 'and has just one symbol on path option' do
      before { Course.class_eval { breadcrumby path: :school } }

      it 'returns itself and the parents' do
        expect(course.breadcrumby).to eq [course, course.school]
      end
    end
  end

  context 'when object is on a deep level' do
    let!(:school) { create :school }
    let!(:unit)   { create :unit, school: school }
    let!(:course) { create :course, school: school }
    let!(:level)  { create :level, course: course }
    let!(:grade)  { create :grade, level: level, unit: unit }

    context 'and parents just point to it parent' do
      before do
        Course.class_eval { breadcrumby path: :school }
        Level.class_eval { breadcrumby path: :course }
        Grade.class_eval { breadcrumby path: :level }
      end

      it 'returns itself and the parents' do
        expect(grade.breadcrumby).to eq [grade, grade.level, grade.level.course, grade.level.course.school]
      end
    end

    context 'and object points an specific path' do
      context 'and last parent has no path' do
        before do
          # TODO: was need to declare again, site the other Course.class_eval keeped the callback on memory. Why if it is inside a before block?
          Course.class_eval { breadcrumby }
          Grade.class_eval { breadcrumby path: [:course, :level] }
        end

        it 'returns itself and the parents until the last parent path' do
          expect(grade.breadcrumby).to eq [grade, grade.level, grade.level.course]
        end
      end

      context 'and last parent has path' do
        before do
          Course.class_eval { breadcrumby path: :school }
          Grade.class_eval { breadcrumby path: [:course, :level] }
        end

        it 'returns itself and the following parents' do
          expect(grade.breadcrumby).to eq [grade, grade.level, grade.level.course, grade.level.course.school]
        end
      end

      context 'and i want follow different paths' do
        context 'until the end' do
          before do
            Unit.class_eval { breadcrumby path: :school }
            Course.class_eval { breadcrumby path: :school }
            Level.class_eval { breadcrumby path: :course }
            Grade.class_eval { breadcrumby path: [[:unit], [:level]] }
          end

          it 'follows each one of the path groups' do
            expect(grade.breadcrumby).to eq [grade, grade.level, grade.level.course, grade.level.course.school, grade.unit, grade.level.course.school]
          end
        end

        context 'stopping on a specific point' do
          before do
            Unit.class_eval { breadcrumby path: :school }
            Course.class_eval { breadcrumby path: :school }
            Level.class_eval { breadcrumby path: :course }
            Grade.class_eval { breadcrumby path: [[:unit], [nil, :course, :level]] }
          end

          it 'follows each one of the path groups until end of until the nil break point' do
            expect(grade.breadcrumby).to eq [grade, grade.level, grade.level.course, grade.unit, grade.level.course.school]
          end
        end
      end
    end
  end
end
