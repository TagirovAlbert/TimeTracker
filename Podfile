# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Stopwatch' do
  use_frameworks!

  pod "RealmSwift"
  pod 'FSCalendar'
end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end
