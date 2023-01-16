import cv2
from playsound import playsound
#from pydub import AudioSegment
#from pydub.playback import play
#playsound('stop.mp3')
old_val=""
new_val=""
#import os
#song = AudioSegment.from_wav("/home/pi/Desktop/stop.wav")
#play(song)
import pygame
pygame.mixer.init()



#
# Stop Sign Cascade Classifier xml
stop_sign = cv2.CascadeClassifier('cascade_stop_sign.xml')
yieldsigns = cv2.CascadeClassifier('yeildstages.xml')
speedlimit_sign= cv2.CascadeClassifier('speedlimit.xml')
trafficlight_sign= cv2.CascadeClassifier('trafficlights.xml')
left_turn= cv2.CascadeClassifier('left.xml')

cap = cv2.VideoCapture(0)
cap.set(cv2.CAP_PROP_FRAME_WIDTH, 256)
cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 144)


while cap.isOpened():
    _, img = cap.read()
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    stop_sign_scaled = stop_sign.detectMultiScale(gray, 1.3, 5)
    stop_sign_scaled1 = yieldsigns.detectMultiScale(gray, 1.3, 5)
    speedlimit_scaled = speedlimit_sign.detectMultiScale(gray, 1.3, 5)
    trafficlight_scaled = trafficlight_sign.detectMultiScale(gray, 1.3, 5)
    left_scaled = left_turn.detectMultiScale(gray, 1.3, 5)

    # Detect the stop sign, x,y = origin points, w = width, h = height
    for (x, y, w, h) in stop_sign_scaled:
        
        # Draw rectangle around the stop sign
        stop_sign_rectangle = cv2.rectangle(img, (x,y),
                                            (x+w, y+h),
                                            (0, 255, 0), 3)
        # Write "Stop sign" on the bottom of the rectangle
        stop_sign_text = cv2.putText(img=stop_sign_rectangle,
                                     text="Stop Sign",
                                     org=(x, y+h+30),
                                     fontFace=cv2.FONT_HERSHEY_SIMPLEX,
                                     fontScale=1, color=(0, 0, 255),
                                     thickness=2, lineType=cv2.LINE_4)
        new_val="stop"
        if ((old_val=="")|(new_val!=old_val)):
            pygame.mixer.music.load("/home/pi/Desktop/Sign/stop.wav")
            pygame.mixer.music.play()
            while pygame.mixer.music.get_busy() == True:
                continue
            old_val="stop"
            
        
#         if (detected==0):
#             detected=1
#         if (detected==1):
#          
#             detected=2
            

        # song = AudioSegment.from_wav("stop.mp3")
        # play(song)
        #os.system("/home/pi/Desktop/Sign/stop.mp3")

    for (x, y, w, h) in stop_sign_scaled1:
        # Draw rectangle around the stop sign
        stop_sign_rectangle1 = cv2.rectangle(img, (x,y),
                                            (x+w, y+h),
                                            (0, 255, 0), 3)
        # Write "Stop sign" on the bottom of the rectangle
        stop_sign_text1 = cv2.putText(img=stop_sign_rectangle1,
                                     text="Yield",
                                     org=(x, y+h+30),
                                     fontFace=cv2.FONT_HERSHEY_SIMPLEX,
                                     fontScale=1, color=(0, 0, 255),
                                     thickness=2, lineType=cv2.LINE_4)
        
        new_val="yield"
        if ((old_val=="")|(new_val!=old_val)):
            pygame.mixer.music.load("/home/pi/Desktop/Sign/yield_sign.mp3")
            pygame.mixer.music.play()
            while pygame.mixer.music.get_busy() == True:
                continue
            old_val="yield"
            
        
# #         
#         pygame.mixer.music.load("/home/pi/Desktop/Sign/yield_sign.mp3")
#         pygame.mixer.music.play()
#         while pygame.mixer.music.get_busy() == True:
#             continue
        # song = AudioSegment.from_wav("yeild.mp3")
        # play(song)
        # os.system("yeild.mp3")
    for (x, y, w, h) in speedlimit_scaled:
        # Draw rectangle around the stop sign
        speedlimit_rectangle = cv2.rectangle(img, (x,y),
                                            (x+w, y+h),
                                            (0, 255, 0), 3)
        # Write "Stop sign" on the bottom of the rectangle
        speedlimit_text1 = cv2.putText(img=speedlimit_rectangle,
                                     text="speed limit",
                                     org=(x, y+h+30),
                                     fontFace=cv2.FONT_HERSHEY_SIMPLEX,
                                     fontScale=1, color=(0, 0, 255),
                                     thickness=2, lineType=cv2.LINE_4)
        new_val="speed limit"
        if ((old_val=="")|(new_val!=old_val)):
            pygame.mixer.music.load("/home/pi/Desktop/Sign/Speed Limit.mp3")
            pygame.mixer.music.play()
            while pygame.mixer.music.get_busy() == True:
                continue
            old_val="speed limit"
#         pygame.mixer.music.load("/home/pi/Desktop/Sign/Speed Limit.mp3")
#         pygame.mixer.music.play()
#         while pygame.mixer.music.get_busy() == True:
#             continue

    for (x, y, w, h) in trafficlight_scaled:
        # Draw rectangle around the stop sign
        trafficlights_rectangle = cv2.rectangle(img, (x, y),
                                             (x + w, y + h),
                                             (0, 255, 0), 3)
        # Write "Stop sign" on the bottom of the rectangle
        trafficlights_text1 = cv2.putText(img=trafficlights_rectangle,
                                       text="traffic_light",
                                       org=(x, y + h + 30),
                                       fontFace=cv2.FONT_HERSHEY_SIMPLEX,
                                       fontScale=1, color=(0, 0, 255),
                                       thickness=2, lineType=cv2.LINE_4)
        new_val="traffic_light"
        if ((old_val=="")|(new_val!=old_val)):
            pygame.mixer.music.load("/home/pi/Desktop/Sign/traffic_lights.mp3")
            pygame.mixer.music.play()
            while pygame.mixer.music.get_busy() == True:
                continue
            old_val="traffic_light"
        
#         pygame.mixer.music.load("/home/pi/Desktop/Sign/traffic_lights.mp3")
#         pygame.mixer.music.play()
#         while pygame.mixer.music.get_busy() == True:
#             continue

    for (x, y, w, h) in left_scaled:
        # Draw rectangle around the stop sign
        left_rectangle = cv2.rectangle(img, (x, y),
                                             (x + w, y + h),
                                             (0, 255, 0), 3)
        # Write "Stop sign" on the bottom of the rectangle
        left_text1 = cv2.putText(img=left_rectangle,
                                       text="Left Turn",
                                       org=(x, y + h + 30),
                                       fontFace=cv2.FONT_HERSHEY_SIMPLEX,
                                       fontScale=1, color=(0, 0, 255),
                                       thickness=2, lineType=cv2.LINE_4)
        new_val="Left Turn"
        if ((old_val=="")|(new_val!=old_val)):
            pygame.mixer.music.load("/home/pi/Desktop/Sign/Left Turn.mp3")
            pygame.mixer.music.play()
            while pygame.mixer.music.get_busy() == True:
                continue
            old_val="Left Turn"
#         pygame.mixer.music.load("/home/pi/Desktop/Sign/Left Turn.mp3")
#         pygame.mixer.music.play()
#         while pygame.mixer.music.get_busy() == True:
#             continue


    cv2.imshow("img", img)
    key = cv2.waitKey(30)
    if key == ord('q'):
        cap.release()
        cv2.destroyAllWindows()
        break
