class RemarksMailer < ActionMailer::Base
  default from: "from@example.com"

  def contact_form(remark)
    @remark = remark
    @greeting = "Hi"

    mail  to: "philbattos@gmail.com", 
          subject: "TreasuresBold Contact Form Message from #{remark.email}"
  end
end
