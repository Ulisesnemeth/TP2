/*Suponga que se desea verificar mensualmente si los planes de cada uno de los usuarios estan
al d ıa con los pagos y, en funci ́on de eso, actualizar el plan como activo o inactivo. Cree el
procedimiento almacenado correspondiente, y proponga los criterios a tener en cuenta para
pasar un plan de activo a inactivo. */


use webapp;
CREATE PROCEDURE procedure_pagos_mensuales AS
update suscripcion set Estado=1  WHERE CAST(suscripcion.Fecha_Vto AS date) > CONVERT(DATE, GETDATE())
update suscripcion set Estado=0  WHERE CAST(suscripcion.Fecha_Vto AS date) < CONVERT(DATE, GETDATE())
/*ejecuto*/
EXEC procedure_pagos_mensuales

/*Cree un procedimiento almacenado que reciba como par ́ametros un usuario y una contrase ̃na,
y devuelva 1 si el login es correcto (es decir, coincide usuario, contrase ̃na, y el plan est ́a activo)
y 0 en cualquier otro caso.*/

use webapp;
CREATE PROCEDURE procedurelo @usuario VARCHAR(40), @clave VARCHAR(40) 
AS 
IF (SELECT count(*) FROM usuario INNER JOIN suscripcion ON  suscripcion.Id_Usuario = usuario.id WHERE Usuario= @usuario AND Clave = @clave
AND ( CAST(suscripcion.Fecha_Vto AS date) > CONVERT(DATE, GETDATE())
)) > 0 
	BEGIN
		SELECT  1
	END
ELSE
	BEGIN
		SELECT 0
	END
/*EJECUTO EL PROCEDIMIENTO
 * */
EXEC procedurelo 'ulisesnemeth', 'pass1234';

use webapp;
CREATE proc cargarpelicula @nombre VARCHAR(40), @genero VARCHAR(40), @esATP BIT, @tieneSubtitulos BIT
as 
if (select count(*) from peliculas WHERE Nombre = @nombre)>0
begin
	Select 'La pelicula ya está en la lista'
end
else
	begin
	if (select count(Id) from genero WHERE Descripcion = @genero)>0
		begin
			set @genero = (select top(1) Id from genero WHERE Descripcion = @genero)
			insert into peliculas values (@genero,@nombre,@esATP,@tieneSubtitulos)
		end
	else
		begin
			insert into genero values (@genero)
			set @genero = (select Id from genero WHERE Descripcion = @genero)
			insert into peliculas values (@genero,@nombre,@esATP,@tieneSubtitulos)
		end
end

EXEC cargarpelicula @nombre = 'El Conjuro 11', @genero = 'Terror', @esATP = 0, @tieneSubtitulos = 1;
