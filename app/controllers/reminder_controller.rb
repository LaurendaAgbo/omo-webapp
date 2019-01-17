class ReminderController < ApplicationController
  def index
    @reminder = Reminder.all
  end

  def new
    @reminder = Reminder.new
  end

  def create
    @reminder = Reminder.new(reminder_params)

    if @reminder.save
      VaccineReminderJob.set(wait: 1.weeks).perform_later(@reminder.id, @reminder.parent_phone, 1)
      VaccineReminderJob.set(wait: 6.weeks).perform_later(@reminder.id, @reminder.parent_phone, 2)
      VaccineReminderJob.set(wait: 10.weeks).perform_later(@reminder.id, @reminder.parent_phone, 3)
      VaccineReminderJob.set(wait: 14.weeks).perform_later(@reminder.id, @reminder.parent_phone, 4)
      VaccineReminderJob.set(wait: 9.months).perform_later(@reminder.id, @reminder.parent_phone, 5)
      redirect_to @reminder, notice: 'Reminder saved !'
    else
      render 'new'
    end
  end

  def show
    @reminder = Reminder.find(params[:id])
  end

  def edit
  end

  private
  def reminder_params
    params.require(:reminder).permit(:parent_name, :child_name, :parent_phone, :vaccine1, :vaccine2, :vaccine3, :vaccine4, :vaccine5)
  end
end
