class VaccineReminderJob < ApplicationJob
  queue_as :default

  def perform(reminder_id, parent_phone, vaccination_number)
    reminder = Reminder.find(reminder_id)

    response = nexmo.create_call({
      to: [
        {
          type: 'phone',
          number: parent_phone
        }
      ],
      from: {
        type: 'phone',
        number: ENV['NEXMO_PHONE_NUMBER']
      },
      answer_url: [
        outbound_call_url("#{ENV['ROOT_URL']}/call/#{vaccination_number}/#{@reminder.id}")        
      ]
    })

    if response['status'] && response['uuid']
      if vaccination_number == 1
        reminder.update_attributes(vaccine1: true)
      elsif vaccination_number == 2
        reminder.update_attributes(vaccine2: true)
      elsif vaccination_number == 3
        reminder.update_attributes(vaccine3: true)
      elsif vaccination_number == 4
        reminder.update_attributes(vaccine4: true)
      elsif vaccination_number == 5
        reminder.update_attributes(vaccine5: true)
      end
    end
  end

  private

  def nexmo
    client = Nexmo::Client.new(
      application_id: ENV['NEXMO_APP_ID'],
      private_key: File.read(ENV['NEXMO_SECRET_KEY'])
    )
  end
end
