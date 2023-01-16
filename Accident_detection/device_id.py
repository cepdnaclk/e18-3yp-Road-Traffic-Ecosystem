device_id="Device_2"
import pyrebase
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
emergency_details = db.child("emergency").get()
print(emergency_details.val()[uid])