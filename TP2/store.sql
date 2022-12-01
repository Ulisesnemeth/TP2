/*
 * Suponga que se desea verificar mensualmente si los planes de cada uno de los usuarios estan
al d ıa con los pagos y, en funci ́on de eso, actualizar el plan como activo o inactivo. Cree el
procedimiento almacenado correspondiente, y proponga los criterios a tener en cuenta para
pasar un plan de activo a inactivo.
 * 
 */
CREATE PROCEDURE pago_mensuales AS
update suscripcion set Estado=1  WHERE CAST(Fecha_Vto AS date) > CONVERT(DATE, GETDATE())
/*ejecuto*/
EXEC pago_mensuales

/*Cree un procedimiento almacenado que reciba como par ́ametros un usuario y una contrase ̃na,
y devuelva 1 si el login es correcto (es decir, coincide usuario, contrase ̃na, y el plan est ́a activo)
y 0 en cualquier otro caso.
 * */


CREATE PROCEDURE login_usuario_p @usuario VARCHAR, @clave VARCHAR 
AS 
IF (SELECT count(*) FROM usuario INNER JOIN suscripcion ON  suscripcion.Id_Usuario = usuario.id
WHERE Usuario= @usuario AND Clave = @clave ) > 0 BEGIN
	return 1
	END
ELSE
BEGIN
	return 0
END
EXEC login_usuario_p 'daniel', 'pppp';
