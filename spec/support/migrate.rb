Dir[File.expand_path('db/migrate/**/*.rb', __dir__)].each { |file| require file }

CreateSchoolsTable.new.change
CreateUnitsTable.new.change
CreateCoursesTable.new.change
CreateLevelsTable.new.change
CreateGradesTable.new.change
