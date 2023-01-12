from mpu6050 import mpu6050
import time
import serial
import time
import string
import pynmea2
mpu = mpu6050(0x68)
import vonage
#client = vonage.Client(key="a456fe14", secret="HYVqXB2onGxbnbFV")
#client=vclient = vonage.Client(key="af40be87", secret="OboBYxaAyrgJpx9W")
client = vonage.Client(key="af40be87", secret="OboBYxaAyrgJpx9W")
sms = vonage.Sms(client)
accident=True


while True:
    port="/dev/ttyAMA0"
    ser=serial.Serial(port, baudrate=9600, timeout=0.5)
    dataout = pynmea2.NMEAStreamReader()
    try:
        newdata=str(ser.readline(),'utf-8')

        #print(newdata)
        if newdata[0:6] == "$GPRMC":
            newmsg=pynmea2.parse(newdata)
            print("HIIIIIII   "+newdata)
            lat=newmsg.latitude
            lng=newmsg.longitude
            gps = "Latitude=" + str(lat) + "and Longitude=" + str(lng)
            print(gps)
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
        
        
        if (accident):
            responseData = sms.send_message(
            {
                "from": "Vonage APIs",
                "to": "+94762819125",
               "text": "Your emergency contact has met an accident here-> https://www.google.com/maps/search/?api=1&query="+str(lat)+","+str(lng)+". Please help them",
            }
        )

        if responseData["messages"][0]["status"] == "0":
            print("Message sent successfully karan.")
            accident=False
            break

        else:
            print(f"Message failed with error: {responseData['messages'][0]['error-text']}")

        time.sleep(1)
    except:
        continue
   