from tkinter import *
from tkinter import filedialog
from tkinter import messagebox
from tkinter.ttk import Progressbar
from pathlib import Path
import cv2
import dlib
from os import scandir
import os

def darCodigoEmocion(nom_imagen):
    #Esta función leera el nombre del archivo, buscará una de las siguientes cadenas
    #y de acuerdo a cual encuentre devolverá un código
    cod = -1

    if nom_imagen.count("angry") > 0:
        cod = 1
    elif nom_imagen.count("contemptuous") > 0:
        cod = 2
    elif nom_imagen.count("disgusted") > 0:
        cod = 3
    elif nom_imagen.count("fearful") > 0:
        cod = 4
    elif nom_imagen.count("happy") > 0:
        cod = 5
    elif nom_imagen.count("neutral") > 0:
        cod = 6
    elif nom_imagen.count("sad") > 0:
        cod = 7
    elif nom_imagen.count("surprise") > 0:
        cod = 8

    return cod

def extraerCaracteristicas(path_load,path_save,generar_x,generar_y):
    #path_load es la ruta donde se almacena el set de entrenamiento/prueba
    #path_save es la ruta donde se guardaran los archivos .txt que contendran las matrices "x" e "y"
    #generar_x archivo booleano que indica si hay que generar la matriz de caracteristicas "x"
    #generar_y archivo booleano que indica si hay que generar la matriz "y"

    detector = dlib.get_frontal_face_detector()
    predictor = dlib.shape_predictor("shape_predictor_68_face_landmarks.dat")

    #NOM_ARCHIVO = "C:\\Users\\charl\\Desktop\\Tesis 2020\\Desarrollo\\pruba\\vector_x.txt"
    if generar_x == True:

        #NOM_ARCHIVO = path_save / "matriz_x.txt"

        if generar_y == True:

            NOM_ARCHIVO = path_save / "matriz_x.txt"
            NOM_ARCHIVO_2 = path_save / "matriz_y.txt"
            file_2 = open(NOM_ARCHIVO_2,"w")
        else:
            NOM_ARCHIVO = path_save / "set_prediccion.txt"

        file_1 = open(NOM_ARCHIVO,"w")

        imagenes = [obj.name for obj in scandir(path_load) if obj.is_file()]

        #print(str(len(imagenes)))
        val_ini = 0
        val_max = len(imagenes)
        val_up  = 100/val_max


        for imagen in imagenes:

            val_ini = val_ini + val_up
            v_bar.set(val_ini)
            window.update()

            path_imagen = path_load / imagen

            #1) Leo la imagen de la ruta
            imagen = cv2.imread(str(path_imagen))

            #2) Convierto la imagen a escala de grises
            gray = cv2.cvtColor(imagen, cv2.COLOR_BGR2GRAY)

            #3) Detecto el rostro/s
            rostros = detector(gray)

            for rostro in rostros:

                x1 = rostro.left()
                y1 = rostro.top()
                x2 = rostro.right()
                y2 = rostro.bottom()

                linea = ""

                #obtengo los landmarks
                landmarks = predictor(gray, rostro)

                for i in range(0,68):
                    x = landmarks.part(i).x
                    y = landmarks.part(i).y

                    if i == 67:
                        linea = linea + str(x) + "," + str(y)
                    else:
                        linea = linea + str(x) + "," + str(y) +","

                linea = linea + os.linesep
                file_1.write(linea)

                if generar_y == True:

                    codigo_emocion = darCodigoEmocion(str(path_imagen))

                    file_2.write(str(codigo_emocion)+os.linesep)


        file_1.close()
        file_2.close()

        return "EC_SUCCESS"


def eventoCargarPath():
    path = filedialog.askdirectory()

    try:
        path = path
    except:
        path = 'error_path'

    if path != 'error_path':
        tb_ruta_set.insert(0,path)
    else:
        messagebox.showerror('Error','Ocurrio un error al cargar la ruta indicada')

def eventoCargarPathTarget():
    path = filedialog.askdirectory()

    try:
        path = path
    except:
        path = 'error_path'

    if path != 'error_path':
        tb_ruta_target.insert(0,path)
    else:
        messagebox.showerror('Error','Ocurrio un error al cargar la ruta indicada')

def eventoGenerarArchivos():

    #recupero el valor de los elementos
    estado_chk_x = chk_state_x.get()
    estado_chk_y = chk_state_y.get()
    path_origen = Path(tb_ruta_set.get())
    path_destino = Path(tb_ruta_target.get())
    texto_1 = extraerCaracteristicas(path_origen,path_destino,estado_chk_x,estado_chk_y)

    if texto_1 =="EC_SUCCESS":
        messagebox.showinfo('¡Atención!','Archivos generados correctamente')



window = Tk()
fuente_default="comic sans"
tamanio_default= 12
chk_state_x = IntVar()
chk_state_y = IntVar()
v_bar = DoubleVar()

chk_state = BooleanVar()

window.title("Predictor de emociones v1.0")

lbl_ruta_set = Label(window,text="Path origen: ",font=(fuente_default,tamanio_default))
tb_ruta_set = Entry(window,font=(fuente_default,tamanio_default),width=40)
btn_cargar_ruta = Button(window,text="...",font=(fuente_default,tamanio_default),command=eventoCargarPath)

lbl_ruta_target = Label(window,text="Path destino: ",font=(fuente_default,tamanio_default))
tb_ruta_target = Entry(window,font=(fuente_default,tamanio_default),width=40)
btn_cargar_ruta_target = Button(window,text="...",font=(fuente_default,tamanio_default),command=eventoCargarPathTarget)

chk_mat_x = Checkbutton(window, text='Matriz x',font=(fuente_default,tamanio_default), variable = chk_state_x)
chk_mat_y = Checkbutton(window, text='Matriz y',font=(fuente_default,tamanio_default), variable = chk_state_y)

btn_gen_files = Button(window, text = 'Generar', font = (fuente_default,tamanio_default), command=eventoGenerarArchivos)

v_bar.set(0)
pbar = Progressbar(window,length=60,orient="horizontal",variable=v_bar,mode="determinate")

v_col_span = 10

lbl_ruta_set.grid(sticky=W,columnspan=3,padx=10,pady=5)
tb_ruta_set.grid(row=1,columnspan=v_col_span,padx=10,sticky="ew")
btn_cargar_ruta.grid(row=1,column=v_col_span + 1,columnspan=1,padx=2)

lbl_ruta_target.grid(sticky=W,columnspan=3,padx=10,pady=5)
tb_ruta_target.grid(row=3,columnspan=v_col_span,padx=10,sticky="ew")
btn_cargar_ruta_target.grid(row=3,column=v_col_span + 1,columnspan=1,padx=2)

chk_mat_x.grid(sticky=W,row=5,padx=10)
chk_mat_y.grid(sticky=W,row=5,column=2)

#sticky = "nsew" -> el componente se expande en todas direcciones north, south, east y weast
#sticky = "ew" -> el componente se expande en forma horizantal
#sticky = "ns" -> el componente se expande en forma vertical

btn_gen_files.grid(row=6,padx=10,pady=10,columnspan=v_col_span+2,sticky="ew")

pbar.grid(row=7,padx=10,pady=5,columnspan=v_col_span+2,sticky="ew")

window.mainloop()
