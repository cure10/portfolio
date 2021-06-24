class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  # 確認画面を作成する場合はこのような記述になるかと思います。
  # newアクションから入力内容を受け取り、
  # 送信ボタンを押されたらcreateアクションを実行します。
  def confirm
    @contact = Contact.new(contact_params)
    if @contact.invalid?
      render :new
    end
  end

  # 実際に送信するアクションになります。
  # ここで初めて入力内容を保存します。
  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      ContactMailer.send_mail(@contact).deliver_now
      redirect_to thanks_path
    else
      render :new
    end
  end

  def thanks
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :name, :phone_number, :subject, :message)
  end
end
