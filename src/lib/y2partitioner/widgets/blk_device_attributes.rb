require "yast/i18n"

module Y2Partitioner
  module Widgets
    # helper to share helpers to print common attributes
    # for Block Devices
    # Main goal is to share functionality for *Description widgets.
    # Requirement for this module is to have blk_device method that
    # returns Y2Storage::BlkDevice instance.
    module BlkDeviceAttributes
      extend Yast::I18n

      def included(_target)
        textdomain "storage"
      end

      def device_name
        # TRANSLATORS: here device stands for kernel path to device
        format(_("Device: %s"), blk_device.name)
      end

      def device_size
        # TRANSLATORS: size of partition
        format(_("Size: %s"), blk_device.size.to_human_string)
      end

      def device_udev_by_path
        paths = blk_device.udev_paths
        if paths.size > 1
          paths.each_with_index.map do |path, index|
            # TRANSLATORS: Device path is where on motherboard is device connected,
            # %i is number when there are more paths
            format(_("Device Path %i: %s"), index + 1, path)
          end
        else
          # TRANSLATORS: Device path is where on motherboard is device connected
          [format(_("Device Path: %s"), paths.first)]
        end
      end

      def device_udev_by_id
        ids = blk_device.udev_ids
        if ids.size > 1
          paths.each_with_index.map do |id, index|
            # TRANSLATORS: Device ID is udev ID for device,
            # %i is number when there are more paths
            format(_("Device ID %i: %s"), index + 1, id)
          end
        else
          # TRANSLATORS: Device ID is udev ID for device,
          [format(_("Device ID: %s"), ids.first)]
        end
      end

      def device_encrypted
        format(_("Encrypted: %s"),  blk_device.encrypted? ? _("Yes") : _("No"))
      end
    end
  end
end
