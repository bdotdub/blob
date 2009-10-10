# BDiffViewController.rb
# blob
#
# Created by Benny Wong on 10/10/09.
# Copyright 2009 Seedless Media. All rights reserved.

class BDiffViewController < NSObject
  attr_writer :button
  
  def clicked(sender)
	puts "Button clicked!"
  end
end
