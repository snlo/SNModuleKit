#
#  Be sure to run `pod spec lint SNModuleKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#  pod spec lint SNModuleKit.podspec --verbose --use-libraries --allow-warnings

Pod::Spec.new do |s|

# ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#
#  These will help people to find your library, and whilst it
#  can feel like a chore to fill in it's definitely to your advantage. The
#  summary should be tweet-length, and the description more in depth.
#

s.name         = "SNModuleKit"
s.version      = "2.2.1"
s.summary      = "A delightful iOS and OS X Project framework."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
s.description  = <<-DESC
If your project uses component-based solutions, you'll be much more handy with this framework!
DESC

s.homepage     = "https://github.com/snlo/SNModuleKit"
# s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


# ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#
#  Licensing your code is important. See http://choosealicense.com for more info.
#  CocoaPods will detect a license file if there is a named LICENSE*
#  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
#

s.license      = "MIT"
s.license      = { :type => "MIT", :file => "LICENSE" }


# ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#
#  Specify the authors of the library, with email addresses. Email addresses
#  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
#  accepts just a name if you'd rather not provide an email address.
#
#  Specify a social_media_url where others can refer to, for example a twitter
#  profile URL.
#

s.author             = { "snlo" => "snloveydus@sina.com" }
# Or just: s.author    = "MrSunDong"
# s.authors            = { "MrSunDong" => "snloveydus@sina.com" }
# s.social_media_url   = "http://twitter.com/MrSunDong"

# ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#
#  If this Pod runs only on iOS or OS X, then specify the platform and
#  the deployment target. You can optionally include the target after the platform.
#

# s.platform     = :ios
s.platform     = :ios, "8.0"

#  When using multiple platforms
# s.ios.deployment_target = "5.0"
# s.osx.deployment_target = "10.7"
# s.watchos.deployment_target = "2.0"
# s.tvos.deployment_target = "9.0"


# ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#
#  Specify the location from where the source should be retrieved.
#  Supports git, hg, bzr, svn and HTTP.
#

s.source       = { :git => "https://github.com/snlo/SNModuleKit.git", :tag => "#{s.version}"}


# ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#
#  CocoaPods is smart about how it includes source code. For source files
#  giving a folder will include any swift, h, m, mm, c & cpp files.
#  For header files it will include any header in the folder.
#  Not including the public_header_files will make all headers public.
#

s.source_files  = "SNModuleKit/SNModuleKit/SNModuleKit.h"
# s.source_files  = "Classes", "Classes/**/*.{h,m}"
# s.exclude_files = "Classes/Exclude"

# s.public_header_files = "SNModuleKit/SNModuleKit/SNModuleKit.h"


# ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#
#  A list of resources included with the Pod. These are copied into the
#  target bundle with a build phase script. Anything else will be cleaned.
#  You can preserve files from being cleaned, please don't preserve
#  non-essential files like tests, examples and documentation.
#

# s.resources = 'SNModuleKit/SNModuleKit/Resources/SNModuleKit.bundle'
s.resources = 'SNModuleKit/SNModuleKit/Resources/*'

# s.preserve_paths = "FilesToSave", "MoreFilesToSave"

s.subspec 'Config' do |ss|
ss.source_files = 'SNModuleKit/SNModuleKit/Config/*.{h,m}'

end
s.subspec 'Components' do |ss|
ss.source_files = 'SNModuleKit/SNModuleKit/Components/*.{h}'

end
s.subspec 'Controls' do |ss|
ss.source_files = 'SNModuleKit/SNModuleKit/Controls/*.{h}'

end
s.subspec 'Plugins' do |ss|
ss.source_files = 'SNModuleKit/SNModuleKit/Plugins/*.{h}'

end
s.subspec 'Middlewares' do |ss|
ss.source_files = 'SNModuleKit/SNModuleKit/Middlewares/*.{h}'

end

# s.subspec 'Resources' do |ss|
# ss.source_files = 'SNModuleKit/SNModuleKit/Resources/SNModuleKitRem.md'
# ss.source_files = 'SNModuleKit/SNModuleKit/Resources/setupCodeSnippets.sh'

# end

# ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#
#  Link your library with frameworks, or libraries. Libraries do not include
#  the lib prefix of their name.
#

# s.framework  = "SomeFramework"
# s.frameworks = "SomeFramework", "AnotherFramework"

# s.library   = "iconv"
# s.libraries = "iconv", "xml2"


# ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
#
#  If your library depends on compiler flags you can set them in the xcconfig hash
#  where they will only apply to your library. If you depend on other Podspecs
#  you can include multiple dependencies to ensure it works.

s.requires_arc = true

s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }

s.dependency 'SAMKeychain'
s.dependency 'Aspects'
s.dependency 'ReactiveObjC'
s.dependency 'SDWebImage'
s.dependency 'Masonry'
s.dependency 'FMDB/FTS'
s.dependency 'lottie-ios', '~> 2.5.3'
s.dependency 'pop'
s.dependency 'WebViewJavascriptBridge'
s.dependency 'MBProgressHUD'
s.dependency 'MJRefresh'
s.dependency 'AFNetworking'


s.dependency 'IQKeyboardManager'

s.dependency 'SNMediatorKit', '~> 0.1.7'

s.dependency 'SNScanViewController', '~> 0.1.3'
s.dependency 'SNPopupViewController', '~> 0.1.2'
s.dependency 'SNPhotoCarmeraViewController', '~> 0.0.6'
s.dependency 'SNBadgeView', '~> 0.0.3'
s.dependency 'SNImageBrowserViewController', '~> 0.0.3'
s.dependency 'SNWebViewController', '~> 0.1.4'


s.dependency 'SNTool', '~> 0.1.4'

s.dependency 'SNUIKit', '~> 0.3.0'
s.dependency 'SNAnimations', '~> 0.0.3'
s.dependency 'SNFoundation', '~> 0.0.4'

s.dependency 'SNFileManager', '~> 0.0.1'
s.dependency 'SNDBManager', '~> 0.0.4'
s.dependency 'SNNetworking', '~> 0.1.3'
s.dependency 'SNDownTimer', '~> 0.0.8'

end
