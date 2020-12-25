Pod::Spec.new do |s|
s.name         = 'LMJDropdownMenu'
s.version      = '3.0.4'
s.summary      = 'An easy way to use dropdown-nemu'
s.homepage     = 'https://github.com/JerryLMJ/LMJDropdownMenu'
s.license      = {:type => 'MIT', :file => 'LICENSE' }
s.authors      = {'JerryLMJ' => 'limingjie_mail@163.com'}
s.platform     = :ios, '8.0'
s.source       = {:git => 'https://github.com/JerryLMJ/LMJDropdownMenu.git', :tag => s.version}
s.source_files = 'LMJDropdownMenu/**/*'
s.requires_arc = true
end
