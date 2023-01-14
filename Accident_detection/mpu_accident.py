from mpu6050 import mpu6050
import time
import vonage
import math
device_id="device02"
import pyrebase
import time
import requests
config = {
  "apiKey": "AIzaSyCvZbxo-lwr19e6tE-cm7kbg4CHkjmk-6M",
  "authDomain": "roadsafe-ab1d9.firebaseapp.com",
  "databaseURL": "https://roadsafe-ab1d9-default-rtdb.firebaseio.com",
  "projectId": "roadsafe-ab1d9",
  "storageBucket": "roadsafe-ab1d9.appspot.com",
  "messagingSenderId": "324383370133",
  "appId": "1:324383370133:web:2624fcbaa46bd46743e49c"
}
firebase = pyrebase.initialize_app(config)
db = firebase.database()
#==db.child("Devices").child("device_map").push({"Device_2": "John"})
users = db.child("Devices").child("device_map").get()
print(users.val())
for i in users.val():
    print(users.val()[i])
    uid=users.val()[i][device_id]
print(uid)
#Vonage Conenction
client = vonage.Client(key="af40be87", secret="OboBYxaAyrgJpx9W")
client1 = vonage.Client(
    application_id="987280ec-2680-4c3f-adf1-353039f26b5d",
    private_key='/home/pi/Desktop/private (1).key',
)
sms = vonage.Sms(client)
#mpu accelerometer, and gyroscope
mpu = mpu6050(0x68)

lst_x=[]
lst_y=[]
lst_z=[]
count=0
sensitivity = 20

while True:
    print("Temp : "+str(mpu.get_temp()))
    print()

    accel_data = mpu.get_accel_data()
    print("Acc X : "+str(accel_data['x']))
    print("Acc Y : "+str(accel_data['y']))
    print("Acc Z : "+str(accel_data['z']))
    print()

    gyro_data = mpu.get_gyro_data()
    print("Gyro X : "+str(gyro_data['x']))
    print("Gyro Y : "+str(gyro_data['y']))
    print("Gyro Z : "+str(gyro_data['z']))
    print()
    print("-------------------------------")
    lst_x.append(accel_data['x'])
    lst_y.append(accel_data['y'])
    lst_z.append(accel_data['z'])
    count=count+1
    if (count==2):
        print(lst_x)
        oldx = lst_x[0]
        oldy = lst_y[0]
        oldz = lst_z[0]
        #Set the value for curx, cury, curz according to the current readings of the accelerometer
        curx =lst_x[1]
        cury = lst_y[1]
        curz = lst_z[1]

        deltx = curx - oldx
        delty = cury - oldy
        deltz = curz - oldz

        magnitude = math.sqrt(math.pow(deltx,2)+math.pow(delty,2)+math.pow(deltz,2))
        print(magnitude)
        #Accident is detected if the magnitude is greater than the sensitivity
        if ((magnitude>sensitivity)|(accel_data['z']<2)):

            #include the procedure need to be done when an accident is detected
            print("Accident detected")
            
            #responseData = sms.send_message(
            #{
             #   "from": "Vonage APIs",
              #  "to": "+94762819125",
            #"text": "Your emergency contact has met an accident here-> https://www.google.com/maps/search/?api=1&query=9.7670,79.9399. Please help them",
            #}
            #)
           # print("Message sent successfully.")

            #if responseData["messages"][0]["status"] == "0":
             #   print("Message sent successfully karan.")
            #else:
             #   print(f"Message failed with error: {responseData['messages'][0]['error-text']}")
            db.child("accident_check").child("user1").update({"check1":True})
            acc_check = db.child("accident_check").child("user1").get()
            print(acc_check.val())
            time.sleep(10)
            print(acc_check.val()['check2'])
            if (acc_check.val()['check2']==True):
   
                voice = vonage.Voice(client1)

                response = voice.create_call({
                'to': [{'type': 'phone', 'number': "94762819125"}],
                'from': {'type': 'phone', 'number': "94762819125"},
                'ncco': [{'action': 'talk', 'text': 'This is a text to speech call from Nexmo'}]
                })

                print(response)
                URL = "http://807f-54-238-228-170.ngrok.io/find_nearest_users?longtitude=80.63292&latitude=7.2947"
                r = requests.get(url = URL)
  
                # extracting data in json format
                data = r.json()
                print(data)
                db.child("accident_check").child("user1").update({"check1":False})

                break
            else:
                db.child("accident_check").child("user1").update({"check1":False})
                continue

        else:
            magnitude = 0
        
        count=0
        lst_x=[]
        lst_y=[]
        lst_z=[]
    time.sleep(1)

