import materia.*
import carrera.*

class Estudiante {

	const materiasAprobadas  
	const materiasQueCursa  
	const materiasEnEspera
	const carreras 
	var creditos
	method inscribirseAMateria(materia){
		materiasQueCursa.add(materia)
	}
	
	method puedeCursar(materia) = 
		self.noAproboNiCursa(materia) and 
		materia.prerrequisitos(self)
	
	method noAproboNiCursa(materia) =
		!materiasAprobadas.contains(materia) and !materiasQueCursa.contains(materia)
		
	method cursaCarrera(carrera) = carreras.contains(carrera)
	
	method aproboMateria(materia,nota){
		var materiaAprobada = new MateriaAprobada(materia = materia, estudiante = self, nota = nota)
		if(!materiasAprobadas.any{ mate => mate.materia() == materiaAprobada.materia()}){
			materiasAprobadas.add(materiaAprobada)
			creditos += materia.creditos()
		}
	}
	method materiasALasQueSePuedeInscribir(carrera) =
		carrera.materias().filter{materia => self.puedeCursar(materia)}
	
	method materiasALasQueEstaInscripto() = materiasQueCursa
	
	method materiasEnListaDeEspera() = materiasEnEspera
	
	method ponerMateriaEnEspera(materia) {
		materiasEnEspera.add(materia)
	}
	
}


