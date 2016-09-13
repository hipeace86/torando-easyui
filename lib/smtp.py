# -*- coding: utf-8 -*-
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart


def SendMail(to_mail, subject, message):
    """
    @param to_mail:
    @param subject:
    @param message:   
    """
    from_email = 'track@gbicom.org'
    msg = MIMEMultipart()
    msg['From'] = from_email
    msg['To'] = to_mail
    msg['Subject'] = subject
    con = MIMEText(message, 'html')
    msg.attach(con)

    server = smtplib.SMTP('smtp.exmail.qq.com')
    try:
        server.login('track@gbicom.org', 'track111222')
        server.sendmail(from_email, to_mail, msg.as_string())
    except Exception, what:
        pass
    finally:
        server.quit()
