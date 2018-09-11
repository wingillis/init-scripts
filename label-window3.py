#!/usr/bin/env python
import sys
import tkinter as tk

root = tk.Tk()
label = tk.Label(root, text=sys.argv[1], font=('System', 50))
label.pack(expand=True)

root.mainloop()
