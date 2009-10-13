# BToolbarDelegate.rb
# blob
#
# Created by Benny Wong on 10/11/09.
# Copyright 2009 Seedless Media. All rights reserved.

class BToolbarDelegate < NSObject
  def toolbarAllowedItemIdentifiers(toolbar)
    return [NSToolbarFlexibleSpaceItemIdentifier,
            NSToolbarSpaceItemIdentifier,
            NSToolbarShowFontsItemIdentifier]
  end

  def toolbarDefaultItemIdentifiers(toolbar)
    return []
  end

  def toolbar(toolbar, itemForItemIdentifier:itemIdentifier, willBeInsertedIntoToolbar:flag)
    return nil
  end
end
