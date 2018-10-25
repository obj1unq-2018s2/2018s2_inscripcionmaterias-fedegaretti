import estudiante.*
import carrera.*

class Materia {

	const property carrera
	const property creditos
	const property anioQuePertenece
	const cupo
	var listaDeEspera = []
	var curso = #{}//Conjunto de alumnos que cursan la materia

	method prerrequisitos(estudiante) = estudiante.cursaCarrera(carrera)
	
	method hayCupo() = cupo > curso.size()
	
	method ponerEnEspera(estudiante){
		listaDeEspera.add(estudiante)
	}
	method sacarDeEspera(estudiante){
		listaDeEspera.remove(estudiante)
	}
	
	method inscribir(estudiante) {
		if(estudiante.puedeCursar(self) and self.hayCupo()){
			estudiante.inscribirseAMateria(self)
			curso.add(estudiante)
		}else if(estudiante.puedeCursar(self) and !self.hayCupo()){
			self.ponerEnEspera(estudiante)
			estudiante.ponerMateriaEnEspera(self)
		}
	}
	method darDeBaja(estudiante){
		curso.remove(estudiante)
		self.anotarProximoEstudiante()
	}
	method anotarProximoEstudiante(){
		self.inscribir(listaDeEspera.first())
		self.sacarDeEspera(listaDeEspera.first())
	}
	method estudiantesInscriptos() = curso
	method estudiantesEnListaDeEspera() = listaDeEspera 
}
class MateriaCorrelativa inherits Materia {

	const materiasCorrelativas

	override method prerrequisitos(estudiante) =
		 super(estudiante) and materiasCorrelativas.all{ 
		 	materia => estudiante.materiasAprobadas().contains(materia)
		 }
	
}

class MateriaPorCreditos inherits Materia {

	const creditosNecesarios

	override method prerrequisitos(estudiante) =
		super(estudiante) and estudiante.creditos() >= creditosNecesarios

}

class MateriaPorAnio inherits Materia {

	override method prerrequisitos(estudiante) =
		super(estudiante) and self.estudianteAproboMaterias(self.materiasDeAnioAnterior(), estudiante)
	
	method materiasDeAnioAnterior() = carrera.materias().filter{ 
			materia =>  materia.anioQuePertenece() == self.anioQuePertenece() - 1
			}
	method estudianteAproboMaterias(materias, estudiante) = 
		materias.all{materia => estudiante.materiasAprobadas().contains(materia)}
}

class MateriaAprobada {

	const property materia
	const estudiante
	const property nota
}