class RemarksMailer < ActionMailer::Base
  default from: "treasuresbold@gmail.com"

  def contact_form(remark)
    @remark = remark

    mail  to: "treasuresbold@gmail.com", 
          subject: "TreasuresBold Contact Form Message from #{remark.email}"
  end
end
