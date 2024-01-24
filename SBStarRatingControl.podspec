Pod::Spec.new do |s|

    s.name        = 'SBStarRatingControl'
    s.version     = '1.0.4'
    s.summary     = 'A lightweight and pure Swift implemented library for customizable star rating control.'
  
    s.description = <<-DESC
                         SBStarRatingControl is a lightweight and pure Swift implemented library for customizable star rating control.
                         DESC
  
    s.homepage    = 'https://github.com/spirit-jsb/SBStarRatingControl'
    
    s.license     = { :type => 'MIT', :file => 'LICENSE' }
    
    s.author      = { 'spirit-jsb' => 'sibo_jian_29903549@163.com' }
    
    s.swift_versions = ['5.0']
    
    s.ios.deployment_target = '11.0'
      
    s.source       = { :git => 'https://github.com/spirit-jsb/SBStarRatingControl.git', :tag => s.version }
    s.source_files = ["Sources/**/*.swift"]
    
    s.requires_arc = true
  end
  
