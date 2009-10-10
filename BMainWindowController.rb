# BMainWindowController.rb
# blob
#
# Created by Benny Wong on 10/10/09.
# Copyright 2009 Seedless Media. All rights reserved.

class BMainWindowController < NSWindowController
  def windowDidLoad
    NSToolbar toolbar = NSToolbar.alloc.initWithIdentifier_("BToolBar")
    
    # toolbar.setAutosavesConfiguration_(true)
  end
end
