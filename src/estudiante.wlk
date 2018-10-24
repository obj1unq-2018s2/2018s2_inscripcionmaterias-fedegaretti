import materia.*
import universidad.*

class Estudiante {

	var materiasAprobadas = #{}
	
	var materias = #{} //materias que cursa actualmente
	
	var carreras 
	
	var creditos
	
	
	
	method puedeCursar(materia) = 
		carreras.contains(materia.carrera()) and 
		self.noAproboNiCursa(materia) and 
		materia.prerrequisitos(self)
	
	method noAproboNiCursa(materia) =
		!materiasAprobadas.contains(materia) and !materias.contains(materia)
	
	method aproboMateria(materia){
		
	}
}


