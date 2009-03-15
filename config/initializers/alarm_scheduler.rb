scheduler = Rufus::Scheduler.start_new  
   
# Envia o alarm a cada dia as 0:00 horas
scheduler.cron("0 0 * * *") do

  # Obtem os usuarios para envio do e-mail
  users = User.find(:all)
  
  # Obtem os alarmes a serem enviados como aviso
  alarms = Alarm.find(:all)
  
  # Obtem o tipo de alarme E-mail
  alarm_type_email = AlarmTypeWarning.find(:first, :select=>'id, name', :conditions=>['name = ?', "E-mail"])
  
  alarms.each do |alarm|
    # Obtem data final do contrato
    contract_end_date = alarm.contract.contract_end_date
    # Obtem periodo de ativo do alarme
    period_warning = alarm.alarm_period_warning.date_value
    # Obtem a ordem do contrato a ser comparado (Anterior/Apos vencimento)
    alarm_order = alarm.alarm_order.id
    
    # Verifica se a data final do contrato esta entre o perido de envio e o tipo de alarme
    if(((contract_end_date.between?(Date.today, Date.today+period_warning) && alarm_order == 1) ||
      (contract_end_date.between?(Date.today-period_warning, Date.today) && alarm_order == 1)) ||
      ((contract_end_date.between?(Date.today, Date.today+period_warning) && alarm_order == 2) ||
      (contract_end_date.between?(Date.today-period_warning, Date.today) && alarm_order == 2)) &&
      alarm.alarm_type_warnings.include?(alarm_type_email) == true)
      users.each do |user|
        if(user.group_id == alarm.group_id)
          MailerAlarm.deliver_mail(user, alarm)
        end
      end
    end
  end
end
