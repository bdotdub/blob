# BlobAppDelegate.rb
# blob
#
# Created by Benny Wong on 10/10/09.
# Copyright 2009 Seedless Media. All rights reserved.

class BlobAppDelegate < NSObject
  attr_writer :window
  def awakeFromNib
    toolbar = NSToolbar.alloc.initWithIdentifier("BToolbar")
    
    toolbar.setAutosavesConfiguration(true)
    toolbar.setDisplayMode(NSToolbarDisplayModeIconAndLabel)
    
    @window.setToolbar(toolbar)
  end
end
