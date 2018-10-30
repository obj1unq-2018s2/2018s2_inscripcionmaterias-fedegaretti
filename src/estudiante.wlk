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
	
	method puedeCursar(materia) { 
		//self.noAproboNiCursa(materia)
		not self.aproboMateria(materia) 
		and not self.cursaMateria(materia) 
		and not self.cursaCarrera(materia.carrera())
		materia.prerrequisitos(self)
	}
		
	method cursaCarrera(carrera) = carreras.contains(carrera)
	
	method cursaMateria(materia) = materiasQueCursa.contains(materia)
	
	method aproboMateria(materia) = materiasAprobadas.any {
		materiaAprobada => materiaAprobada.materia() == materia
	}
	
	method registrarAprobacion(materia,nota){
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


