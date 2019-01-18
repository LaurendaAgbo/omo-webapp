class RemindersController < ApplicationController

  layout 'reminders'

  before_action :authenticate_admin!, only: %i[index new show]
  before_action :must_be_authorized, only: %i[edit destroy]

  def index
    @reminders = Reminder.where('admin_id = ?', current_admin.id)
  end

  def new
    @reminder = Reminder.new
  end

  def create
    @reminder = Reminder.new(reminder_params)
    @reminder.admin_id = current_admin.id

    p params

    if @reminder.save
      # VaccineReminderJob.set(wait: 1.weeks).perform_later(@reminder.id, @reminder.parent_phone, 1)
      # VaccineReminderJob.set(wait: 6.weeks).perform_later(@reminder.id, @reminder.parent_phone, 2)
      # VaccineReminderJob.set(wait: 10.weeks).perform_later(@reminder.id, @reminder.parent_phone, 3)
      # VaccineReminderJob.set(wait: 14.weeks).perform_later(@reminder.id, @reminder.parent_phone, 4)
      # VaccineReminderJob.set(wait: 9.months).perform_later(@reminder.id, @reminder.parent_phone, 5)
      redirect_to @reminder, notice: t('reminder.create.reminder_saved')
    else
      render 'new', alert: t('reminder.create.reminder_failed')
    end
  end

  def update
    @reminder = Reminder.find(params[:id])

    if @reminder.update(reminder_params)
      redirect_to @reminder
    else
      render 'edit'
    end
  end

  def destroy
    @reminder = Reminder.find(params[:id])
    @reminder.destroy

    redirect_to reminders_path
  end

  def show
    @reminder = Reminder.find(params[:id])
  end

  def edit
  end

  private
  def reminder_params
    params.require(:reminder).permit(:parent_name, :child_name, :child_birthday, :parent_phone, :vaccine1, :vaccine2, :vaccine3, :vaccine4, :vaccine5)
  end

  def must_be_authorized
    if current_admin
      @reminder = Reminder.find(params[:id])
      if @reminder.admin_id == current_admin.id
      else
        render '/401.html'
      end
    else
      redirect_to user_session_path
    end
  end
end
