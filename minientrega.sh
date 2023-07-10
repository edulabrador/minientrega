#! /bin/bash
#Compruebo el numero de argumentos, si es distinto de 1, lanzo el error
if [ $# -ne 1 ]
then
	echo "minientrega.sh: Error(EX_USAGE), uso incorrecto del mandato."Success""
	echo "minientrega.sh+ el script fue  invocado  con un numero de argumentos distinto a 1"
	exit 64
fi
#Compruebo si la entrada es una solicitud de ayuda, y ejecuto el codigo de ayuda
if [ $1 == "--help" ] || [ $1 == "-h" ]
then
	echo "minientrega.sh: Uso: minientrega.sh argumento"
	echo "minientrega.sh: Copia una entrega de un usuario en el directorio correscpondiente, con una previa comprobacion"
		
	exit 0
fi


#Compruebo si  existe y si es legible, si no lo es lanzo un error
if [ ! -r $MINIENTREGA_CONF ]
  then
   echo "minientrega.sh: Error, no se pudo realizar la entrega" >&2
 	echo "minientrega.sh+ no es accesible el directorio" >&2
    exit 64
fi
#Compruebo si es un directorio, si no lo es lanzo un error
if [ ! -d $MINIENTREGA_CONF ]
  then
   echo "minientrega.sh: Error, no se pudo realizar la entrega" >&2
 	echo "minientrega.sh+ no es accesible el directorio" >&2
    exit 64
fi

#Compruebo si existe y si es legible, si no lo es lanzo un error
if [ ! -r ${MINIENTREGA_CONF}/$1 ]
then
	echo "minientrega.sh: Error, no se pudo realizar la entrega" >&2
 	echo "minientrega.sh+ no es accesible el directorio" >&2
	exit 64
fi

source ${MINIENTREGA_CONF}/$1

#Compruebo si son existen y si son legibles todos los archivos de la entrada, si no lo es lanzo un error
for FICHERO in $MINIENTREGA_FICHEROS
do
if [ ! -r $FICHERO ]
then
	echo "minientrega.sh: Error, no se pudo realizar la entrega" >&2
 	echo "minientrega.sh+ no es accesible el fichero" >&2
	exit 66
fi
done

#Compruebo si existe el directorio, si no lo es lanzo un error
if [ ! -d $MINIENTREGA_DESTINO ]
then
	echo "minientrega.sh: Error, no se pudo realizar la entrega" >&2
 	echo "minientrega.sh+ no es accesible el fichero" >&2
   exit 73
fi
#Compruebo si  existe y puedo escribir en el directorio (crear el subdirectorio), si no lo es lanzo un error
if [ ! -w $MINIENTREGA_DESTINO ]
then
	echo "minientrega.sh: Error, no se pudo realizar la entrega" >&2
 	echo "minientrega.sh+ no se pudo crear el subdirectorio de entrega" >&2
	exit 73
fi

#Creo el nuevo directorio de entrega con el nombre de usuario (un subdirectorio)
mkdir -p $MINIENTREGA_DESTINO/$USER


#Copio todos los ficheros para la entrega
for FICHERO in $MINIENTREGA_FICHEROS
do
    cp $FICHERO $MINIENTREGA_DESTINO/$USER
done

exit 0
