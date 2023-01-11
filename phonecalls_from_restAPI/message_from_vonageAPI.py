#!/usr/bin/python3.8



import vonage

print("Message sent successfully.")

client = vonage.Client(key="a456fe14", secret="HYVqXB2onGxbnbFV")
sms = vonage.Sms(client)
print("Message sent successfully.")

responseData = sms.send_message(
    {
        "from": "Vonage APIs",
        "to": ["+94764574455","+94767672709"],
        "text": "karan is a superstar",
    }
)
print("Message sent successfully.")

if responseData["messages"][0]["status"] == "0":
    print("Message sent successfully.")
else:
    print(f"Message failed with error: {responseData['messages'][0]['error-text']}")
