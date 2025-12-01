class Core::Host < ApplicationRecord
  has_many    :device_links
  has_many    :devices, through: :device_links, dependent: :destroy
  has_many    :file_systems, class_name: "Core::Filesystem", dependent: :destroy
  belongs_to  :formfactor
  belongs_to  :host_pub_mapping
  belongs_to  :platform
  belongs_to  :operating_system
  belongs_to  :vendor
  belongs_to  :cpu
  belongs_to  :kernel_version
  belongs_to  :language
  belongs_to  :run_level
  belongs_to  :myth_host, class_name: "Myth::Host"
end
