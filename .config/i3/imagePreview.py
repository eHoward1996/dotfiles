import tkinter as tk
import os, os.path
from PIL import Image, ImageTk

class App():
    def __init__(self):
        self.root = tk.Tk()
        self.root.config(bg='black', width=800, height=600)
        self.root.resizable(0, 0)
        self.root.bind('<Left>', self.prevImg)
        self.root.bind('<Right>', self.nextImg)
        self.root.bind('q', self.quitProgram)
        self.root.bind('<Return>', self.selectTheme)

        self.picNum_ = 1
        self.picDir_ = '/home/oonebaddog/Pictures/.temp/'
        self.picStr_ = ''
        self.numImages_ = len([self.picDir_ + '' + name for name in os.listdir(self.picDir_)])

        self.img_label = tk.Label(self.root, image=None, bg='black')
        self.img_label.pack()
        
        info = 'Press "q" to quit, <Enter> to select a theme.'
        self.txt_info_label = tk.Label(self.root, text=info, fg='white', bg='black')
        self.txt_info_label.pack()

        self.txt_file_label = tk.Label(self.root, text=None, fg='white', bg='black')
        self.txt_file_label.pack()
        self.showImage()

        self.root.mainloop()

    def showImage(self):
        img = self.loadResizedImg_()
        self.img_label.configure(image=img)
        self.img_label.image = img

        self.txt_file_label.configure(text=self.picStr_)
        self.txt_file_label.text = self.picStr_
        
    def loadResizedImg_(self):
        self.picStr_ = self.picDir_ + 'bg' + str(self.picNum_) + '.png'
        return ImageTk.PhotoImage(Image.open(self.picStr_).resize((800, 600), Image.ANTIALIAS))

    def prevImg(self, event):
        self.picNum_ -= 1
        if self.picNum_ == 0:
            self.picNum_ = self.numImages_
        self.showImage()

    def nextImg(self, event):
        self.picNum_ += 1
        if self.picNum_ > self.numImages_:
            self.picNum_ = 1
        self.showImage()

    def quitProgram(self, event):
        self.root.destroy()

    def selectTheme(self, event):
        print(self.picStr_)
        self.root.destroy()

if __name__ == '__main__':
    app = App()