# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
$:.unshift("~/.rubymotion/rubymotion-templates")

require "motion/project/template/ios"
require "motion/project/template/gem/gem_tasks"
require "bundler/setup"
require "motion_print"
require "webstub"

Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.identifier = "com.infinitered.redpotion"
  app.name = "RedPotion"
  app.deployment_target = "8.0"

  app.icons = Dir.glob("resources/icon*.png").map{|icon| icon.split("/").last}

  app.device_family = [:iphone, :ipad]
  app.interface_orientations = [:portrait, :landscape_left, :landscape_right, :portrait_upside_down]

  app.redgreen_style = :full # test output

  app.info_plist['NSAppTransportSecurity'] = { 'NSAllowsArbitraryLoads' => true } # allow HTTP requests in tests

  app.pods do
    pod "SDWebImage", "~> 4.3"
  end
end
task :"build:simulator" => :"schema:build"
