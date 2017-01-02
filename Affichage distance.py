
# -*- coding: utf-8 -*-

from Tkinter import *
import serial
ser=serial.Serial('/dev/ttyACM0', 9600)


class Interface(Frame):


    def __init__(self, root,  **kwargs):
        Frame.__init__(self, root, **kwargs)
        
        self.pack(fill=BOTH)
        self.arret = True

        # Creation de nos widgets

        self.frequence = Label(self, text= "Affichage de la mesure.")
        self.frequence.pack(side="top", padx=5, pady=5)

        self.bouton_cliquer = Button(self, text="Demarrer", command=self.demarrer)
        self.bouton_cliquer.pack(side="left", padx=5, pady=5)
        
        self.bouton_stop = Button(self, text="Stop", command=self.stop)
        self.bouton_stop.pack(side="right", padx=5, pady=5)

    def demarrer(self):
        self.arret = False
        self.MAJ_frequence()
        
    def stop(self):
        self.arret = True
        
    def MAJ_frequence(self):
        if self.arret == False:
            resultat = str(ser.readline())
            resultat = resultat.strip()
            self.frequence["text"] = "La distance entre les deux cartes est de {}.".format(resultat)
            self.update()
            self.after(50, self.MAJ_frequence)
 

root = Tk()
root.title('Mesure distance UWB')
root.geometry('350x70+500+300')

interface = Interface(root)
interface.mainloop()
