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
#6.
s.author               = "walinns"
#7.
s.platform            = :ios, "9.3"
#8.
s.source              = { :git => "https://github.com/Rejoylin/swiftLib.git", :tag => "1.0.0" }
#9.
s.source_files     = "swiftLib", "swiftLib/**/*.{h,m,swift}"
end
