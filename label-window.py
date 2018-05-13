#!/usr/bin/env python
import tkinter as tk
import sys

class FloatingWindow(tk.Frame):
    def __init__(self, master=None):
        self.master = master
        super().__init__(master)
        self.master.overrideredirect(True)
        # self.overrideredirect(True)

        self.label = tk.Label(master, text=sys.argv[1], font=('System', 60))
        self.label.pack(fill="both", expand=True)

        self.label.bind("<ButtonPress-1>", self.StartMove)
        self.label.bind("<ButtonRelease-1>", self.StopMove)
        self.label.bind("<B1-Motion>", self.OnMotion)

    def StartMove(self, event):
        self.x = event.x
        self.y = event.y

    def StopMove(self, event):
        self.x = None
        self.y = None

    def OnMotion(self, event):
        deltax = event.x - self.x
        deltay = event.y - self.y
        x = self.winfo_x() + deltax
        y = self.winfo_y() + deltay
        self.master.geometry("+%s+%s" % (x, y))

root = tk.Tk()
app=FloatingWindow(master=root)
app.mainloop()
