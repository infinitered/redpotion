# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")

require "motion/project/template/ios"
require "bundler/gem_tasks"
require "bundler/setup"
require "motion_print"
require "webstub"

Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.identifier = "com.infinitered.redpotion"
  app.name = "RedPotion"

  app.interface_orientations = [:portrait, :landscape_left, :landscape_right, :portrait_upside_down]

  app.pods do
    pod "JMImageCache"
  end

  app.development do
    app.info_plist["ProjectRootPath"] = File.dirname(__FILE__)
  end
end
task :"build:simulator" => :"schema:build"
