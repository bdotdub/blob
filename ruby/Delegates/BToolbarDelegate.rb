# BToolbarDelegate.rb
# blob
#
# Created by Benny Wong on 10/11/09.
# Copyright 2009 Seedless Media. All rights reserved.

class BToolbarDelegate < NSObject
  BRevisionSliderIdentifier = "RevisionSliderIdentifier"

  def toolbarAllowedItemIdentifiers(toolbar)
    return [NSToolbarFlexibleSpaceItemIdentifier,
            NSToolbarSpaceItemIdentifier,
            NSToolbarShowFontsItemIdentifier,
            BRevisionSliderIdentifier]
  end

  def toolbarDefaultItemIdentifiers(toolbar)
    # return [BRevisionSliderIdentifier]
    return []
  end

  def toolbar(toolbar, itemForItemIdentifier:itemIdentifier, willBeInsertedIntoToolbar:flag)
    if itemForItemIdentifier == BRevisionSliderIdentifier
      toolbar_item = NSToolbarItem.alloc.initWithItemIdentifier(BRevisionSliderIdentifier)

      toolbar_item.setLabel('Revision: ')
      toolbar_item.setPaletteLabel('Revisions')
      toolbar_item.setToolTip('Revisions')

      return toolbar_item
    end

    return nil
  end
end
