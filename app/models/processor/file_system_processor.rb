class Processor::FileSystemProcessor
  def process_filesystem!(host, fs)
    return if fs["mnt_pnt"] == "WITHHELD"
    f = Core::Filesystem.find_or_create_by!(host_id: host.id, mnt_pnt: fs["mnt_pnt"])
    f.fs_type = fs["fs_type"]
    f.f_bavail = fs["f_favail"]
    f.f_bsize = fs["f_bsize"]
    f.f_frsize = fs["f_frsize"]
    f.f_blocks = fs["f_blocks"]
    f.f_bfree = fs["f_bfree"]
    f.f_files = fs["f_files"]
    f.f_ffree = fs["f_ffree"]
    f.f_fssize = fs["f_fssize"]
    f.save!
  end
end
