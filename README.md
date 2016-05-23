Para correrlo simplemente hay que ejecutar octave parado en la carpeta src/ann_terrain y correr la línea run, que es un script que ejecutará la configuración y la creación de la red. También se podrán ver gráficos de el error de training vs la época o de etha vs la época, o el error de testing y de training vs la época.

Para configurar la red editar en el archivo config.m las siguientes variables:

net_arq: arquitectura de la red.
Ej: net_arq = [2 7 7 1];

batch: método de aprendizaje, si vale 1 utiliza batch y si vale 0 incremental.

err: mínimo error para cortar

max_seasons: máxima cantidad de épocas que itera para aprender y mínimo error para cortar

lr: learning rate, se utiliza para determinar si un patrón fue aprendido o no.

tanh_f: función de activación, si vale 1 utiliza la tangente hiperbólica y si vale 0 la exponencial.
betha: coeficiente de la función de activación.

n: etha

alpha: coeficiente de momentum

a,b: coeficientes de eta adaptativo
K: pasos a partir de los cuales se empieza a aumentar eta 

random: si vale 1 aunque la variación del error sea positiva es posible seguir en esa dirección con una probabilidad p (sólo para etha adaptativo)

smart_initialization: si vale 0 la matriz de pesos se inicializa entre minlim y maxlim, sino se inicializa con la estrategia explicada en el informe

training: string con la ubicación del muestreo para entrenar.
testing: string con la ubicación del muestreo para testear.
