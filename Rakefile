# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")

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

  app.pods do
    pod "SDWebImage"
  end

  app.development do
  end
end
task :"build:simulator" => :"schema:build"
