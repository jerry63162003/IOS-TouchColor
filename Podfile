# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

def pod_ui()
  pod 'SnapKit'
  pod 'Spring', :git => 'https://github.com/MengTo/Spring.git', :branch => 'swift4'
end

def pod_infrastructure()
  pod 'Fabric', '~> 1.6'
  pod 'SwiftLint'
end

target 'TouchColor' do
    pod_infrastructure()
    pod_ui()
  use_frameworks!

  target 'TouchColorTests' do
    inherit! :search_paths
    pod 'Nimble', '~> 7.0'
    pod 'Quick', '~> 1.1'
  end

  target 'TouchColorUITests' do
    inherit! :search_paths
    pod 'Nimble', '~> 7.0'
    pod 'Quick', '~> 1.1'
  end

end
