#!/usr/bin/env python
import Tkinter as tk
import sys

class FloatingWindow(tk.Tk):
    def __init__(self, *args, **kwargs):
        tk.Tk.__init__(self, *args, **kwargs)
        self.overrideredirect(True)

        self.label = tk.Label(self, text=sys.argv[1], font=('System', 60))
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
        self.geometry("+%s+%s" % (x, y))

app=FloatingWindow()
app.mainloop()
