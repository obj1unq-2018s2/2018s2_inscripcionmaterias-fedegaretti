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
			// TODO Valida la misma condicion dos veces, podría evitarse.
		}else if(estudiante.puedeCursar(self) and !self.hayCupo()){
			self.ponerEnEspera(estudiante)
			estudiante.ponerMateriaEnEspera(self)
		}
	}
	method darDeBaja(estudiante){
		curso.remove(estudiante) // TODO Falta dar de baja en los datos que maneja el estudiante.
		self.anotarProximoEstudiante()
	}
	method anotarProximoEstudiante(){
		self.inscribir(listaDeEspera.first())
		self.sacarDeEspera(listaDeEspera.first()) // TODO Falta actualizar los datos que maneja el estudiante.
	}
	method estudiantesInscriptos() = curso
	method estudiantesEnListaDeEspera() = listaDeEspera 
}
class MateriaCorrelativa inherits Materia {

	const materiasCorrelativas

	override method prerrequisitos(estudiante) =
		 super(estudiante) and materiasCorrelativas.all{ 
		 	materia => estudiante.aproboMateria(materia)
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
		// TODO Podría delegar en carrera. 
			materia =>  materia.anioQuePertenece() == self.anioQuePertenece() - 1
			}
	method estudianteAproboMaterias(materias, estudiante) = 
	// TODO Falta delegación.
		materias.all{materia => estudiante.materiasAprobadas().contains(materia)}
}

class MateriaAprobada {

	const property materia
	const estudiante // TODO Este atributo no se usa!
	const property nota
}