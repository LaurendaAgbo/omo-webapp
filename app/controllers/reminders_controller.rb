class RemindersController < ApplicationController
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
      #VaccineReminderJob.set(wait: 1.minute).perform_later(@reminder.id, @reminder.parent_phone, 1)
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

  def call
    reminder = Reminder.find(params[:reminder_id])

    if params[:vaccination_number] == '1'
      vaccination_name = t('reminder.index.vaccine1')
    elsif params[:vaccination_number] == '2'
      vaccination_name = t('reminder.index.vaccine2')
    elsif params[:vaccination_number] == '3'
      vaccination_name = t('reminder.index.vaccine3')
    elsif params[:vaccination_number] == '4'
      vaccination_name = t('reminder.index.vaccine4')
    elsif params[:vaccination_number] == '5'
      vaccination_name = t('reminder.index.vaccine5')
    end


    p reminder.child_name
    p vaccination_name

    text = 'Vous devez emmener ' + reminder.child_name + ' faire la vaccination ' + vaccination_name + ' aujourd\'hui.'

    render json: [
      {
        'action': 'talk',
        'voiceName': 'Russell',
        'text': text
      }
    ]
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
