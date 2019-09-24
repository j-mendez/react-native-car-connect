require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name         = "react-native-car-connect"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = <<-DESC
                  react-native-car-connect
                   DESC
  s.homepage     = "https://github.com/jeffreymendez1993/react-native-car-connect"
  s.license      = "MIT"
  s.license    = { :type => "MIT", :file => "LICENSE" }
  s.authors      = { "Jeffrey Mendez" => "jeffmendez19@email.com" }
  s.platforms    = { :ios => "9.0", :tvos => "10.0" }
  s.source       = { :git => "https://github.com/jeffreymendez1993/react-native-car-connect.git", :tag => "#{s.version}" }

  s.source_files = "ios/**/*.{h,m,swift}"
  s.exclude_files       = 'android/**/*'
  s.dependency 'React'
  # s.swift_version = "5.0"
end
