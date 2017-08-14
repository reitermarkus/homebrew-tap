cask 'pam-touch-id' do
  version '2'
  sha256 '65469a1a06d721eea0d8e4ccbe4851e0264cd9b8d68552b662faf9dd30abe6ba'

  url "file://#{Formula['pam-touch-id'].lib}/pam/pam_touchid.so.2"

  depends_on formula: 'pam-touch-id'
  container type: :naked

  postflight do
    system_command '/bin/mkdir', args: ['-p', '/usr/local/lib/pam']
    system_command '/bin/mv', args: ["#{staged_path}/pam_touchid.so.2", '/usr/local/lib/pam/pam_touchid.so.2']
    system_command '/bin/chmod', args: ['444', '/usr/local/lib/pam/pam_touchid.so.2']
    system_command '/usr/sbin/chown', args: ['root:wheel', '/usr/local/lib/pam/pam_touchid.so.2'], sudo: true
    system_command '/usr/bin/sed', args: ['-i', '', "2i\\\nauth       sufficient     pam_touchid.so\\\n", '/etc/pam.d/sudo'], sudo: true
  end

  uninstall_preflight do
    system_command '/usr/bin/sed', args: ['-i', '', '-E', '/auth +sufficient +pam_touchid.so/d', '/etc/pam.d/sudo'], sudo: true
    system_command '/usr/sbin/chown', args: ['root:staff', '/usr/local/lib/pam/pam_touchid.so.2'], sudo: true
    system_command '/bin/mv', args: ['/usr/local/lib/pam/pam_touchid.so.2', "#{staged_path}/pam_touchid.so.2"]
  end

  uninstall rmdir: '/usr/local/lib/pam'
end
