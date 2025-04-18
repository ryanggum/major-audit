
// types/type-user.ts

export interface AbstractCourse {
	id: number;
	codes: string[];
  title: string;
  description: string;
  requirements: string;
  credits: number;
  distributions: string[];
  is_colsem: boolean;
  is_fysem: boolean;
}

export interface CourseOffering {
  term: string;
  professors: string[];
  flags: string[];
  codes: string[]; 
  abstractCourse: AbstractCourse;
}

export interface StudentCourse {
	id: number;
  status: string; 										// "DA" || "MA"
  result: string;											// "A-C" || "CR" || "D/F/W"
  term: string;
  courseOffering: CourseOffering;
}

export interface FYP {
	studentCourses: StudentCourse[];
	languagePlacement: string;
	studentTermArrangement: string;
}

export interface User {
	name: string;
	netID: string;
	FYP: FYP;
}

export interface MajorsIndex {
	prog: string; 	// e.g. "CPSC"
	deg: number; 
	conc: number;
}

// export interface StudentConc {
// 	name: string;
// 	status: number;
// 	// concentration: DegreeConcentration;
// 	concentration_majors_index: MajorsIndex;
// 	selected_subreqs: Record<number, number[]>;
// }
