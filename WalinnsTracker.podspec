Pod::Spec.new do |s|
#1.
s.name               = "WalinnsTracker"
#2.
s.version            = "1.0.0"
#3.
s.summary         = "walinnslib"
#4.
s.homepage        = "https://github.com/Rejoylin/swiftLib"
#5.
s.license              = "MIT"
#6.d
s.author               = "walinns"
#7.
s.module_name          = "WalinnsTracker"
#8.
s.platform            = :ios, "10.3"
#9.
s.source              = { :git => "https://github.com/Rejoylin/swiftLib.git", :tag => "1.0.0" }
#10.
s.source_files     = "WalinnsLib", "WalinnsLib/**/*.{h,m,swift}"
end

