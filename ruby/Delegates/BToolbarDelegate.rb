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
    [NSToolbarSpaceItemIdentifier, BRevisionSliderIdentifier, NSToolbarSpaceItemIdentifier]
  end

  def toolbar(bar, itemForItemIdentifier:itemIdentifier, willBeInsertedIntoToolbar:flag)
    if itemIdentifier == BRevisionSliderIdentifier
      toolbar_item = NSToolbarItem.alloc.initWithItemIdentifier(BRevisionSliderIdentifier)

      toolbar_item.setLabel('Revision: ')
      toolbar_item.setPaletteLabel('Revisions')
      toolbar_item.setToolTip('Revisions')

      slider = NSSlider.alloc.initWithFrame(NSMakeRect(100, 100, 200, 50))
      slider.setMinValue(0)
      slider.setMaxValue(10)
      slider.setIntValue(5)

      slider.setAllowsTickMarkValuesOnly(true)
      slider.setNumberOfTickMarks(10)

      toolbar_item.setView(slider)
      toolbar_item.setMinSize(NSMakeSize(200, 50))
      toolbar_item.setMaxSize(NSMakeSize(1500, 50))
      return toolbar_item
    end

    return nil
  end
end
