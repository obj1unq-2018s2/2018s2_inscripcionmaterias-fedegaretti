import estudiante.*
import universidad.*

class Materia {

	const property carrera
	const creditos
	const property anioQuePertenece
	var curso = #{}

	method prerrequisitos(estudiante)
	
	method agregarEstudiante(estudiante) {
		curso.add(estudiante)
	}

	method sacarEstudiante(estudiante) {
		curso.remove(estudiante)
	}
}

class MateriaCorrelativa inherits Materia {

	const materiasCorrelativas

	override method prerrequisitos(estudiante) =
		 materiasCorrelativas.all{ materia => estudiante.materiasAprobadas().contains(materia) }
	
}

class MateriaPorCreditos inherits Materia {

	const creditosNecesarios

	override method prerrequisitos(estudiante) =
		estudiante.creditos() >= creditosNecesarios

}

class MateriaPorAnio inherits Materia {

	override method prerrequisitos(estudiante) =
		carrera.materias().filter{ 
			materia =>  materia.anioQuePertenece() == self.anioQuePertenece() - 1}.all{
				materia => estudiante.materiasAprobadas().contains(materia)
			}//FALTO SEPARAR EN SUBMETODOS	
}

class MateriaSinPrerrequisito inherits Materia {
	
	override method prerrequisitos(estudiante) {}
}

class MateriaAprobada {

	const materia
	const alumno
	const nota


}