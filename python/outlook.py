import win32com.client

def send_email(to,cc,subject,body):
    outlook = win32com.client.Dispatch('outlook.application')
    mail = outlook.CreateItem(0)
    mail.To = to
    mail.Subject = subject
    mail.HTMLBody = body
    mail.cc = cc
    mail.Display()
