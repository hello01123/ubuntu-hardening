function f_audit {
  echo "Configuring audits"

  sed -i 's/^action_mail_acct =.*/action_mail_acct = root/' /etc/audit/auditd.conf
  sed -i 's/^admin_space_left_action = .*/admin_space_left_action = halt/' /etc/audit/auditd.conf
  sed -i 's/^max_log_file_action =.*/max_log_file_action = keep_logs/' /etc/audit/auditd.conf
  sed -i 's/^space_left_action =.*/space_left_action = email/' /etc/audit/auditd.conf
  sed -i 's/^GRUB_CMDLINE_LINUX=.*/GRUB_CMDLINE_LINUX="audit=1 audit_backlog_limit=8192"/' /etc/default/grub

  cp "./misc/audit.header" /etc/audit/rules.d/hardening.rules
  for l in /etc/audit/rules.d/hardening.rules; do
    cat "$l" >> /etc/audit/audit.rules
  done
  cat "./misc/audit.footer" >> /etc/audit/rules.d/hardening.rules

  sed -i "s/arch=b64/arch=$(uname -m)/g" /etc/audit/audit.rules
  cp /etc/audit/audit.rules /etc/audit/rules.d/hardening.rules
  update-grub 2> /dev/null

  sudo service enable auditd
  sudo service restart auditd

}