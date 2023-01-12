from mpu6050 import mpu6050
import time
import math
mpu = mpu6050(0x68)
lst_x=[]
lst_y=[]
lst_z=[]
count=0
sensitivity = 12

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
        if magnitude>sensitivity:

            #include the procedure need to be done when an accident is detected
            print("Accident detected")
            break
        else:
            magnitude = 0
        
        count=0
        lst_x=[]
        lst_y=[]
        lst_z=[]
    time.sleep(1)

