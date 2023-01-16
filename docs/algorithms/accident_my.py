import time
import math

oldx = 0
oldy = 0
oldz = 0

sensitivity = 20

while(True):

    print("Running")

    #Set the value for curx, cury, curz according to the current readings of the accelerometer
    curx = (int)(input("Enter curx: "))
    cury = (int)(input("Enter cury: "))
    curz = (int)(input("Enter curz: "))

    deltx = curx - oldx
    delty = cury - oldy
    deltz = curz - oldz

    magnitude = math.sqrt(math.pow(deltx,2)+math.pow(delty,2)+math.pow(deltz,2))

    #Accident is detected if the magnitude is greater than the sensitivity
    if magnitude>sensitivity:

        #include the procedure need to be done when an accident is detected
        print("Accident detected")
    else:
        magnitude = 0
        
    time.sleep(0.5)
