class VaccineReminderJob < ApplicationJob
  queue_as :default

  def perform(reminder_id, parent_phone)
    response = nexmo.create_call({
      to: [
        {
          type: 'phone',
          number: parent_phone
        }
      ],
      from: {
        type: 'phone',
        number: call.from
      },
      answer_url: [
      outbound_call_url(reminder_path(reminder_id))
      ]
    })

    reminder = Reminder.find(reminder_id)
    reminder.update_attributes(
    uuid: response['uuid']
    ) if response['status'] && response['uuid']
  end
end
