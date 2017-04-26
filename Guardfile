# frozen_string_literal: true

guard :rspec, all_after_pass: false, all_on_start: false, cmd: :rspec do
  ## FILES

  # (breadcrumby/models/file).rb -> spec/(breadcrumby/models/file)_spec.rb
  watch %r{^(.+)\.rb$} do |m|
    "spec/#{m[1]}_spec.rb"
  end

  ## FOLDERS

  # (breadcrumby/models/file).rb -> spec/(breadcrumby/models/file)
  watch %r{^(.+)\.rb$} do |m|
    "spec/#{m[1]}"
  end

  ## SELF

  # spec/(file)_spec.rb -> spec/(file)_spec.rb
  watch %r(^spec/.+_spec\.rb$)
end
