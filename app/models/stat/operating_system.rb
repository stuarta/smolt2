class Stat::OperatingSystem < ApplicationRecord
  scope :find_debian,    -> { where("name like ?", "debian%") }
  scope :find_fedora,    -> { where("name like ?", "fedora%") }
  scope :find_linhes,    -> { where("name like ?", "linhes%") }
  scope :find_linuxmint, -> { where("name like ?", "linuxmint%") }
  scope :find_opensuse,  -> { where("name like ?", "opensuse%") }
  scope :find_raspbian,  -> { where("name like ?", "raspbian%") }
  scope :find_ubuntu,    -> { where("name like ?", "ubuntu%") }
  scope :find_other, -> {
    where("name not like ? AND
           name not like ? AND
           name not like ? AND
           name not like ? AND
           name not like ? AND
           name not like ? AND
           name not like ?",
           "debian%", "fedora%", "linhes%", "linuxmint%", "opensuse%", "raspbian%", "ubuntu%")
  }
end
